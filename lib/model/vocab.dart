import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class Vocab {
  final vindex;
  final vword;
  final vpro;
  final vclass;
  final chMean;
  final engMean;
  final vsyn;
  final vanto;
  final vexa;
  final vdiff;
  final vlevel;
  var favorite;
  var known;
  var totaln;
  var rightn;

  Vocab({this.vindex, this.vword, this.vpro, this.vclass, this.chMean,
    this.engMean, this.vsyn, this.vanto, this.vexa, this.vdiff, this.vlevel,
  this.favorite, this.known, this.totaln, this.rightn});


  Future<List> loadList(difficulty, level) async {
    print("here");
    String path = 'assets/vocab/$difficulty$level.json';
    print('assets/vocab/$difficulty$level.json');
    final jsons = await rootBundle.loadString(path);
    return json.decode(jsons);
  }

  Vocab getDetail(item) {
    return new Vocab.fromJson(item);
  }


  Map toJson(Vocab vocab) {

    Map<String, dynamic> map;
    try {
      map = {
        'vindex': vocab.vindex,
        'vword': vocab.vword,
        'vpro': vocab.vpro,
        'vclass': vocab.vclass,
        'chDef': vocab.chMean,
        'engDef': vocab.engMean,
        'vsyn': vocab.vsyn,
        'vanto': vocab.vanto,
        'vexa': vocab.vexa,
        'favorite': vocab.favorite,
        'known': vocab.known,
        'vdiff': vocab.vdiff,
        'vlevel': vocab.vlevel,
        'totaln': vocab.totaln.toString(),
        'rightn': vocab.rightn.toString()
      };
    } catch (e) {
      map = {
      };
    }
    return map;
  }

  factory Vocab.fromJson(json){
    Vocab vocab;
    try {
      vocab = new Vocab(
          vindex: json['vindex'],
          vword: json['vword'],
          vpro: json['vpro'],
          vclass: json['vclass'],
          chMean: json['chMean'],
          engMean: json['engMean'],
          vsyn: json['vsyn'],
          vanto: json['vanto'],
          vexa: json['vexa'],
          favorite: json['favorite'],
          vdiff: json['vdiff'],
          vlevel: json['vlevel'],
          known: json['known'],
          totaln: json['totaln'],
          rightn: json['rightn']);
    }catch(e){
      print(e);
    }
    return vocab;
  }


}
