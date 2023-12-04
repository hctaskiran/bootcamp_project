import 'dart:convert';

import 'package:bootcamp_project/product/feature/constants/application.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

class SearchMap extends StatefulWidget {
  const SearchMap({super.key});

  @override
  State<SearchMap> createState() => _SearchMapState();
}

class _SearchMapState extends State<SearchMap> {
  final TextEditingController _controller = TextEditingController();
  final uuid = const Uuid();
  List<dynamic> _placesList = [];

  final String _sessionToken = '33231';

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      onChange();
    });
  }

  void onChange() {
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    String apiKey = Application.apiKey;
    String baseURL = Application().autoCompleteURL;
    String request = '$baseURL?input=$input&key=$apiKey&sessiontoken=$_sessionToken';

    var response = await get(Uri.parse(request));
    var data = response.body.toString();

    print(data);
    if (response.statusCode == 200) {
      setState(() {
        _placesList = json.decode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Column(
      children: [
        TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Search Places by Name',
            suffixIcon: Icon(Icons.search),
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: _placesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      _placesList[index]['description'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }))
      ],
    )));
  }
}
