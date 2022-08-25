import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ourrecipes/new/services/application_state.dart';
import 'package:ourrecipes/new/widgets/widgets.dart';

class AdjustFilterSettings extends StatefulWidget {
  const AdjustFilterSettings({Key? key}) : super(key: key);

  @override
  State<AdjustFilterSettings> createState() => _AdjustFilterSettingsState();
}

class _AdjustFilterSettingsState extends State<AdjustFilterSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor.withOpacity(0.7),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Consumer<ApplicationState>(
        builder: (context, appState, _) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Header('Select the tags that you are looking for'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                appState.updateLoginState(ApplicationLoginState.loggedIn);
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
