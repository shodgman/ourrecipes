import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';
import 'package:ourrecipes/new/widgets/pick_tags_field.dart';

// Dialog widget that returns a value that is a List<String> objetc.
class MyTagsDialog extends StatefulWidget {
  const MyTagsDialog({Key? key}) : super(key: key);

  @override
  State<MyTagsDialog> createState() => _MyTagsDialogState();
}

class _MyTagsDialogState extends State<MyTagsDialog> {
  final TextfieldTagsController _controllerTags = TextfieldTagsController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerTags.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Tags to use:'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          PickTagsField(
              tagsController: _controllerTags,
              initialList: const [],
              selectionList: const [],
              tagPrompt: 'add key ingredient tags',
              allowAddingTags: true),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, _controllerTags.getTags);
                  },
                  child: const Text(
                    "Save",
                    style: const TextStyle(color: Colors.white),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
