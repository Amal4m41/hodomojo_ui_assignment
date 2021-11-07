import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hodomojo_app_ui/components/image_component_widget.dart';
import 'package:hodomojo_app_ui/components/text_component_widget.dart';
import 'package:hodomojo_app_ui/services/network.dart';
import 'package:hodomojo_app_ui/utils/constants.dart';

class ContentInfoScreen extends StatefulWidget {
  const ContentInfoScreen({Key? key}) : super(key: key);

  @override
  _ContentInfoScreenState createState() => _ContentInfoScreenState();
}

class _ContentInfoScreenState extends State<ContentInfoScreen> {
  Map<String, dynamic> _apiData = {};
  final _scrollController = ScrollController();

  //Creating a separate function to load the data from api asynchronously to prevent it from blocking the UI event loop.
  void loadDataFromApi() async {
    var data = await NetworkHelper(url: dataUrl).getData();
    //If the data returned is not null and the success key value is true.
    if (data != null && data["success"]) {
      print(data["data"]);
      _apiData = data["data"];
      setState(() {});
      // print(_apiData["title"]);
    }
  }

  @override
  void initState() {
    super.initState();
    loadDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(_apiData["coverUrl"]),
                      fit: BoxFit.fill,
                    ),
                  ),
                  alignment: Alignment.bottomLeft,
                  padding:
                      const EdgeInsets.only(bottom: 30, left: 20, right: 10),
                  child: Text(
                    _apiData["title"]
                        .toString(), //even if the value is null it'll return "null" string
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ...getComponentsWidgetsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //A function to load the components list from api data and create a list of widgets depending upon it's type.
  List<Widget> getComponentsWidgetsList() {
    List? components = _apiData["components"];

    //if the list is not null(meaning successful data retrieval or loading the data is complete), then we'll loop through
    //the list and check it's type and add respective widgets for them.
    return (components != null)
        ? components
            .map(
              (map) => map["type"] == "text"
                  ? TextComponentWidget(
                      title: map['title'], description: map['desc'])
                  : ImageComponentWidget(
                      imageUrl: map['url'],
                    ),
            )
            .toList()
        : [];
  }
}
