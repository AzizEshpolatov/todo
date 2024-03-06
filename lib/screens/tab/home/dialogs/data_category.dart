import 'package:flutter/material.dart';
import '../../../../data_local/models/category_model.dart';
import '../../../../utils/app/app.dart';

List<CategoryModel> categoryAdd = [
  CategoryModel(
    iconLoc: AppNeseserry.food,
    text: "Grocery",
    color:const  Color(0xFFCC4173),
  ),
  CategoryModel(
    iconLoc: "assets/icons/sumka.svg",
    text: "Work",
    color: const Color(0xFFCCFF80),
  ),
  CategoryModel(
    iconLoc: AppNeseserry.sport,
    text: "Sport",
    color: const Color(0xFFA31D00),
  ),
  CategoryModel(
    iconLoc: AppNeseserry.share,
    text: "Design",
    color: const Color(0xFF80FFFF),
  ),
  CategoryModel(
    iconLoc: AppNeseserry.student,
    text: "University",
    color: const Color(0xFF809CFF),
  ),
  CategoryModel(
    iconLoc: AppNeseserry.karnay,
    text: "Social",
    color: const Color(0xFFFF80EB),
  ),
  CategoryModel(
    iconLoc: AppNeseserry.music,
    text: "Music",
    color: const Color(0xFFFC80FF),
  ),
  CategoryModel(
    iconLoc: AppNeseserry.yurak,
    text: "Health",
    color: const Color(0xFF80FFA3),
  ),
  CategoryModel(
    iconLoc: AppNeseserry.kamera,
    text: "Movie",
    color: const Color(0xFF80D1FF),
  ),
  CategoryModel(
    iconLoc: AppNeseserry.home,
    text: "Movie",
    color: const Color(0xFFFF8080),
  ),
  CategoryModel(
    iconLoc: AppNeseserry.addCategory,
    text: "Add",
    color: const Color(0xFFFF8080),
  ),
];

List<String> colorsList = [
  "CC4173",
  "CCFF80",
  "A31D00",
  "80FFFF",
  "809CFF",
  "FF80EB",
  "FC80FF",
  "80FFA3",
  "FF8080",
  "FF8080",
  "80D1FF",
];