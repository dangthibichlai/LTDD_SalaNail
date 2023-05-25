// ignore_for_file: file_names

import 'package:bill_app/components/master-page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailProductPage extends StatelessWidget {
  // static const routerName = '/detail-product';
  String? name;
  String? image;
  String? price;
  String? description;
  String? id;

  DetailProductPage(
    String? image,
    String? name,
    String? description,
    double? price,
    String? id, {
    super.key,
  }) {
    this.id = id;
    this.name = name;
    this.image = image;
    this.price = price.toString();
    this.description = description;
  }
  @override
  Widget build(BuildContext context) {
    return MasterPage(
        title: name,
        body: Column(
          children: [
            Image.network(image ?? ''),
            Text(name ?? ''),
            Text(price ?? ''),
            Text(description ?? ''),
          ],
        ));
  }
}
