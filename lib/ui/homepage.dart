import 'package:flutter/material.dart';
import 'package:vidstream/constants/string.dart';
import 'package:vidstream/mux/mux_client.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MUXClient _muxClient = MUXClient();

  TextEditingController? _textControllerVideoURL;
  FocusNode? _textFocusNodeVideoURL;

  @override
  void initState() {
    super.initState();
    _muxClient.initializeDio();
    _textControllerVideoURL = TextEditingController(text:demoVideoUrl);
    _textFocusNodeVideoURL = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}