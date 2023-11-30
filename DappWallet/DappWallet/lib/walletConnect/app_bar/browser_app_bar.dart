// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'webview_tab_app_bar.dart';

class BrowserAppBar extends StatefulWidget implements PreferredSizeWidget {
  const BrowserAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  State<BrowserAppBar> createState() => _BrowserAppBarState();

  @override
  final Size preferredSize;
}

class _BrowserAppBarState extends State<BrowserAppBar> {
  @override
  Widget build(BuildContext context) {
    return WebViewTabAppBar();
  }
}
