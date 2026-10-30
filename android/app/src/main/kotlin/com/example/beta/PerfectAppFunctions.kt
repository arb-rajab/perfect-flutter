package edu.perfect

import android.app.PendingIntent
import android.content.Intent
import android.net.Uri
import androidx.annotation.RequiresApi
import androidx.appfunctions.AppFunctionAppUnknownException
import androidx.appfunctions.AppFunctionDeclaration
import androidx.appfunctions.AppFunctionElementNotFoundException
import androidx.appfunctions.AppFunctionInvalidArgumentException
import androidx.appfunctions.AppFunctionSerializable
import androidx.appfunctions.AppFunctionService
import androidx.appfunctions.AppFunctionServiceEntryPoint
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.TimeoutCancellationException
import kotlinx.coroutines.withTimeout

// AppFunctions that let Gemini (and other agents with EXECUTE_APP_FUNCTIONS) answer from the
// content the user unlocked in Perfect. Android 16+ only; the KSP compiler generates
// PerfectAppFunctionService (declared in AndroidManifest.xml) and its schema from this file.
// The work happens in Dart, through AssistantBridge; see AssistantChannel for the contract.

/** A piece of study content from Perfect that matches a search. */
@AppFunctionSerializable(isDescribedByKDoc = true)
data class ContentResult(
    /** Kind of content: question, flashcard, faq, term (a lesson), ebook or news. */
    val type: String,
    /** The question, the front of the flashcard, the FAQ question, or the lesson, ebook or news title. */
    val title: String,
    /**
     * Answer text from the app: the correct answers of a question, the back of a flashcard, the
     * answer of a FAQ, or an excerpt of a lesson, ebook or news item.
     */
    val answer: String,
    /** Link that opens this content in Perfect, for openContent. */
    val link: String,
)

/** The outcome of a search in Perfect. */
@AppFunctionSerializable(isDescribedByKDoc = true)
data class ContentSearchResult(
    /** False when no unlocked content matches; results is then empty and Perfect has no answer. */
    val matched: Boolean,
    /** Plain-language summary of the outcome. */
    val message: String,
    /** Up to five matches, best match first. */
    val results: List<ContentResult>,
)

/** The outcome of opening content in Perfect. */
@AppFunctionSerializable(isDescribedByKDoc = true)
data class OpenContentResult(
    /**
     * "opened" when the content is unlocked; "locked" or "expired" when Perfect shows how to
     * unlock it instead.
     */
    val status: String,
    /** Plain-language summary of what Perfect shows. */
    val message: String,
    /** Opens Perfect on the content, or on its unlock screen. */
    val intentToOpen: PendingIntent,
)

@RequiresApi(36)
@AppFunctionServiceEntryPoint(
    serviceName = "PerfectAppFunctionService",
    appFunctionXmlFileName = "perfect_app_function_service",
)
abstract class BasePerfectAppFunctionService : AppFunctionService() {
    /**
     * Searches the study content the user has unlocked in Perfect (questions with their correct
     * answers, flashcards, lessons, ebooks, FAQs and news) and returns the answer text. Locked and
     * expired content is never searched.
     *
     * @param query The question or words to look up. The content is mostly in Arabic.
     * @return Up to five matches, best match first; matched is false when nothing matches.
     */
    @AppFunctionDeclaration(isDescribedByKDoc = true)
    suspend fun searchContent(query: String): ContentSearchResult {
        if (query.isBlank()) throw AppFunctionInvalidArgumentException("query is empty")
        val response = callAssistant("search", mapOf("query" to query))
        val results = (response["results"] as? List<*>).orEmpty().filterIsInstance<Map<*, *>>().map {
            ContentResult(
                type = it["type"] as? String ?: "",
                title = it["title"] as? String ?: "",
                answer = it["answer"] as? String ?: "",
                link = it["deepLink"] as? String ?: "",
            )
        }
        return ContentSearchResult(
            matched = response["status"] == "ok" && results.isNotEmpty(),
            message = response["message"] as? String ?: "",
            results = results,
        )
    }

    /**
     * Opens content in Perfect. Perfect checks access again when it opens: content that was
     * locked since the search opens its unlock screen instead.
     *
     * @param link A link from searchContent, such as perfect://question/12.
     * @return An intent that opens Perfect on the content, with its status.
     */
    @AppFunctionDeclaration(isDescribedByKDoc = true)
    suspend fun openContent(link: String): OpenContentResult {
        val response = callAssistant("open", mapOf("deepLink" to link))
        val message = response["message"] as? String ?: ""
        val status = response["status"] as? String
        when (status) {
            "invalid" -> throw AppFunctionInvalidArgumentException(message)
            "unavailable" -> throw AppFunctionElementNotFoundException(message)
        }
        val deepLink = response["deepLink"] as? String ?: link
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(deepLink))
            .setClass(this, MainActivity::class.java)
            .addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        return OpenContentResult(
            status = status ?: "opened",
            message = message,
            intentToOpen = PendingIntent.getActivity(
                this,
                0,
                intent,
                PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT,
            ),
        )
    }

    /** Agents only see AppFunctionExceptions, so other failures are wrapped in one. */
    private suspend fun callAssistant(method: String, arguments: Map<String, Any?>): Map<*, *> =
        try {
            // A cold start opens the encrypted database, which can take a few seconds.
            withTimeout(15_000) { AssistantBridge.call(this@BasePerfectAppFunctionService, method, arguments) }
        } catch (e: TimeoutCancellationException) {
            throw AppFunctionAppUnknownException("Perfect took too long to read its content.")
        } catch (e: CancellationException) {
            throw e
        } catch (e: Exception) {
            throw AppFunctionAppUnknownException(
                "Perfect could not read its content. Open the app once and try again. (${e.message})",
            )
        }
}
