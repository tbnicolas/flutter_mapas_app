import 'package:flutter/material.dart';
import 'package:flutter_mapas_app/models/search_result_model.dart';

class SearchDestination extends SearchDelegate<SearchResult> {

  SearchDestination(): super(searchFieldLabel: 'Buscar...');
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      new IconButton(
        icon: new Icon(Icons.clear), 
        onPressed: () => this.query = ''
      )
    ];
  }
  
    @override
    Widget buildLeading(BuildContext context) {
       
      return new IconButton(
        icon: new Icon(Icons.arrow_back), 
        onPressed: () => this.close(context, new SearchResult(cancelo: true))
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      return new Text('Build Results');

    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      return new ListView(
        children: [
          new ListTile(
            leading: new Icon(Icons.location_on),
            title: new Text('Colocar ubicación manualmente'),
            onTap: () {
              print('Manualmente');
              this.close(context, new SearchResult(cancelo: false, manual: true));
            },
          ),
        ],
      );

    }

}