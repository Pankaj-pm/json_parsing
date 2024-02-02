import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:json_parsing/api_helper.dart';
import 'package:json_parsing/pixabay_model.dart';
import 'package:json_parsing/user_res_model.dart';
import 'package:json_parsing/users_model.dart';

class FatchpostData extends StatefulWidget {
  const FatchpostData({super.key});

  @override
  State<FatchpostData> createState() => _FatchpostDataState();
}

class _FatchpostDataState extends State<FatchpostData> {
  TextEditingController nc = TextEditingController();
  TextEditingController ec = TextEditingController();
  TextEditingController pc = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextFormField(
            controller: nc,
            decoration: InputDecoration(hintText: "Name"),
          ),
          TextFormField(
            controller: ec,
            decoration: InputDecoration(hintText: "email"),
          ),
          TextFormField(
            controller: pc,
            decoration: InputDecoration(hintText: "Password"),
          ),
          StatefulBuilder(
            builder: (context, setState) {
              return Row(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        isLoading=true;
                        setState(() {});
                        String? response = await ApiHelper().post("https://reqres.in/api/users", {
                          "name": nc.text,
                          "job": "leader",
                          "email": ec.text,
                          "pass": pc.text,
                        });
                        isLoading=false;
                        setState(() {});
                        if (response != null) {
                          var userResModel = userResModelFromJson(response);
                        }

                        print(response);
                      },
                      child: Text("Reg")),
                  if (isLoading) CircularProgressIndicator()
                ],
              );
            },
          ),
          Expanded(
            child: FutureBuilder(
              future: ApiHelper().getApiDataWithUrl(Uri.parse("https://reqres.in/api/users")),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  var usermodelres = usersModelFromJson(snapshot.data ?? "");

                  return ListView.builder(
                    itemCount: usermodelres.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      var user = usermodelres.data![index];
                      return ListTile(
                        onTap: () {},
                        leading: Image.network(user.avatar ?? "", height: 200, width: 100, fit: BoxFit.cover),
                        title: Text("${user.firstName ?? ""} ${user.lastName ?? ""}".trim()),
                        subtitle: Text(user.email ?? ""),
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
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
