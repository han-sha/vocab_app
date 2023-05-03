import 'dart:async';
import 'dart:math';

import 'package:vocab_app/utils/tf_question.dart';

import '../model/vocab.dart';
import '../model/db.dart';
import '../utils/question.dart';

Random rnd = new Random();
List optionList = [];
String word;

Future<List> levelTFGen({String lv, String diff, List questionList}) async{
  if(questionList != null) return questionList;
  questionList = [];
  VocabDatabase client = new VocabDatabase();
  var queried = await client.queryLevel(lv: lv, diff: diff);
  for (var i = 0; i < queried.length; i ++){
    print("in the loop");
    questionList = (_TFQGen(vocab: queried[i], rst: questionList));
  }

  questionList.shuffle();
  return questionList;
}

List _TFQGen({Vocab vocab, List rst}){
  var qnum_per_word = 1;
  //var rnd = Random();
  //var type = rnd.nextBool();
  var syn = vocab.vsyn.split(', ');
  var anto = vocab.vanto.split(', ');
  var synlist = new List<int>.generate(syn.length-1, (int index)=>index);
  var antolist = new List<int>.generate(anto.length-1, (int index)=>index);
  synlist.shuffle();
  antolist.shuffle();

  for(var i = 0; i < qnum_per_word; i ++){
    var q1 = TFqs(word: vocab.vword, choice: syn[synlist[i]], type:'synonym');
    var q2 = TFqs(word: vocab.vword, choice: anto[antolist[i]], type:'antonym');
    rst.add(q1);
    rst.add(q2);
  }

//  for(var i = 0; i < qnum_per_word; i ++){
//    var q;
//    type = rnd.nextBool();
//    if(type == true)q = TFqs(word: vocab.vword, choice: syn[synlist[i]], type: 's', answer: true);
//    else q = TFqs(word: vocab.vword, choice: syn[synlist[i]], type: 'a', answer: false);
//    rst.add(q);
//  }
//
//  for(var i = 0; i < qnum_per_word; i ++){
//    var q;
//    type = rnd.nextBool();
//    if(type == true)q = TFqs(word: vocab.vword, choice: anto[antolist[i]], type: 'a', answer: true);
//    else q = TFqs(word: vocab.vword, choice: anto[antolist[i]], type: 's', answer: false);
//    rst.add(q);
//  }
  return rst;
}



Future<List> levelQGen({String lv, String diff, bool syn, List questionList}) async{
  if(questionList != null) return questionList;
  questionList = [];
  VocabDatabase client = new VocabDatabase();
  var queried = await client.queryLevel(lv: lv, diff: diff);
  for (var i = 0; i < queried.length; i ++){
    print("in the loop");
    questionList.add(_oneQGen(vocab: queried[i], syn: syn));
    questionList.add(_oneQGen(vocab: queried[i], syn: syn));
  }

  questionList.shuffle();
  return questionList;
}


Question _oneQGen({Vocab vocab, bool syn}){
  var max;
  var ans;
  var options;

  options = _getOption(vocab: vocab, syn: syn);
  if (syn == true) max = vocab.vsyn.split(', ').length-1;
  else max = vocab.vanto.split(', ').length-1;
  int n = rnd.nextInt(max);

  if(syn == true) ans = vocab.vsyn.split(', ')[n];
  else ans = vocab.vanto.split(', ')[n];
  var rst = new Question(question: vocab.vword, answer: ans, options: options);
//  print(options);
  return rst;
}


List _getOption({Vocab vocab, bool syn}){
  var rst = [];

  if(syn == true) optionList = vocab.vanto.split(', ');
  else optionList = vocab.vsyn.split(', ');
  var list = new List<int>.generate(optionList.length-1, (int index)=>index);
  list.shuffle();
  while(list.length != 4) list.removeLast();
  for (var i = 0; i < list.length; i ++){
    rst.add(optionList[list[i]]);
  }
  return rst;
}