import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  var data;
  Future<void> getApi()async
  {

    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if(response.statusCode==200)
    {
      data=jsonDecode(response.body.toString());

    }
    else
    {


    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Appbar"),),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
              future: getApi(),
              builder: (context,snapshot)
          {
            if(snapshot.connectionState==ConnectionState.waiting)
            {

              return Text("Loading");
            }
            else
            {

              return ListView.builder(

                  itemCount: data.length,
                  itemBuilder: (context,index)
              {
                return Card(
                  child: Column(children: [
                    Reusable(title: "Name", value: data![index]['name'].toString()),
                    SizedBox(height: 10,),
                    Reusable(title: "User Name", value: data![index]['username'].toString()),
                    SizedBox(height: 10,),
                    Reusable(title: "Email", value: data![index]['email'].toString()),
                    SizedBox(height: 10,),
                    Reusable(title: "Address", value: data![index]['address']['street'].toString())

                  ],
                  ),
                );



              });
            }

            return Text("sdadad");
          })
          )
        ],
      ),

    );
  }
}

class Reusable extends StatelessWidget {
  String title,value;
  Reusable({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),

          Text(value)

        ],

      ),
    );
  }
}

