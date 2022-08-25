import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/model_constants.dart';

// Recipe

class Recipe {
  late String? recipeId;
  late String recipeName;
  late String recipeUrl;
  late String recipeDesc;
  late List<String?> allergyTags;
  late List<String?> ingredientTags;
  late List<String?> categoryTags;
  late int timestamp;
  late String userId;

// Constructor
  Recipe({
    this.recipeId,
    required this.recipeName,
    required this.recipeUrl,
    required this.recipeDesc,
    required this.allergyTags,
    required this.ingredientTags,
    required this.categoryTags,
  });

  // DB Field name constants
  static const String kRecipeId = 'id';
  static const String kRecipeName = 'name';
  static const String kRecipeUrl = 'url';
  static const String kRecipeDescription = 'description';
  static const String kIngredientTags = 'ingredientTags';
  static const String kAllergyTags = 'allergyTags';
  static const String kCategoryTags = 'categoryTags';
  static const String kTimeStamp = 'timestamp';
  static const String kUserId = 'userId';

  List<String?> convertArray(List<dynamic> mapArray) {
    List<String?> result = [];
    //print('Before: $mapArray');
    for (var i = 0; i < mapArray.length; i++) {
      result.add(mapArray[i] as String);
    }
    //print('After: $result');
    return result;
  }

  //Alternate Constructor
  Recipe.fromMap(Map doc) {
    //print(doc);
    //recipeId = doc['recipeId'];
    //print(doc[kRecipeName]);
    recipeName = doc[kRecipeName];
    recipeUrl = doc[kRecipeUrl];
    recipeDesc = doc[kRecipeDescription];

    List<dynamic> tmp = doc[kIngredientTags];
    ingredientTags = convertArray(doc[kIngredientTags]);
    allergyTags = convertArray(doc[kAllergyTags]);
    categoryTags = convertArray(doc[kCategoryTags]);
    timestamp = doc[kTimeStamp] as int;
    userId = doc[kUserId];
    //print('RecipeId: $recipeId');
  }

  // Here we pass in the snapshot document
  Recipe.fromDocSnapshot(DocumentSnapshot<Map> doc) {
    recipeId = doc.id;
    recipeName = doc.data()![kRecipeName];
    recipeUrl = doc.data()![kRecipeUrl];
    recipeDesc = doc.data()![kRecipeDescription];
    ingredientTags = convertArray(doc.data()![kIngredientTags]);
    allergyTags = convertArray(doc.data()![kAllergyTags]);
    categoryTags = convertArray(doc.data()![kCategoryTags]);
    timestamp = doc.data()![kTimeStamp] as int;
    userId = doc.data()![kUserId];
    //print('Recipe: ${recipeName}');
  }
  // return the map as defined in the database
  Map toMap() {
    final Map data = {};
    data[kRecipeName] = recipeName;
    data[kRecipeUrl] = recipeUrl;
    data[kRecipeDescription] = recipeDesc;
    data[kAllergyTags] = allergyTags;
    data[kIngredientTags] = ingredientTags;
    data[kCategoryTags] = categoryTags;
    return data;
  }

// properties
  bool isVegetarian() {
    return allergyTags.contains(kVegetarian);
  }

  bool isVegan() {
    return allergyTags.contains(kVegan);
  }

  bool isGF() {
    return allergyTags.contains(kGlutenFree);
  }
}
