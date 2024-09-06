import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_search/models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio _dio = Dio();
  List<Product> _products = [];

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData({String? searchText}) async {
    String url = "https://freetestapi.com/api/v1/products";

    if (searchText != null) {
      url += "?search=$searchText";
    }
    Response res = await _dio.get(url);
    List<Product> products = [];
    if (res.data != null) {
      for (var p in res.data) {
        products.add(Product.fromJson(p));
      }
    }
    setState(() {
      _products = products;
    });
  }

  // void _loadData({String? searchText}) async {
  //   String url = "https://freetestapi.com/api/v1/products";
  //   if (searchText != null) {
  //     url += "?search=$searchText";
  //   }
  //   Response res = await _dio.get(url);
  //   List<Product> products = [];
  //   if (res.data != null) {
  //     for (var p in res.data) {
  //       products.add(Product.fromJson(p));
  //     }
  //   }
  //   setState(() {
  //     _products = products;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'E-commerce',
          style: TextStyle(fontSize: 28),
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return SizedBox(
      child: Column(
        children: [
          _searchBar(),
          productsListView(),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.80,
      child: TextField(
        onChanged: (value) {
          _loadData(searchText: value);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(28)),
          labelText: 'Search',
        ),
      ),
    );
  }

  Widget productsListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          Product product = _products[index];
          return ListTile(
            title: Text(
              product.name,
              style: const TextStyle(fontSize: 18),
            ),
            subtitle: Text("${product.brand} ~ \$${product.price.toString()}"),
            trailing: Text(
              "${product.rating.toString()}⭐",
              style: const TextStyle(fontSize: 16),
            ),
            leading: Image.network(product.image),
          );
        },
      ),
    );
  }
}
