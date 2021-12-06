// @dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:notlaruygulamasi/notdetaysayfa.dart';
import 'package:notlaruygulamasi/notkayitsayfasi.dart';
import 'package:notlaruygulamasi/notlar.dart';
import 'package:notlaruygulamasi/notlardao.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {


  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  Future<List<Notlar>> tumNotlarGoster() async {
    var notlarListesi=await Notlardao().tumNotlar();
    return notlarListesi;
  }

  Future<bool> uygulamayiKapat() async {
await exit(0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            uygulamayiKapat();
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Notlar Uygulaması ",style: TextStyle(fontSize: 16,color: Colors.white),),
            FutureBuilder<List<Notlar>>(
              future:tumNotlarGoster(),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  var notlarListesi=snapshot.data;
                  double ortalama=0.0;

                  if(!notlarListesi.isEmpty){
                    double toplam =0.0;
                  for(var n in notlarListesi){
                    toplam=toplam + (n.not1+n.not2)/2;
                  }
                  ortalama=toplam/notlarListesi.length;
                  }
                  return Text("Ortalama : ${ortalama.toInt()} ",style: TextStyle(fontSize: 14,color: Colors.white),);
                }else{
                  return Text("Ortalama : 0 ",style: TextStyle(fontSize: 14,color: Colors.white),);
                }
              },
            ),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: uygulamayiKapat,
        child: FutureBuilder<List<Notlar>>(
          future: tumNotlarGoster(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var notlarListesi =snapshot.data;
              return ListView.builder(
                itemCount: notlarListesi.length,
                itemBuilder: (context,indeks){
                  var notlar = notlarListesi[indeks];
                  return SizedBox(
                    height: 80,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder:(context)=> NotDetaySayfasi(not: notlar,)));
                      },
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(notlar.ders_adi,style: TextStyle(fontWeight: FontWeight.bold),),
                            Text(notlar.not1.toString()),
                            Text(notlar.not2.toString()),
                          ],

                        ),

                      ),
                    ),
                  );
                },
              );
            }else{
              return Center();
            }
          },


        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context)=> NotKayitSayfasi()));
        },
        tooltip: 'NOT EKLE ',
        child: const Icon(Icons.add),
      ),
    );
  }
}
