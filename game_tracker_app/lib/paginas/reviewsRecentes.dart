import 'package:flutter/material.dart';
import 'package:game_tracker_app/controladores/ControladorReview.dart';
import 'package:game_tracker_app/Review.dart';

class ReviewsRecentes extends StatefulWidget {
  @override
  State<ReviewsRecentes> createState() => _ReviewsRecentes();
}

class _ReviewsRecentes extends State<ReviewsRecentes> {
  ControladorReview ctrlReview = ControladorReview();
  late Future<List<Review>> allReviews = ctrlReview.getTodasReviews();
  List<Review> reviewsRecentes = [];

  DateTime semanaAnterior = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}