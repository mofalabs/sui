import 'package:example/model/page_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:flutter_highlight/themes/googlecode.dart';

class InfoPage extends StatefulWidget {
  final PageInfo info;

  const InfoPage(this.info, {super.key});

  @override
  State<StatefulWidget> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  var showCode = false;
  var code = '';

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('lib/pages/share/${widget.info.path}').then((value) {
      setState(() {
        code = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.info.title),
        actions: [
          Visibility(
            visible: showCode,
            child: IconButton(
              icon: const Icon(Icons.copy_outlined),
              onPressed: () {
                if (code.isNotEmpty) {
                  Clipboard.setData(ClipboardData(text: code));
                  Fluttertoast.showToast(
                    msg: 'copied!'
                  );
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.code),
            onPressed: () {
              setState(() {
                showCode = !showCode;
              });
            },
          ),
        ],
      ),
      body: showCode && code.isNotEmpty ? buildMarkdown() : widget.info.content,
    );
  }

  Widget buildMarkdown() {
    return MarkdownWidget(
      data: '```\n'
          '$code\n'
          '```',
      config: MarkdownConfig(
        configs: [
          const PreConfig(theme: googlecodeTheme),
        ],
      ),
    );
  }
}
