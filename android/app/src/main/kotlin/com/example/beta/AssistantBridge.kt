package edu.perfect

import android.content.Context
import com.tekartik.sqflite.SqflitePlugin
import dev.fluttercommunity.plus.device_info.DeviceInfoPlusPlugin
import dev.fluttercommunity.plus.packageinfo.PackageInfoPlugin
import io.flutter.FlutterInjector
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.suspendCancellableCoroutine
import kotlinx.coroutines.withContext

/**
 * Calls the Dart "assistant" MethodChannel (lib/application/services/assistant_channel.dart)
 * on a headless engine that runs `assistantMain` (lib/main.dart).
 *
 * AppFunctions run in a service, often with no activity and so no UI engine, for example when
 * Gemini starts the app in the background. The engine is started on the first call and kept for
 * the life of the process; calls wait until Dart reports "ready".
 */
object AssistantBridge {
    private const val CHANNEL = "assistant"
    private const val ENTRYPOINT = "assistantMain"

    private var channel: MethodChannel? = null
    private var ready = false
    private val pending = mutableListOf<(MethodChannel) -> Unit>()

    /** Invokes [method] and returns Dart's result map; throws if Dart fails. */
    suspend fun call(context: Context, method: String, arguments: Map<String, Any?>): Map<*, *> =
        withContext(Dispatchers.Main) {
            suspendCancellableCoroutine { continuation ->
                whenReady(context.applicationContext) { channel ->
                    channel.invokeMethod(method, arguments, object : MethodChannel.Result {
                        override fun success(result: Any?) {
                            if (result is Map<*, *>) {
                                continuation.resume(result)
                            } else {
                                continuation.resumeWithException(
                                    IllegalStateException("$method returned $result"),
                                )
                            }
                        }

                        override fun error(code: String, message: String?, details: Any?) {
                            continuation.resumeWithException(IllegalStateException(message ?: code))
                        }

                        override fun notImplemented() {
                            continuation.resumeWithException(
                                IllegalStateException("$method is not implemented"),
                            )
                        }
                    })
                }
            }
        }

    private fun whenReady(context: Context, action: (MethodChannel) -> Unit) {
        val channel = channel ?: start(context)
        if (ready) action(channel) else pending.add(action)
    }

    private fun start(context: Context): MethodChannel {
        // Only the plugins assistantMain uses: shared_preferences (cached FAQs and news),
        // device_info_plus and package_info_plus (the database key) and sqflite (the
        // database folder). Registering every plugin would attach plugins such as
        // audio_service and firebase_messaging to a second engine.
        val engine = FlutterEngine(context, null, /* automaticallyRegisterPlugins = */ false)
        engine.plugins.add(SharedPreferencesPlugin())
        engine.plugins.add(DeviceInfoPlusPlugin())
        engine.plugins.add(PackageInfoPlugin())
        engine.plugins.add(SqflitePlugin())

        val channel = MethodChannel(engine.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            if (call.method == "ready") {
                ready = true
                pending.forEach { it(channel) }
                pending.clear()
            }
            result.success(null)
        }
        engine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(
                FlutterInjector.instance().flutterLoader().findAppBundlePath(),
                ENTRYPOINT,
            ),
        )
        this.channel = channel
        return channel
    }
}
