import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_parsing/fatch_data.dart';
import 'package:json_parsing/fatch_img_data.dart';
import 'package:json_parsing/fatch_post_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic>? jsonDecodeData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Student 1  = ${jsonDecodeData?["name"] ?? ""}',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: (jsonDecodeData?["sub"] as List?)?.length ?? 0,
                itemBuilder: (context, index) {
                  var list = (jsonDecodeData!["sub"] as List).map((e) => e as Map<String, dynamic>).toList();
                  var cl = (list[index]["chap"] as List).map((e) => "$e").toList();
                  print(cl.runtimeType);
                  return ListTile(
                    title: Text("${list[index]["sub_name"]}"),
                    trailing: Text("${list[index]["mark"]}"),
                    subtitle: Wrap(
                      children: cl.map((e) => ActionChip(label: Text(e))).toList(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // String data =
          //     "{\"name\":\"S1\",\"sub\":[{\"sub_name\":\"Flutter\",\"mark\":10,\"chap\":[\"c1\",\"c2\",\"chap11\",\"chap88\"]},{\"sub_name\":\"c\",\"mark\":8,\"chap\":[\"c8\",\"c6\",\"ch11\"]},{\"sub_name\":\"c++\",\"mark\":8,\"chap\":[\"c8\",\"c2\"]}]}";
          // jsonDecodeData = jsonDecode(data);
          // print(jsonDecodeData?["name"]);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => FatchImgData(),
          //     ));

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FatchpostData(),
              ));

          //  var fileData=await rootBundle.loadString("assets/sample_data.json");
          //  var fileDatas=await rootBundle.loadString("assets/student_data.json");
          //  jsonDecodeData = jsonDecode(fileDatas);
          //
          //  var fd = jsonDecode(fileData);
          //
          //  print(fileData);
          //  print(fd["fruit"]);
          //
          // setState(() {
          //
          // });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
