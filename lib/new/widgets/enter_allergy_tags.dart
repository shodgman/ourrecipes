import 'package:flutter/material.dart';
import 'package:ourrecipes/models/models.dart';
import 'package:textfield_tags/textfield_tags.dart';
import '../widgets/pick_tags_field.dart';

class EnterAllergyTags extends StatefulWidget {
  const EnterAllergyTags({
    Key? key,
    required this.tagsController,
    required this.initialList,
  }) : super(key: key);

  final TextfieldTagsController tagsController;
  final List<String> initialList;
  //final List<String> selectionList;
  //final String tagPrompt;

  @override
  State<EnterAllergyTags> createState() => _EnterAllergyTagsState();
}

class _EnterAllergyTagsState extends State<EnterAllergyTags> {
  late List<String> possibleAllergyTags = [
    kVegetarian,
    kVegan,
    kGlutenFree,
  ];
  late String allergyPrompt =
      'Select allergy tags like vegan, vegetarian & gluten free';

  @override
  Widget build(BuildContext context) {
    return PickTagsField(
      tagsController: widget.tagsController,
      initialList: widget.initialList,
      selectionList: possibleAllergyTags,
      tagPrompt: allergyPrompt,
      allowAddingTags: false,
    );
  }
}
