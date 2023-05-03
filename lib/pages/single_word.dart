import 'package:flutter/material.dart';
import 'package:vocab_app/UI/loading_circular_progress.dart';
import 'package:vocab_app/helpers/learnpage_helper.dart';
import 'package:vocab_app/model/db.dart';
import 'package:vocab_app/model/vocab.dart';
import 'package:vocab_app/pages/single_word_content.dart';

class SingleWord extends StatefulWidget {
  SingleWord({
    this.vocab,
    this.word,
  });

  final Vocab vocab;
  final String word;

  @override
  _SingleWordState createState() => _SingleWordState();
}

class _SingleWordState extends State<SingleWord> {

  Future<Vocab> _queryWord() async {
    VocabDatabase client = new VocabDatabase();
    print(widget.word);
    var queried = await client.queryWord(vocab: widget.word);
    print(queried);
    return queried;
  }

  Widget _buildWord() {
    if (widget.vocab != null) {
      return singleWordHero(vocab: widget.vocab);
    } else {
      return FutureBuilder(
        future: _queryWord(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return singleWordHero(vocab: snapshot.data);
          } else
            return LoadingCircularProgress();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildWord();
  }
}

//new Hero(
//tag: "word",
//child: new Card(
//child: new Container(
//alignment: Alignment.center,
//child: new Stack(
//alignment: AlignmentDirectional.bottomCenter,
//children: <Widget>[
//new CustomScrollView(
//shrinkWrap: false,
//slivers: <Widget>[
//new SliverAppBar(
//pinned: true,
//flexibleSpace: new FlexibleSpaceBar(
//title: new Text(widget.vocab.vword, style: new TextStyle(fontSize: 39.0)),
//centerTitle: true
//),
//),
//new SliverList(
//delegate: new SliverChildListDelegate(<Widget>[
//new Container(
//color: Colors.white,
//child: new Padding(
//padding: const EdgeInsets.all(35.0),
//child: new Column(
//crossAxisAlignment: CrossAxisAlignment.start,
//children: getWordDetail(widget.vocab)
//),
//),
//),
//]),
//),
//],
//),
//],
//),
//),
//),
//),
