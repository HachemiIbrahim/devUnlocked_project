import 'dart:convert'; // Needed for JSON decoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workshop/models/product_model.dart';
import 'package:workshop/screens/detailed_screen.dart';
import 'package:workshop/widgets/product_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory; // Keeps track of the currently selected category

  // Function to fetch categories
  Future<List<String>> fetchCategories() async {
    try {
      final response = await http.get(
        Uri.parse("https://fakestoreapi.com/products/categories"),
      );
      if (response.statusCode == 200) {
        return List<String>.from(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load categories");
      }
    } catch (error) {
      debugPrint("Error fetching categories: $error");
      return [];
    }
  }

  // Function to fetch products
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final uri = selectedCategory == null
          ? Uri.parse("https://fakestoreapi.com/products")
          : Uri.parse(
              "https://fakestoreapi.com/products/category/$selectedCategory");

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> productList = jsonDecode(response.body);
        return productList
            .map(
              (product) => ProductModel.fromJson(product),
            )
            .toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (error) {
      debugPrint("Error fetching products: $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's find your",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "Exclusive Outfit",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
            ),
            SizedBox(height: size.height * 0.01),
            // Categories FutureBuilder
            FutureBuilder<List<String>>(
              future: fetchCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Error loading categories",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No categories found"));
                } else {
                  final categories = snapshot.data!;
                  return SizedBox(
                    height: size.height * 0.05,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.01),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCategory = category;
                              });
                            },
                            child: Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3),
                              ),
                              label: Text(category),
                              backgroundColor: isSelected
                                  ? Colors.black
                                  : const Color(0xffF3F4F6),
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xff4B5563),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
            SizedBox(
                height: size.height *
                    0.01), // Adjust this value to control the space
            // Products FutureBuilder
            Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Error loading products",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No products found"));
                  } else {
                    final products = snapshot.data!;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailedScreen(productModel: product),
                              ),
                            );
                          },
                          child: ProductWidget(productModel: product),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
