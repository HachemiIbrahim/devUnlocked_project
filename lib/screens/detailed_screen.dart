import 'package:flutter/material.dart'; // Flutter framework for UI components
import 'package:flutter_rating/flutter_rating.dart'; // Package for displaying star ratings
import 'package:workshop/models/product_model.dart'; // Importing the product model

// Stateless widget for displaying detailed product information
class DetailedScreen extends StatelessWidget {
  final ProductModel productModel; // Product details passed to this screen
  const DetailedScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final size =
        MediaQuery.of(context).size; // Get the screen size for responsiveness

    return Scaffold(
      backgroundColor: Colors.white, // Set the background color of the screen
      appBar: AppBar(
        backgroundColor: Colors.white, // AppBar background color
        forceMaterialTransparency: true, // Make the AppBar transparent
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.03), // Add horizontal padding
        child: SingleChildScrollView(
          // Allows scrolling for smaller screens
          child: Column(
            children: [
              // Display product image
              SizedBox(
                height:
                    size.height * 0.45, // Set height to 45% of screen height
                child: Image.network(
                  productModel.image, // Product image URL
                  fit:
                      BoxFit.contain, // Ensure the image fits within its bounds
                  // Show an error icon if the image fails to load
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.03), // Add vertical spacing

              // Display star rating and rating count
              Row(
                children: [
                  StarRating(
                    rating:
                        productModel.rating.rate, // Display the average rating
                    allowHalfRating: true, // Allow half-star ratings
                  ),
                  Text(
                      "(${productModel.rating.count})"), // Display the number of reviews
                ],
              ),
              SizedBox(height: size.height * 0.03), // Add vertical spacing

              // Display product title and price
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, // Space out elements
                children: [
                  // Display the product title with a maximum width of 50% of the screen
                  SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                      productModel.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w700, // Bold font weight
                            fontSize: 20, // Font size
                          ),
                    ),
                  ),
                  // Display the product price
                  Text(
                    "\$${productModel.price.toStringAsFixed(2)}", // Format the price to 2 decimal places
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700, // Bold font weight
                          fontSize: 20, // Font size
                        ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03), // Add vertical spacing

              // Display product description
              Text(
                productModel.description, // Product description text
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w400, // Regular font weight
                      fontSize: 16, // Font size
                    ),
              ),
              SizedBox(height: size.height * 0.03), // Add vertical spacing

              // "Add to Cart" button
              ElevatedButton(
                onPressed: () {
                  // Logic for adding product to cart goes here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Button background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  minimumSize:
                      Size(size.width, size.height * 0.06), // Button size
                ),
                child: Text(
                  "Add to Cart", // Button label
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white, // Text color
                        fontSize: 20, // Font size
                        fontWeight: FontWeight.bold, // Bold font weight
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
