import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter_highlight/themes/googlecode.dart';

class Markdown extends StatelessWidget {
  final String data;
  final bool needPrefix;

  const Markdown(this.data, {super.key, this.needPrefix = false});

  @override
  Widget build(BuildContext context) {
    return MarkdownWidget(
      data: needPrefix
          ? '```\n'
              '$data\n'
              '```'
          : data,
      physics: needPrefix ? null : const NeverScrollableScrollPhysics(),
      shrinkWrap: !needPrefix,
      padding: const EdgeInsets.all(0),
      config: MarkdownConfig(
        configs: [
          const PreConfig(theme: googlecodeTheme),
        ],
      ),
    );
  }
}
