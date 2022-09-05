import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:textfield_tags/textfield_tags.dart';
import 'package:ourrecipes/new/widgets/pick_tags_field.dart';

import 'package:ourrecipes/new/services/application_state.dart';
import 'package:ourrecipes/new/widgets/widgets.dart';
import 'package:ourrecipes/new/widgets/build_filterchip_widget.dart';

class AdjustFilterSettings extends StatefulWidget {
  const AdjustFilterSettings({
    Key? key,
  }) : super(key: key);
  @override
  State<AdjustFilterSettings> createState() => _AdjustFilterSettingsState();
}

class _AdjustFilterSettingsState extends State<AdjustFilterSettings> {
  final List<String> _options = ['vegan', 'vegetarian', 'gluten free'];
  List<bool> _selected = [false, false, false];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextfieldTagsController _categoryTags = TextfieldTagsController();
  final TextfieldTagsController _ingredientTags = TextfieldTagsController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _categoryTags.dispose();
    _ingredientTags.dispose();
    _nameController.dispose();
    _descController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor.withOpacity(0.7),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Consumer<ApplicationState>(
        builder: (context, appState, _) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('Recipe Name:'),
            TextField(
              controller: _nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            // Search Description
            const Text('Description:'),
            TextField(
              controller: _descController,
            ),

            const Header('Select the tags that you are looking for'),
            const Header('by Dietary restrictions OR Ingredients OR Category'),
            // Allergy Tags
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  const Text('Dietary Restriction Tags:'),
                  const SizedBox(
                    width: 10,
                  ),
                  BuildFilterChips(options: _options, selections: _selected),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
              child: Text(
                'OR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48),
              ),
            ),
            // Ingredient Tags
            Container(
              height: 100,
              child: PickTagsField(
                  tagsController: _ingredientTags,
                  initialList: const [],
                  selectionList: const [],
                  tagPrompt: 'Ingredient Tags',
                  allowAddingTags: true),
            ),
            const SizedBox(
              height: 80,
              child: Text(
                'OR',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
              ),
            ),
            // Category Tags
            Container(
              height: 100,
              child: PickTagsField(
                  tagsController: _categoryTags,
                  initialList: const [],
                  selectionList: const [],
                  tagPrompt: 'Category Tags',
                  allowAddingTags: true),
            ),
            // Save and  Filter Button
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty) {
                  appState.setSearchTheName(_nameController.text);
                }
                if (_descController.text.isNotEmpty) {
                  appState.setSearchTheDescription(_descController.text);
                }
                // Update allergyExp with selections
                List<String> newExp = [];
                for (int i = 0; i < _options.length; i++) {
                  if (_selected[i]) {
                    newExp.add(_options[i]);
                  }
                }
                appState.setAllergyExp(newExp);
                // Update Ingredients Tags
                newExp = [];
                print('get IngredientTags');
                List<String>? tagExp = _ingredientTags.getTags;
                if (tagExp != null) {
                  for (int i = 0; i < tagExp.length; i++) {
                    newExp.add(tagExp[i]);
                  }
                }
                appState.setIngredientExp(newExp);
                // Update Category Tags
                newExp = [];
                print('get CategoryTags');
                tagExp = _categoryTags.getTags;
                if (tagExp != null) {
                  for (int i = 0; i < tagExp.length; i++) {
                    newExp.add(tagExp[i]);
                  }
                }
                appState.setCategoryExp(newExp);

                // Change to display the new list
                appState.recipeInitSubscription();
              },
              child: const Text('SAVE'),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
