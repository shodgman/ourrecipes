import 'package:flutter/material.dart';
import 'package:ourrecipes/new/widgets/widgets.dart';
import 'package:ourrecipes/new/services/application_state.dart';
import 'package:provider/provider.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:ourrecipes/reusableWidgets/text_widgets.dart';
import 'package:ourrecipes/new/widgets/pick_tags_field.dart';
import 'package:ourrecipes/models/recipeModel.dart';
import 'package:ourrecipes/new/widgets/enter_allergy_tags.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({
    Key? key,
    required this.addRecipe,
  }) : super(key: key);
// Parameters
  final void Function(Recipe rToAdd) addRecipe;
  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_CreateRecipeState');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextfieldTagsController _allergyTags = TextfieldTagsController();
  final TextfieldTagsController _ingredientTags = TextfieldTagsController();
  final TextfieldTagsController _categoryTags = TextfieldTagsController();
  final List<String> _availableTags = [
    'gluten free',
    'vegan',
    'vegetarian',
    'easy',
    'quick',
  ];

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _urlController.dispose();
    _descController.dispose();
    _categoryTags.dispose();
    _allergyTags.dispose();
    _ingredientTags.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor.withOpacity(0.7),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Container(
        color: Colors.white.withOpacity(0.5),
        width: MediaQuery.of(context).size.width * .8,
        //height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),

        child: Consumer<ApplicationState>(
          builder: (context, appState, _) => Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Header('Enter the Full Recipe Details'),
                // Recipe Name
                ReusableTextEntryField(
                  preTextValue: 'Recipe Name',
                  icon: Icons.text_fields_outlined,
                  isPasswordType: false,
                  textController: _nameController,
                  validator: validateRecipeName,
                  autoFocus: false,
                ),
                const Divider(
                  thickness: 2.0,
                ),
                // URL
                ReusableTextEntryField(
                  preTextValue: 'The URL of the Recipe Details',
                  icon: Icons.link_outlined,
                  isPasswordType: false,
                  textController: _urlController,
                  validator: validateRecipeUrl,
                ),
                const Divider(
                  thickness: 2.0,
                ),
                ReusableTextEntryField(
                  preTextValue: 'Description of the recipe if needed',
                  icon: Icons.text_fields_outlined,
                  isPasswordType: false,
                  textController: _descController,
                  validator: validateRecipeDesc,
                ),
                const Divider(
                  thickness: 2.0,
                ),
                // General Description
                // Key Ingredients
                // Gluten Free Flag
                // Vegetarian Flag
                // Vegan Flag
                EnterAllergyTags(
                  tagsController: _allergyTags,
                  initialList: const [],
                ),
                // Ingredients Tag
                PickTagsField(
                    tagsController: _ingredientTags,
                    initialList: const [],
                    selectionList: const [],
                    tagPrompt: 'add key ingredient tags',
                    allowAddingTags: true),
                const SizedBox(
                  height: 20,
                ),
                // Category and general tags
                PickTagsField(
                    tagsController: _categoryTags,
                    initialList: const [],
                    selectionList: _availableTags,
                    tagPrompt: 'add category and descriptive tags',
                    allowAddingTags: true),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool? valid = _formKey.currentState?.validate();
                    //print('Add Recipe: $valid');
                    if ((valid != null) && (valid)) {
                      List<String>? allergy = _allergyTags.getTags;
                      List<String>? category = _categoryTags.getTags;
                      List<String>? ingredients = _ingredientTags.getTags;
                      try {
                        widget.addRecipe(
                          Recipe(
                            recipeUrl: _urlController.text,
                            recipeName: _nameController.text,
                            recipeDesc: _descController.text,
                            allergyTags: allergy ?? [],
                            categoryTags: category ?? [],
                            ingredientTags: ingredients ?? [],
                          ),
                        );
                        //print('Allergies:$allergy');
                        //print('categories: $category');
                      } catch (e) {
                        _showErrorDialog(
                            context, '*Error Adding Recipe*', e as Exception);
                      }
                      appState.updateLoginState(ApplicationLoginState.loggedIn);
                    }
                  },
                  child: const Text('SAVE RECIPE'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateRecipeName(String? tic) {
  //print('Recipe Name: $tic');
  if ((tic == null) || (tic.isEmpty)) {
    return 'Please enter the Full Recipe Name';
  } else {
    return null;
  }
}

String? validateRecipeUrl(String? tic) {
  //print('Recipe Url: $tic');
  if ((tic == null) || (tic.isEmpty)) {
    return 'Please enter the Full URL for the recipe';
  } else {
    return null;
  }
}

String? validateRecipeDesc(String? tic) {
  //print('Recipe Desc: $tic');
  if ((tic == null) || (tic.isEmpty)) {
    return 'Please enter a useful description';
  } else {
    return null;
  }
}

void _showErrorDialog(BuildContext context, String title, Exception e) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                '${(e as dynamic).message}',
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          StyledButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      );
    },
  );
}
