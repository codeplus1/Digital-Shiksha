import 'package:digitization/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogPage extends StatelessWidget {
  final String? title;
  final String? description;
  final String? image;
  final String? createdAt;

  const BlogPage(
      {Key? key, this.title, this.description, this.image, this.createdAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image
            Image.network(image!),
            // Title and description
            ListTile(
              // title: Text(
              //   title!,
              //   style: const TextStyle(
              //       fontWeight: FontWeight.w800, fontSize: 20),
              // ),
              subtitle: InteractiveViewer(
                child: Html(
                  style: {
                    "body": Style(
                      letterSpacing: 0.5,
                      fontSize: const FontSize(18),
                    ),
                  },
                  data: description!,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
