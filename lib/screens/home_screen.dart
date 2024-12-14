import 'dart:convert'; // Import for decoding JSON data
import 'package:flutter/material.dart'; // Flutter framework for building UI
import 'package:http/http.dart'
    as http; // HTTP package for making network requests
import 'package:workshop/models/product_model.dart'; // Custom model for products
import 'package:workshop/screens/detailed_screen.dart'; // Screen for detailed product view
import 'package:workshop/widgets/product_widget.dart'; // Widget for displaying individual products

// Stateful widget for the Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key}); // Key for widget identification

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable to store the currently selected category
  String? selectedCategory;

  // Function to fetch product categories from the API
  Future<List<String>> fetchCategories() async {
    try {
      // Sending a GET request to fetch categories
      final response = await http.get(
        Uri.parse("https://fakestoreapi.com/products/categories"),
      );

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Decode JSON response into a list of strings
        return List<String>.from(jsonDecode(response.body));
      } else {
        // Throw an exception if the response fails
        throw Exception("Failed to load categories");
      }
    } catch (error) {
      // Log errors if the request fails
      debugPrint("Error fetching categories: $error");
      return [];
    }
  }

  // Function to fetch products based on the selected category
  Future<List<ProductModel>> fetchProducts() async {
    try {
      // Build the URL based on whether a category is selected
      final uri = selectedCategory == null
          ? Uri.parse("https://fakestoreapi.com/products")
          : Uri.parse(
              "https://fakestoreapi.com/products/category/$selectedCategory");

      // Send a GET request to fetch products
      final response = await http.get(uri);

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Decode JSON response into a list of dynamic objects
        final List<dynamic> productList = jsonDecode(response.body);

        // Map each product to a ProductModel and return the list
        return productList
            .map(
              (product) => ProductModel.fromJson(product),
            )
            .toList();
      } else {
        // Throw an exception if the response fails
        throw Exception("Failed to load products");
      }
    } catch (error) {
      // Log errors if the request fails
      debugPrint("Error fetching products: $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size for responsive design
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true, // Transparent AppBar
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title text
            Text(
              "Let's find your",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
            ),
            SizedBox(height: size.height * 0.01), // Spacing
            Text(
              "Exclusive Outfit",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
            ),
            SizedBox(height: size.height * 0.01), // Spacing

            // FutureBuilder to fetch and display categories
            FutureBuilder<List<String>>(
              future: fetchCategories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show loading indicator while fetching data
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  // Show error message if fetching fails
                  return const Center(
                    child: Text(
                      "Error loading categories",
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                  // Show message if no categories are found
                  return const Center(child: Text("No categories found"));
                } else {
                  // Build a horizontal list of categories
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
                              // Update selected category and reload products
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
            SizedBox(height: size.height * 0.01), // Spacing

            // FutureBuilder to fetch and display products
            Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show loading indicator while fetching data
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Show error message if fetching fails
                    return const Center(
                      child: Text(
                        "Error loading products",
                        style: TextStyle(color: Colors.red),
                      ),
                    );
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    // Show message if no products are found
                    return const Center(child: Text("No products found"));
                  } else {
                    // Build a grid of products
                    final products = snapshot.data!;
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items per row
                        childAspectRatio: 0.8, // Aspect ratio of each item
                        mainAxisSpacing: 2, // Vertical spacing between items
                        crossAxisSpacing: 8, // Horizontal spacing between items
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the detailed screen on product tap
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
