import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vocab_app/UI/bottom_appbar.dart';
import 'package:vocab_app/UI/loading_circular_progress.dart';

import 'package:vocab_app/UI/search_bar.dart';
import 'package:vocab_app/helpers/page_redirect.dart';
import 'package:vocab_app/model/db.dart';
import 'package:vocab_app/model/vocab.dart';
import 'package:vocab_app/navbuttons/back_button.dart';

class SearchPage extends StatefulWidget {
  SearchPage({
    @required this.prefs,
    @required this.buttonColor,
  });

  SharedPreferences prefs;
  Color buttonColor;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  VocabDatabase client;
  List wordList;

  final TextEditingController _controller = new TextEditingController();
  List searchResult = new List();
  bool _isSearching;

  _SearchPageState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isSearching = false;
    client = new VocabDatabase();
  }


  Future<List> init() async{
    if (wordList == null)  wordList = await client.queryAll();
    //wordList.sort();
    return wordList;
  }

  void search(String text) {
    searchResult.clear();
    for (var i = 0; i < wordList.length; i++) {
      String cur = wordList[i].vword.toLowerCase();
      if (cur.contains(text.toLowerCase())) searchResult.add(wordList[i]);
    }
  }

  Widget listBuilder({List dataList, BuildContext parentContext}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 90.0, 0.0, 0.0),
      child: new ListView.builder(
        shrinkWrap: true,
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          Vocab cur = dataList[index];
          return InkWell(
            onTap: () => singleWordPageDirect(context: context, data: cur),
            child: new ListTile(
              title: new Text(
                cur.vword,
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData){
          return Scaffold(
            bottomNavigationBar: ScaffoldBottomAppBar(
              parentContext: context,
              buttonColor: widget.buttonColor,
              prefs: widget.prefs,
              curPage: 'search',
            ),
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: SearchBar(
                    search: search,
                    controller: _controller,
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: searchResult.length != 0 ||
                            _controller.text.isNotEmpty
                            ? listBuilder(
                            dataList: searchResult, parentContext: context)
                            : listBuilder(
                            dataList: snapshot.data, parentContext: context),
                      )
                    ],
                  ),
                ),
//                BubbleBackButton(
//                  prefs: widget.prefs,
//                  onPressed: () => backDirect(),
//                ),
              ],
            ),
          );
        }else
          return LoadingCircularProgress();
      },
    future: init()
    );
  }
}
