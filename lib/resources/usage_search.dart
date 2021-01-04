import 'package:flutter/material.dart';
import 'package:name_generator/resources/source.dart';

import 'constants.dart';

class UsageSearch extends SearchDelegate<Source> {
  // Search Delegate is a built in Flutter library / class
  // Credited towards MTECHVIRAL for majority of the use of this class.
  List<Source> nameSources = allNameSources;

  List<Source> recents = [];
  List<Source> favorites = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
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
          Source chosen = Source.displayToSource(query);
          if (chosen != null) {
            print('$query, ' + chosen.display);
            recents.add(chosen);
            close(context, chosen);
          } else {
            print('$query');
            //TODO: account for user press 'enter'
            showResults(context);
          }
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
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
        ? Source.sourceConverter(recents)
        : Source.sourceConverter(allNameSources)
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
