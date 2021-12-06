import 'package:flutter/material.dart';
import 'package:notlaruygulamasi/main.dart';
import 'package:notlaruygulamasi/notlardao.dart';

class NotKayitSayfasi extends StatefulWidget {
  const NotKayitSayfasi({Key? key}) : super(key: key);

  @override
  _NotKayitSayfasiState createState() => _NotKayitSayfasiState();
}

class _NotKayitSayfasiState extends State<NotKayitSayfasi> {

  var tfdersadi=TextEditingController();
  var tfnot1=TextEditingController();
  var tfnot2=TextEditingController();
  Future<void> kayit(String ders_adi, int not1, int not2) async {
    await Notlardao().notEkle(ders_adi, not1, not2) ;
    Navigator.push(context, MaterialPageRoute(builder:(context)=> AnaSayfa()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Not Kayit Sayfası"),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
        kayit(tfdersadi.text, int.parse(tfnot1.text), int.parse(tfnot2.text));
        },
        tooltip: 'NOT KAYIT ',
        icon: const Icon(Icons.save),
        label: Text("Kaydet"),
      ),
    );
  }
}
