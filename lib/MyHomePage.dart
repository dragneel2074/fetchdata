import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userId;
  var title;
  var completed;
  var typedName;

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  getData() async {
    var url =
        Uri.parse('https://jsonplaceholder.typicode.com/todos/$typedName');
    http.Response response = await http.get(url);
//print(response.statusCode);

    if (response.statusCode == 200) {
      var results = jsonDecode(response.body);
      //  print(response.body.runtimeType);
      setState(() {
        this.userId = results['userId'];
        this.title = results['title'];
        this.completed = results['completed'];
        // print(this.userId);
      });
    } else {
      print('error fetching the data');
    }
  }

  @override
  Widget build(BuildContext context) {
    //getData();
    return Scaffold(
   //   resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Fetch Data From Internet'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Column(
            //    mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Padding(
                padding: EdgeInsets.all(40),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    hintText: 'Enter ID',
                  ),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        typedName = value;
                      });
                    }
                  },
                ),
              ),
              ElevatedButton(
                // style: style,
                child: Text('Get User Data'),
                onPressed: () {
                  getData();
                },
              ),
              Container(
                child: Text(
                  userId != null ? 'UserID is $userId' : 'UserID Loading',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(
                  title != null ? 'title is $title' : 'Title Loading',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Text(
                  completed != null ? 'Task Completed is $completed' : 'Task status loading',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
