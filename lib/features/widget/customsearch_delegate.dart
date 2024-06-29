import 'package:flutter/material.dart';
//this class is for searching

class CustomSearchDelegate extends SearchDelegate{
  List<String> searchTerm=[
    "The Ritz-Carlton",
    "Four Seasons Hotel",
    "Marriott International",
    "Hilton Hotels & Resorts",
    "Hyatt Hotels Corporation",
    "InterContinental Hotels & Resorts",
    "Sheraton Hotels and Resorts",
    "Wyndham Hotels & Resorts",
    "AccorHotels",
    "Mandarin Oriental Hotel Group",
  ];


  @override
  List<Widget> buildActions(BuildContext context){

    return[
      IconButton(
        icon: const Icon(Icons.clear,color: Color.fromARGB(255, 81, 212, 194)),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context){
    return IconButton(
      icon: const Icon(Icons.arrow_back,color:Color.fromARGB(255, 81, 212, 194),),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context)
  {
    List<String> matchQuery =[];
    for(var fruit in searchTerm)
    {
      if(fruit.toLowerCase().contains(query.toLowerCase()))
      {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context,index)
        {
          var result = matchQuery[index];

          return ListTile(
            title: Text(
              result,
              style: TextStyle(color:Color.fromARGB(255, 81, 212, 194),),
            ),
          );
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context)
  {
    List<String> matchQuery =[];
    for(var fruit in searchTerm)
    {
      if(fruit.toLowerCase().contains(query.toLowerCase()))
      {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context,index)
        {
          var result = matchQuery[index];

          return ListTile(
            title: Text(
              result,
              style: TextStyle(color:Color.fromARGB(255, 81, 212, 194),),

            ),
          );
        }
    );
  }


}
