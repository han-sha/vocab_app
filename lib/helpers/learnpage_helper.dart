import 'package:flutter/material.dart';

import '../model/vocab.dart';

List<Widget> getWordDetail(Vocab currentItem){
  List<Widget> rst = [];
  var syn = Text('synonyms:', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),);
  var anto = Text('antonyms:', style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),);

  var chiDef = currentItem.chMean.split(",,,");
  for (var i = 0; i < chiDef.length; i++){
    rst.add(new Text(chiDef[i], style: new TextStyle(color: Colors.black, fontSize: 20.0)));
    rst.add(new Divider(height: 5.0));
  }

  var engDef = currentItem.engMean.split(",,,");
  for (var i = 0; i < engDef.length; i++){
    rst.add(new Text((i+1).toString() + ". " + engDef[i], style: new TextStyle(color: Colors.black, fontSize: 20.0)));
    rst.add(new Divider(height: 5.0));
  }
  rst.add(new Divider(height: 30.0));

  var fs = [];
  var bs = currentItem.vexa.split(" ");
  while(bs.length != 0){
    String cur = bs.removeAt(0);
    String curvword = currentItem.vword;
    String subs = curvword.substring(0, curvword.length - 1);
    if(cur.toLowerCase() == curvword ||
        cur.toLowerCase() == curvword + 's' ||
        cur.toLowerCase() == curvword + '-like' ||
        cur.toLowerCase() == curvword + 'ed' ||
        cur.toLowerCase() == curvword + 'es' ||
        cur.toLowerCase() == curvword + 'd' ||
        cur.toLowerCase() == subs + 'ity'){
      var string = new RichText(text: new TextSpan(text: fs.join(" "),
          style: new TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Petita'),
          children:<TextSpan>[
            new TextSpan(text: ' $cur ', style: new TextStyle(fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic, color: Colors.black, fontFamily: 'Petita')),
            new TextSpan(text: bs.join(" ")),
          ])
      );
      rst.add(string);
      break;
    }
    fs.add(cur);
  }
    rst.add(new Divider(height: 30.0));

  var vsyn = currentItem.vsyn.split(',');
  var syncontent = "";
  for (var i = 0; i < vsyn.length; i ++ ){
    syncontent += vsyn[i];
    if (i != vsyn.length-1) syncontent += ', ';
  }
  rst.add(syn);
  rst.add(new Text(syncontent, style: new TextStyle(color: Colors.black, fontSize: 20.0)));
  rst.add(new Divider(height: 15.0));

  var vanto = currentItem.vanto.split(',');
  var antocontent = "";
  for (var i = 0; i < vanto.length; i ++ ){
    antocontent += vanto[i];
    if (i != vanto.length-1) antocontent += ', ';
  }
  rst.add(anto);
  rst.add(new Text(antocontent, style: new TextStyle(color: Colors.black, fontSize: 20.0)));
  rst.add(new Container(height: 130.0));
  return rst;
}