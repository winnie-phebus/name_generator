import 'package:flutter/material.dart';
import 'package:name_generator/resources/source.dart';

import '../resources/constants.dart';

class UsageSearch extends SearchDelegate<Origin> {
  // Search Delegate is a built in Flutter library / class
  // Credit towards MTECHVIRAL for majority of the basic use of this class.
  List<Origin> nameSources = all_origins;

  List<Origin> recents = [];
  List<Origin> favorites = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
      IconButton(
        icon: Icon(Icons.check),
        onPressed: () {
          Origin chosen = Origin.displayToSource(query);
          print('$chosen' + ',' + query);
          if (chosen != null) {
            print('$query, ' + chosen.display);
            recents.add(chosen);
            close(context, chosen);
          } else {
            print('$query');
            //TODO: [UPGRADE] account for user press 'enter'
            showResults(context);
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation, // a given property
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Query is a property of the class, and is automatically generated.
    return Text('Seems like that is not a valid choice! Try again.');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? Origin.sourceConverter(all_origins)
        : Origin.sourceConverter(all_origins)
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ]),
        ),
        onTap: () {
          query = suggestionList[index];
        },
      ),
      itemCount: suggestionList.length,
    );
  }
}
