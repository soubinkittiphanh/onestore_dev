import 'package:flutter/material.dart';

class Products {
  final int id;
  final String title, description;
  final String images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Products({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
}

// Our demo Productss

List<Products> demoProducts = [
  Products(
    id: 1,
    images:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjsjc9Rn5gLVgfBI6yYatm4k2_rrJ-7Cxzyg&usqp=CAU',
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Products(
    id: 2,
    images:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2lvom4h8wTBS5w6gk_QWKz-pBIHY5mTpmDg&usqp=CAU',
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Nike Sport White - Man Pant",
    price: 50.5,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  Products(
    id: 3,
    images:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXL4FJGcH0rLNa3jyk9M7JoGCtgnSsLlPvEA&usqp=CAU',
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Gloves XC Omega - Polygon",
    price: 36.55,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Products(
    id: 4,
    images:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlu0rxqTmzCxUt_XjT4zPTJ_BnGeSAL3CEnw&usqp=CAU',
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
  Products(
    id: 5,
    images:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbtsT3pYpL3Q-XoNI5ENx9my4K5O4XTMd3tQ&usqp=CAU',
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
  Products(
    id: 6,
    images:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJFeo_HgaquVVAue_cSCo4BRTtxdVeOLW4Wg&usqp=CAU',
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "Logitech Head",
    price: 20.20,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
