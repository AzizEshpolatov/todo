import 'package:flutter/material.dart';
import 'category_model_constants.dart';

class CategoryModels {
  final int? id;
  String name;
  final String iconPath;
  final Color color;

  CategoryModels({
    this.id,
    required this.iconPath,
    required this.name,
    required this.color,
  });

  CategoryModels copyWith({
    int? id,
    String? name,
    String? iconPath,
    Color? color,
  }) {
    return CategoryModels(
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      color: color ?? this.color,
    );
  }

  factory CategoryModels.fromJson(Map<String, dynamic> json) {
    return CategoryModels(
      iconPath: json[CategoryModelConstants.iconPath] as String? ?? "",
      name: json[CategoryModelConstants.name] as String? ?? "",
      color:
      Color(int.parse(json[CategoryModelConstants.color] as String? ?? "")),
      id: json[CategoryModelConstants.id] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      CategoryModelConstants.name: name,
      CategoryModelConstants.iconPath: iconPath,
      CategoryModelConstants.color: color.value.toString(),
    };
  }

  bool canAddTaskToDatabase() {
    if (name.isEmpty) return false;
    if (iconPath.isEmpty) return false;
    return true;
  }

  static CategoryModels initialValue = CategoryModels(
    iconPath: "",
    name: "",
    color: Colors.green,
  );
}