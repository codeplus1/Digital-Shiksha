import 'dart:convert';

import 'package:flutter/material.dart';

import '../Api/api.dart';
import '../models/blog.dart';
import '../widgets/blog_box.dart';
import '../widgets/loading_effect.dart';

Future<List<Blog>> getBlogs(String? text) async {
  var response = await Api().getData('blog');
  var data = json.decode(response.body)['data'];
  final dat = (data as List).map((e) => Blog.fromJson(e)).toList();
  final searchData = dat
      .where((element) => element.title.toLowerCase().contains(text!.trim()))
      .toList();
  return searchData;
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? searchText;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: searchController,
              decoration: const InputDecoration(hintText: 'Search'),
              onFieldSubmitted: (val) {
                if (val.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('please provide searchText')));
                } else {
                  setState(() {
                    searchText = val;
                    searchController.clear();
                  });
                }
              },
            ),
            const SizedBox(
              height: 25,
            ),
            if (searchText != null)
              Expanded(
                child: FutureBuilder<List<Blog>>(
                  future: getBlogs(searchText),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: loadingEffect(),
                      );
                    }
                    if ((snapshot.data as List).isEmpty) {
                      return const Center(
                        child: Text('Try using another keyword'),
                      );
                    }
                    if (snapshot.hasData) {
                      return snapshot.data == null
                          ? Center(
                              child: loadingEffect(),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                Blog mydata = snapshot.data[index];
                                return blogBox(
                                    context,
                                    mydata.title,
                                    mydata.description,
                                    mydata.image,
                                    mydata.created_at);
                              },
                            );
                    } else if (snapshot.hasError) {
                      return const Text('Check Your Wifi Connection');
                    } else {
                      return Center(
                        child: loadingEffect(),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    ));
  }
}
