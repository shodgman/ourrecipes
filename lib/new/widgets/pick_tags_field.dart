import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

class PickTagsField extends StatefulWidget {
  const PickTagsField({
    Key? key,
    required this.tagsController,
    required this.initialList,
    required this.selectionList,
    required this.tagPrompt,
    required this.allowAddingTags,
  }) : super(key: key);

  final TextfieldTagsController tagsController;
  final List<String> initialList;
  final List<String> selectionList;
  final String tagPrompt;
  final bool allowAddingTags;

  @override
  State<PickTagsField> createState() => _PickTagsFieldState();
}

class _PickTagsFieldState extends State<PickTagsField> {
  // TODO: implement optional colors for tag entry
  late Color colorForTags;
  late double _distanceToField;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    // If no colorTheme specified, go with the original
    //if(widget.colorTheme==Colors.black){
    //  colorForTags = const Color.fromARGB(255, 74, 137, 92);
    //}
    return Autocomplete<String>(
      optionsViewBuilder: (context, onSelected, options) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              elevation: 4.0,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 200),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    final dynamic option = options.elementAt(index);
                    return TextButton(
                      onPressed: () {
                        onSelected(option);
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            '#$option',
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Color.fromARGB(
                                255,
                                74,
                                137,
                                92,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return widget.selectionList.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selectedTag) {
        widget.tagsController.addTag = selectedTag;
      },
      fieldViewBuilder: (context, ttec, tfn, onFieldSubmitted) {
        return TextFieldTags(
          textEditingController: ttec,
          focusNode: tfn,
          textfieldTagsController: widget.tagsController,
          initialTags: widget.initialList,
          textSeparators: const [' ', ','],
          letterCase: LetterCase.normal,
          validator: (String tag) {
            if (widget.tagsController.getTags != null) {
              // tag(s) have been entered
              bool? tmp = widget.tagsController.getTags?.contains(tag);
              if ((tmp != null) && (tmp)) {
                return 'you already entered that';
              }
              // Is this an available tag?
              tmp = widget.selectionList.contains(tag);
              if ((!tmp) && (!widget.allowAddingTags)) {
                return 'Cannot add "$tag" to the list, sorry';
              }
            }
            return null;
          },
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: tec,
                  focusNode: fn,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 137, 92), width: 3.0),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 137, 92), width: 3.0),
                    ),
                    helperText:
                        widget.tagsController.hasTags ? widget.tagPrompt : '',
                    helperStyle: const TextStyle(
                      color: Color.fromARGB(255, 74, 137, 92),
                    ),
                    hintText:
                        widget.tagsController.hasTags ? '' : widget.tagPrompt,
                    errorText: error,
                    prefixIconConstraints:
                        BoxConstraints(maxWidth: _distanceToField * 0.74),
                    prefixIcon: tags.isNotEmpty
                        ? SingleChildScrollView(
                            controller: sc,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: tags.map((String tag) {
                              return Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: Color.fromARGB(255, 74, 137, 92),
                                ),
                                margin: const EdgeInsets.only(right: 10.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        '#$tag',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onTap: () {
//print("$tag selected");
                                      },
                                    ),
                                    const SizedBox(width: 4.0),
                                    InkWell(
                                      child: const Icon(
                                        Icons.cancel,
                                        size: 14.0,
                                        color:
                                            Color.fromARGB(255, 233, 233, 233),
                                      ),
                                      onTap: () {
                                        onTagDelete(tag);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }).toList()),
                          )
                        : null,
                  ),
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                ),
              );
            });
          },
        );
      },
    );
  }
}
