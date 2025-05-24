import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:markdown/markdown.dart' as md;

class MathWidget extends StatelessWidget {
  final String data;

  const MathWidget({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: data.replaceAll('<br>', '\n'),
      builders: {
        'latex': LatexElementBuilder(),
      },
      extensionSet: md.ExtensionSet(
        [
          LatexBlockSyntax(),
          // const md.HtmlBlockSyntax(), // Add HTML block support
        ],
        [
          LatexInlineSyntax(),
          // md.InlineHtmlSyntax(),
        ],
      ),
    );
  }
}
