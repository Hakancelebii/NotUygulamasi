import 'package:flutter/material.dart';
import 'package:notlaruygulamasi/main.dart';
import 'package:notlaruygulamasi/notlar.dart';
import 'package:notlaruygulamasi/notlardao.dart';

class NotDetaySayfasi extends StatefulWidget {
  Notlar not;

  NotDetaySayfasi({required this.not});


  @override
  _NotDetaySayfasiState createState() => _NotDetaySayfasiState();
}

class _NotDetaySayfasiState extends State<NotDetaySayfasi> {

  var tfdersadi=TextEditingController();
  var tfnot1=TextEditingController();
  var tfnot2=TextEditingController();
  Future<void> sil(int not_id) async {
    await Notlardao().notSil(not_id);
    Navigator.push(context, MaterialPageRoute(builder:(context)=> AnaSayfa()));
  }
  Future<void> guncelle(int not_id, String ders_adi, int not_1, int not_2) async {
    await Notlardao().notGuncelle(not_id, ders_adi, not_1, not_2);
    Navigator.push(context, MaterialPageRoute(builder:(context)=> AnaSayfa()));
  }
  @override
  void initState() {
    super.initState();
    var not=widget.not;
    tfdersadi.text=not.ders_adi;
    tfnot1.text=not.not1.toString();
    tfnot2.text=not.not2.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Detay Sayfası "),
        actions: [
          TextButton(onPressed: (){
            sil(widget.not.not_id);
          }, child: Text("Sil",style:TextStyle(color: Colors.white),)),
          TextButton(onPressed: (){
           guncelle(widget.not.not_id, tfdersadi.text, int.parse(tfnot1.text),int.parse(tfnot2.text));
          }, child: Text("Güncelle",style:TextStyle(color: Colors.white),))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0,right: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: tfdersadi,
                decoration: InputDecoration(
                    hintText: "Ders adı"
                ),
              ),
              TextField(
                controller: tfnot1,
                decoration: InputDecoration(
                    hintText: "1.Not "
                ),
              ),
              TextField(
                controller: tfnot2,
                decoration: InputDecoration(
                    hintText: "2.Not"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
