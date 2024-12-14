import 'package:flutter/material.dart'; // Importing Flutter's material design library
import 'package:workshop/models/product_model.dart'; // Importing the ProductModel class

// A stateless widget that displays a product's information in a card format
class ProductWidget extends StatelessWidget {
  final ProductModel productModel; // The product data to display in the widget
  const ProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context)
        .size; // Fetching the screen size for responsive design

    return Card(
      // A material design card to display content with an elevated effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3), // Rounded corners for the card
      ),
      color: Colors.white, // Background color of the card
      elevation: 2, // Slight shadow effect to give depth to the card
      child: Padding(
        // Adds padding around the content inside the card
        padding: EdgeInsets.symmetric(
          horizontal:
              size.width * 0.02, // Horizontal padding based on screen width
          vertical:
              size.height * 0.005, // Vertical padding based on screen height
        ),
        child: Column(
          // Arranges the content vertically
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns children to the start (left)
          children: [
            Center(
              // Centers the image horizontally
              child: SizedBox(
                // A box with fixed dimensions for the product image
                height: size.height *
                    0.15, // Image height is responsive to screen height
                width: size.width *
                    0.3, // Image width is responsive to screen width
                child: Image.network(
                  productModel
                      .image, // Loads the product image from a network URL
                  fit: BoxFit
                      .contain, // Ensures the image fits inside its container
                  errorBuilder: (context, error, stackTrace) => const Center(
                    // Displays an error icon if the image fails to load
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
            SizedBox(
              height:
                  size.height * 0.02, // Spacing between the image and the title
            ),
            Text(
              productModel.title, // Displays the product title
              maxLines: 2, // Limits the title to 2 lines
              overflow:
                  TextOverflow.ellipsis, // Adds ellipsis if the text overflows
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600, // Medium-bold font weight
                    fontSize: 14, // Font size for the title
                  ),
            ),
            SizedBox(
              height:
                  size.height * 0.01, // Spacing between the title and the price
            ),
            Text(
              "\$${productModel.price.toStringAsFixed(2)}", // Displays the product price
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600, // Medium-bold font weight
                    fontSize: 14, // Font size for the price
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
