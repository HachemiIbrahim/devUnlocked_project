// Represents a product with its details such as id, title, price, description, category, image, and rating.
class ProductModel {
  final int id; // Unique identifier for the product
  final String title; // Name or title of the product
  final double price; // Price of the product
  final String description; // Description of the product
  final String category; // Category to which the product belongs
  final String image; // URL for the product image
  final Rating rating; // Rating object containing the rating value and count

  // Constructor to initialize all fields of the ProductModel class
  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  // Factory constructor to create a ProductModel instance from a JSON object
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'], // Assign the id from the JSON object
      title: json['title'], // Assign the title from the JSON object
      price: json['price']
          .toDouble(), // Convert price to a double (in case it's not)
      description:
          json['description'], // Assign the description from the JSON object
      category: json['category'], // Assign the category from the JSON object
      image: json['image'], // Assign the image URL from the JSON object
      rating: Rating.fromJson(json[
          'rating']), // Create a Rating object from the JSON 'rating' field
    );
  }
}

// Represents the rating details of a product, including the rating value and the number of ratings.
class Rating {
  final double rate; // Average rating value of the product
  final int count; // Total number of ratings the product has received

  // Constructor to initialize all fields of the Rating class
  Rating({
    required this.rate,
    required this.count,
  });

  // Factory constructor to create a Rating instance from a JSON object
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate']
          .toDouble(), // Convert rate to a double (in case it's not)
      count: json['count'], // Assign the count from the JSON object
    );
  }
}
