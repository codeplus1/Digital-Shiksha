import 'package:digitization/const/const.dart';
import 'package:digitization/pages/blog_details_page.dart';
import 'package:flutter/material.dart';

Widget blogBox(BuildContext context, String title, String description,
    String image, String createdat) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlogPage(
            title: title, //constructor
            description: description,
            image: image,
          ),
        ),
      );
    },
    child: Card(
      color: cardcolor,
      child: ListTile(
        leading: SizedBox(
          height: 55,
          width: 55,
          child: Image.network(
            image, //yo constructor wala image ho jaslie interpolation pani vanna milxa
            fit: BoxFit.fitHeight,
          ),
        ),
        title: Text(
          title, //constructor
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Text('updated ' + createdat),
        trailing: const Icon(
          Icons.arrow_right,
          size: 20,
        ),
      ),
    ),
  );
}
