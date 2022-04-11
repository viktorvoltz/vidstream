import 'package:flutter/material.dart';
import 'package:vidstream/constants/string.dart';
import 'package:vidstream/models/asset_data.dart';
import 'package:vidstream/services/mux/mux_client.dart';
import 'package:intl/intl.dart';
import 'package:vidstream/widget/video_tile.dart';

class View extends StatelessWidget {
  final MUXClient? muxCient;

  const View({Key? key, this.muxCient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Expanded(
      child: FutureBuilder<AssetData?>(
        future: muxCient!.getAssetList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            AssetData assetData = snapshot.data!;
            int length = assetData.data!.length;

            return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: length,
              itemBuilder: (context, index) {
                DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                    int.parse(assetData.data![index].createdAt!) * 1000);
                DateFormat formatter = DateFormat.yMd().add_jm();
                String dateTimeString = formatter.format(dateTime);

                String currentStatus = assetData.data![index].status!;
                bool isReady = currentStatus == 'ready';

                String? playbackId =
                    isReady ? assetData.data![index].playbackIds![0].id : null;

                String? thumbnailURL = isReady
                    ? '$muxImageBaseUrl/$playbackId/$imageTypeSize'
                    : null;

                return VideoTile(
                  assetData: assetData.data![index],
                  thumbnailUrl: thumbnailURL!,
                  isReady: isReady,
                  dateTimeString: dateTimeString,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(
                height: 16.0,
              ),
            );
          }
          return const Text(
            'No videos present',
            style: TextStyle(
              color: Colors.black45,
            ),
          );
        },
      ),
    ));
  }
}
