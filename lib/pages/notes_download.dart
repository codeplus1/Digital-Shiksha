import 'dart:convert';
import 'package:digitization/Api/api.dart';
import 'package:digitization/const/const.dart';
import 'package:digitization/widgets/loading_effect.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NotesDownload extends StatefulWidget {
  const NotesDownload({Key? key}) : super(key: key);

  @override
  _NotesDownloadState createState() => _NotesDownloadState();
}

class _NotesDownloadState extends State<NotesDownload> {
  Future getNotes() async {
    var response = await Api().getData('download');
    var data = json.decode(response.body)['data'];
    return data;
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Download'),
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data == null
              ? Center(
                  child: loadingEffect(),
                )
              : ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var mydata = snapshot.data[index];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              onTap: () {
                                _launchURL(mydata['document']);
                              },
                              title: Text(mydata['title']),
                              subtitle: Text(mydata['created_at']),
                              trailing: Icon(
                                Icons.download_for_offline_sharp,
                                size: 30,
                                color: primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
