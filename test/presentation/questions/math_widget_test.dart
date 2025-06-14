import 'package:beta/presentation/questions/math_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';

void main() {
  group('MathWidget Tests', () {
    testWidgets('renders basic Markdown text correctly', (tester) async {
      const testData = 'This is **bold** text';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MathWidget(data: testData),
          ),
        ),
      );

      expect(find.byType(MarkdownBody), findsOneWidget);
      expect(find.text('This is bold text'), findsOneWidget);
    });

    testWidgets('replaces <br> tags with newlines', (tester) async {
      const testData = 'Line1<br>Line2';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MathWidget(data: testData),
          ),
        ),
      );

      // Verify the MarkdownBody receives the transformed data
      final markdownBody =
          tester.widget<MarkdownBody>(find.byType(MarkdownBody));
      expect(markdownBody.data, 'Line1\nLine2');
    });

    testWidgets('configures LaTeX builders and extensions', (tester) async {
      const testData = r'$\sqrt{x}$';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MathWidget(data: testData),
          ),
        ),
      );

      final markdownBody =
          tester.widget<MarkdownBody>(find.byType(MarkdownBody));

      // Verify LaTeX builder is registered
      expect(markdownBody.builders['latex'], isA<LatexElementBuilder>());

      // Verify extension set contains LaTeX syntaxes
      expect(
          markdownBody.extensionSet!.blockSyntaxes
              .any((s) => s is LatexBlockSyntax),
          isTrue);
      expect(
          markdownBody.extensionSet!.inlineSyntaxes
              .any((s) => s is LatexInlineSyntax),
          isTrue);
    });

    testWidgets('handles empty string input', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MathWidget(data: ''),
          ),
        ),
      );

      expect(find.byType(MarkdownBody), findsOneWidget);
      // Should render without errors
    });

    testWidgets('handles complex LaTeX expressions', (tester) async {
      const testData = r'$$\int_a^b f(x)dx$$';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MathWidget(data: testData),
          ),
        ),
      );

      expect(find.byType(MarkdownBody), findsOneWidget);
      // Actual LaTeX rendering would be verified by flutter_markdown_latex package
    });

    testWidgets('handles mixed Markdown and LaTeX', (tester) async {
      const testData =
          'This is a paragraph with **bold** text and \$x^2\$ math.';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: MathWidget(data: testData),
          ),
        ),
      );

      expect(find.byType(MarkdownBody), findsOneWidget);
      expect(
          find.text('This is a paragraph with bold text and '), findsOneWidget);
    });
  });
}
