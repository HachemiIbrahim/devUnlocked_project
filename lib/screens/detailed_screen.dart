import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:workshop/models/product_model.dart';

class DetailedScreen extends StatelessWidget {
  final ProductModel productModel;
  const DetailedScreen({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.45,
              child: Image.network(
                productModel.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              children: [
                StarRating(
                  rating: productModel.rating.rate,
                  allowHalfRating: true,
                ),
                Text("(${productModel.rating.count})"),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width * 0.5,
                  child: Text(
                    productModel.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                  ),
                ),
                Text(
                  "\$${productModel.price.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              productModel.description,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
            ),
            SizedBox(height: size.height * 0.03),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(size.width, size.height * 0.06)),
                child: Text(
                  "Add to Cart",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ))
          ],
        ),
      ),
    );
  }
}
