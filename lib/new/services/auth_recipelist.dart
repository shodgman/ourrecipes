import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ourrecipes/new/services/application_state.dart';
import 'package:ourrecipes/new/widgets/widgets.dart';
import 'package:ourrecipes/models/recipeModel.dart';

class AuthRecipeList extends StatelessWidget {
  const AuthRecipeList({
    Key? key,
  }) : super(key: key);
// Parameters
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade200.withOpacity(0.5),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      child: Consumer<ApplicationState>(
        builder: (context, appState, _) => ListView(
          children: [
            // Spacer at top of list
            const SizedBox(height: 10.0),
            for (var recipe in appState.recipeList)
              RecipeCard(showRecipe: recipe),
            // Dummy blank end of list
            const SizedBox(height: 80.0),
          ],
        ),
      ),
    );
  }
}

//////////////////////////////////
//  Recipe Card Display
/////////////////////////////////
class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key? key,
    required this.showRecipe,
  }) : super(key: key);

  final Recipe showRecipe; // Recipe to display
  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () {
          final Uri url = Uri.parse(showRecipe.recipeUrl);
          _launchUrl(url);
        },
        child: Card(
          color: Colors.green.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TitleParagraph(showRecipe.recipeName),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  showRecipe.isVegetarian()
                      ? const Text('Vegetarian,')
                      : const Text(''),
                  showRecipe.isVegan() ? const Text('Vegan,') : const Text(''),
                  showRecipe.isGF() ? const Text('GF,') : const Text(''),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Paragraph(showRecipe.recipeDesc),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
            ],
          ),
        ),
      );
}

Future<void> _launchUrl(Uri url) async {
  //print('URL=$url');
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
    webViewConfiguration: const WebViewConfiguration(enableDomStorage: true),
  )) {
    throw 'Could not launch $url';
  }
}
