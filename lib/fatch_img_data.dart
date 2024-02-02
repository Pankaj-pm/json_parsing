import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:json_parsing/api_helper.dart';
import 'package:json_parsing/pixabay_model.dart';

class FatchImgData extends StatefulWidget {
  const FatchImgData({super.key});

  @override
  State<FatchImgData> createState() => _FatchImgDataState();
}

class _FatchImgDataState extends State<FatchImgData> {
  var parse = Uri(scheme: "https", host: "pixabay.com", path: "api", queryParameters: {
    "key": "42123171-51231a30c65e62f23fa607de4",
    "q": "yellow+flowers",
    "image_type": "photo",
    "pretty": "true",
    "page": "1"
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ApiHelper().getApiDataWithUrl(parse),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var data = pixabayModelFromJson(snapshot.data ?? "");
            return ListView.builder(
              itemCount: data.hits?.length ?? 0,
              itemBuilder: (context, index) {
                var hit = data.hits![index];
                return ListTile(
                  onTap: () {
                    setWallpaper(hit.previewUrl??"");
                  },
                  leading: Image.network(hit.previewUrl ?? "", height: 200, width: 100, fit: BoxFit.cover),
                  title: Text(hit.tags ?? ""),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var parse = Uri(scheme: "https", host: "pixabay.com", path: "api", queryParameters: {
            "key": "42123171-51231a30c65e62f23fa607de4",
            "q": "yellow+flowers",
            "image_type": "photo",
            "pretty": "true"
          });

          print(parse);
        },
      ),
    );
  }

  void setWallpaper(String url) {
    AsyncWallpaper.setWallpaper(
      url: url,
      wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
      goToHome: true,
      toastDetails: ToastDetails.success(),
      errorToastDetails: ToastDetails.error(),
    );
  }
}
