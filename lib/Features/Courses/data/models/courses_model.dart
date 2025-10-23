import 'package:flutter/material.dart';

class CoursesModel {
    String? tag;
    String? tagIcon;
    String? title;
    String? subtitle;
    String? category;
    Color? categoryColor;
    double? rating;
    String? price;
    List<Color>? gradientColors;
    String? image;    
    Color? categoryBackgroundColor;   
  CoursesModel({
      this.tag,
      this.tagIcon,
      this.title,
      this.subtitle,
      this.category,
      this.categoryColor,
      this.rating,
      this.price,
      this.gradientColors,
      this.image,
      this.categoryBackgroundColor,
  });
     
}
