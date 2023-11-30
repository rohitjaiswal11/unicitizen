import 'package:flutter/material.dart';

abstract class BaseExample extends StatefulWidget {
  final String title;

  const BaseExample(this.title, {Key? key}) : super(key: key);

  @override
  BaseExampleState createState();
}

abstract class BaseExampleState<T extends BaseExample> extends State<T> {
  List<String> logs = [];

  void showLog(String log) {
    logs.add(log);
  }

  Widget _buildLogs() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Text(
          logs[index],
          style: TextStyle(fontSize: 12),
        );
      },
      itemCount: logs.length,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildLogs(),
    );
  }
}
