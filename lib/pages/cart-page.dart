import 'dart:convert';

import 'package:bill_app/components/master-page.dart';
import 'package:bill_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> foundEvent = [];
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final url = Uri.https(
        'salabeauty-da77b-default-rtdb.firebaseio.com', 'Product.json');
    final respone = await http.get(url);
    print(respone.body);
    final Map<String, dynamic> listData = json.decode(respone.body);
    List<Product> listProduct = [];
    for (var item in listData.entries) {
      listProduct.add(Product(
          id: item.key, name: item.value['name'], image: item.value['image']));
    }
    setState(() {
      foundEvent = listProduct;
    });
  }

  void runFilter(String enteredKeywword) {
    print(enteredKeywword);
    List<Product> results = [];
    if (enteredKeywword.isEmpty) {
      results = foundEvent;
    } else {
      results = foundEvent
          .where((event) =>
              event.name!.toLowerCase().contains(enteredKeywword.toLowerCase()))
          .toList();
    }
    setState(() {
      foundEvent = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterPage(
      title: "Giỏ hàng",
      body: Column(children: [
        // Container(
        //   margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
        //   decoration: const BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.all(Radius.circular(10)),
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey,
        //           offset: Offset(0, 1),
        //           blurRadius: 1.0,
        //           spreadRadius: 1.0,
        //           blurStyle: BlurStyle.normal,
        //         )
        //       ]),
        //   child: TextField(
        //     controller: searchController,
        //     onChanged: (value) => runFilter(value),
        //     decoration: InputDecoration(
        //       prefixIcon: Icon(Icons.search),
        //       hintText: "Search",
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(10),
        //         borderSide: BorderSide.none,
        //       ),
        //     ),
        //   ),
        // ),
        // Container(
        //   margin: const EdgeInsets.all(10),
        //   height: 1,
        //   color: Colors.grey,
        // ),
        Expanded(
          child: ListView.builder(
            // scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: foundEvent.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(66, 126, 123, 123),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(foundEvent[index].image ?? '',
                              width: 100.0, fit: BoxFit.contain),
                        ),
                      ),
                      // Image.network(
                      //   listCart[index].image ?? '',
                      // ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(foundEvent[index].name ?? 'Nails'),
                            Text('Giá sản phẩm'),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.remove),
                                ),
                                Text('1'),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
