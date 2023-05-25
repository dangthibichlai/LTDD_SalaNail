import 'dart:convert';

import 'package:bill_app/pages/resources/app-color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/master-page.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../provider/Products_provider.dart';

// ignore: must_be_immutable
class AblumSanPhamPagePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AblumSanPhamPagePage({super.key});

  @override
  State<AblumSanPhamPagePage> createState() => _AblumSanPhamPagePageState();
}

class _AblumSanPhamPagePageState extends State<AblumSanPhamPagePage> {
  List<Product> findList = [];
  List<Product> products = listCart;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    findList = products;
  }

  void runFlitter(String content) {
    print(content);
    List<Product> result = [];
    if (content.isEmpty) {
      result = products;
    } else {
      result = products
          .where((element) =>
              element.name!.toLowerCase().contains(content.toLowerCase()))
          .toList();
    }
    setState(() {
      findList = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);
    // final products = productData.items;

    return MasterPage(
      title: 'Album sản phẩm',
      body: Column(
        children: [
         
          Expanded(
            child: GridView.builder(
              itemCount: findList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
              ),
              itemBuilder: (BuildContext context, int index) => SanPham(
                findList[index].id,
                findList[index].image,
                findList[index].name,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SanPham extends StatelessWidget {
  String? id;
  String? image;
  String? name;
  SanPham(String? id, String? image, String? name, {super.key}) {
    this.id = id;
    this.image = image;
    this.name = name;
  }
  void addCart(String name, String image) {
    final url = Uri.https(
        'salabeauty-da77b-default-rtdb.firebaseio.com', 'Product.json');
    final respone = http.post(url,
        body: json.encode({
          'image': image,
          'name': name,
        }));
    print(respone);
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(
        // ignore: sort_child_properties_last
        child: GestureDetector(
          onTap: () {
            // Navigator.of(context)
            //     .pushNamed(DetailProductPage, arguments: id);
            // print(id);
          },
          child: Image.network(
            image ?? '',
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: const Color.fromARGB(255, 251, 210, 230),
          // leading: IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.favorite_border_outlined),
          // ),
          title: Text(
            name ?? '',
            textAlign: TextAlign.center,
          ),
          // trailing: IconButton(
          //   onPressed: () {
          //     addCart(name ?? '', image ?? '');
          //   },
          //   icon: const Icon(Icons.shopping_cart_outlined),
          // ),
        ));
  }
}
