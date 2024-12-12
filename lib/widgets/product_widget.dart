import 'package:flutter/material.dart';
import 'package:workshop/models/product_model.dart';

class ProductWidget extends StatelessWidget {
  final ProductModel productModel;
  const ProductWidget({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.02, vertical: size.height * 0.005),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: size.height * 0.15,
                width: size.width * 0.3,
                child: Image.network(
                  productModel.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.error),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              productModel.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              "\$${productModel.price.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
