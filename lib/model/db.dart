import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
//
import 'vocab.dart';

final String vocabDB = 'vocabDB';
final String vindex = 'vindex';
final String vword = 'vword';
final String vdiff = 'vdiff';
final String vlevel = 'vlevel';
final String known = 'known';
final String favorite = 'favorite';
final String engMean = 'engMean';
final String chMean = 'chMean';
final String vsyn = 'vsyn';
final String vanto = 'vanto';
final String vpro = 'vpro';
final String vclass = 'vclass';
final String vexa = 'vexa';
final String totaln = "totaln";
final String rightn = "rightn";


class VocabDatabase {

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, '$vocabDB.db');
//    await deleteDatabase(path);
//    print('deleted');
    var db = await openDatabase(
        path, version: 1, onCreate: _onCreate, onOpen: _onOpen);
    return db;
  }


  void _onCreate(Database db, int newVersion) async {
    print('creating db');
    await db.execute('''
      create table $vocabDB (
        $vword text primary key,
        $vclass text not null,
        $engMean text not null,
        $chMean text not null,
        $vsyn text not null,
        $vanto text not null,
        $vexa text not null,
        $vindex text not null,
        $vpro text,
        $vdiff text not null,
        $vlevel text not null,
        $known text not null,
        $favorite text not null,
        $totaln integer not null,
        $rightn integer not null
      );
    ''');
  }

  Future<String> insert(Vocab vb) async {
    var client = await db;
    try {
      client.insert('vocabDB', {
        vword: vb.vword,
        vclass: vb.vclass,
        engMean: vb.engMean,
        chMean: vb.chMean,
        vsyn: vb.vsyn,
        vanto: vb.vanto,
        vpro: vb.vpro,
        vexa: vb.vexa,
        vdiff: vb.vdiff,
        vlevel: vb.vlevel,
        known: vb.known,
        favorite: vb.favorite,
        vindex: vb.vindex,
        totaln: vb.totaln,
        rightn: vb.rightn
      });
    } catch (e) {
      print(e);
    }
    print('inserted the word into database');
    return vb.vword;
  }


  void _onOpen(Database db) {
    print('open db');
  }

  List<Vocab> _convert(List<Map> maps){
    List<Vocab> words = [];
    maps.forEach((json) {
      words.add(new Vocab().getDetail(json));
    });
    return words;
  }



  Future<List> queryAll() async {
    var client = await db;
    List<Map> maps = await client.query(vocabDB);

    return _convert(maps);
  }

  Future<List> getRandomSixty() async{
    var client = await db;
    List<Map> maps = await client.query(vocabDB);
    List converted = _convert(maps);
    converted.shuffle();
    var end = converted.length > 60 ?  59 : converted.length;
    return converted.sublist(0, end);
  }

  Future<List> queryLevel({String lv, String diff}) async {
    var client = await db;
    List<Map> maps = await client.rawQuery(
        'SELECT * from vocabDB WHERE vdiff = ? AND vlevel = ?',
        [diff, lv]);

    return _convert(maps);
  }

  Future<List> queryLevelFavorite({String lv, String diff}) async {
    var client = await db;
    List<Map> maps = await client.rawQuery(
      'SELECT * from vocabDB WHERE vdiff = ? AND vlevel = ? AND favorite = ?',
      [diff, lv, '1']);

   return _convert(maps);
  }

  Future<List> queryLevelKnown({String lv, String diff}) async{
    var client = await db;
    List<Map> maps = await client.rawQuery(
      'SELECT * from vocabDB WHERE vdiff = ? AND vlevel = ? AND known = ?',
      [diff, lv, '1']);

    return _convert(maps);
  }


  Future<List> queryLevelUnknown({String lv, String diff}) async{
    var client = await db;
    List<Map> maps = await client.rawQuery(
        'SELECT * from vocabDB WHERE vdiff = ? AND vlevel = ? AND known = ?',
        [diff, lv, '0']);

    return _convert(maps);
  }



  Future<Vocab> queryWord({String vocab}) async {
    var client = await db;
    List<Map> maps = await client.rawQuery(
      'SELECT * from vocabDB WHERE vword = ?',
      [vocab]
    );
    var word = new Vocab().getDetail(maps[0]);

    return word;
  }


  Future updateFavorite({Vocab vocab}) async {
    var client = await db;
    var state = vocab.favorite == '1' ? '0' : '1';
    await client.rawUpdate(
        'UPDATE vocabDB SET favorite = ? where vword = ?',
        [state, vocab.vword]);
  }


  Future updateKnown({Vocab vocab, String state}) async {
    var client = await db;
    await client.rawUpdate(
        'UPDATE vocabDB SET known = ? where vword = ?',
        [state, vocab.vword]);
  }


  Future updateTotaln({Vocab vocab}) async {
    var client = await db;
    await client.rawUpdate(
      'UPDATE vocabDB SET totaln = totaln + 1 where vword = ?',
      [vocab.vword]);
  }


  Future updateRightn({Vocab vocab}) async{
    var client = await db;
    await client.rawUpdate(
      'UPDATE vocabDB SET rightn = rightn + 1 where vword = ?',
      [vocab.vword]);
  }

}