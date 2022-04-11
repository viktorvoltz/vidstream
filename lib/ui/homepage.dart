import 'package:flutter/material.dart';
import 'package:vidstream/constants/colors.dart';
import 'package:vidstream/constants/string.dart';
import 'package:vidstream/services/mux/mux_client.dart';
import 'package:vidstream/widget/view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MUXClient _muxClient = MUXClient();

  late TextEditingController _textControllerVideoURL;
  late FocusNode _textFocusNodeVideoURL;

  @override
  void initState() {
    super.initState();
    _muxClient.initializeDio();
    _textControllerVideoURL = TextEditingController(text:demoVideoUrl);
    _textFocusNodeVideoURL = FocusNode();
  }

  @override
  Widget build(BuildContext context) {

    bool isProcessing = false;

    return GestureDetector(
      onTap: () {
        _textFocusNodeVideoURL.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          brightness: Brightness.dark,
          title: Text('Mux stream'),
          backgroundColor: CustomColors.muxPink,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: CustomColors.muxPink.withOpacity(0.06),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 16.0,
                  right: 16.0,
                  bottom: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'UPLOAD',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0,
                      ),
                    ),
                    TextField(
                      focusNode: _textFocusNodeVideoURL,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      style: TextStyle(
                        color: CustomColors.muxGray,
                        fontSize: 16.0,
                        letterSpacing: 1.5,
                      ),
                      controller: _textControllerVideoURL,
                      cursorColor: CustomColors.muxPinkLight,
                      autofocus: false,
                      onSubmitted: (value) {
                        _textFocusNodeVideoURL.unfocus();
                      },
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomColors.muxPink,
                            width: 2,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black26,
                            width: 2,
                          ),
                        ),
                        labelText: 'Video URL',
                        labelStyle: const TextStyle(
                          color: Colors.black26,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        hintText: 'Enter the URL of the video to upload',
                        hintStyle: const TextStyle(
                          color: Colors.black12,
                          fontSize: 12.0,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    isProcessing
                        ? Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Processing . . .',
                                  style: TextStyle(
                                    color: CustomColors.muxPink,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    CustomColors.muxPink,
                                  ),
                                  strokeWidth: 2,
                                )
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Container(
                              width: double.maxFinite,
                              child: RaisedButton(
                                color: CustomColors.muxPink,
                                onPressed: () async {
                                  setState(() {
                                    isProcessing = true;
                                  });
                                  await _muxClient.storeVideo(
                                      videoUrl: _textControllerVideoURL.text);
                                  setState(() {
                                    isProcessing = false;
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    top: 12.0,
                                    bottom: 12.0,
                                  ),
                                  child: Text(
                                    'send',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      letterSpacing: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
            // ...
            View(muxCient: _muxClient,)
          ],
        ),
      ),
    );
  }
}