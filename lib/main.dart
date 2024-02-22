import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      // home: ListPage(),
      home: ListFulPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  final List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // throw UnimplementedError();
    return Scaffold(
        body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  print(1111111);
                },
              );
            }));
  }
}

class ListFulPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListFulPageState();
  }
}

class _ListFulPageState extends State<ListFulPage> {
  List<dynamic> messages = [];

  @override
  void initState() {
    print("init");
    super.initState();
    fetchData();
    print(33333);
  }

  Future<void> fetchData() async {
    var url = "http://162.14.74.245:8168/admin/document/allList";
    var Url = Uri.parse(url);
    var headers = {"Authorization": authToken};
    var response = await http.get(Url, headers: headers);
    if (response.statusCode == 200) {
      var parsedResponse = jsonDecode(utf8.decode(response.bodyBytes));
      var list = parsedResponse["data"]["list"];

      setState(() {
        messages = List<dynamic>.from(list);
        print(messages);
      });
    } else {}
  }

  // TextEditingController _textController = TextEditingController(); // Define TextEditingController here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("程浩的留言板"))),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var dyMessage = messages[index];
                      // Map<String,String> message = jsonDecode(dyMessage.toString());
                      return ListTile(
                        title: Text(dyMessage["sys_title"]),
                        subtitle: Text(dyMessage["created_at"]),
                      );
                    })),
            Column(children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  // controller: _textController,
                  onChanged: () {
                    // Update message content when text changes
                    setState(() {
                      messageContent = value;
                    });
                  },
                  autofocus: true,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "请输入您的留言",
                    hintText: "留言内容",
                    // prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
             Padding(padding: EdgeInsets.all(8.0),
             child: ElevatedButton(
               onPressed: () {
                 // Handle button press
                 print(2222222222);
               },
               child: Text('提交留言'),
             )) 
            ]),
          ],
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

var authToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwicGlkIjowLCJkZXB0SWQiOjEwMCwicm9sZUlkIjoxLCJyb2xlS2V5Ijoic3VwZXIiLCJ1c2VybmFtZSI6ImFkbWluIiwicmVhbE5hbWUiOiJBYXJvbiIsImF2YXRhciI6Imh0dHA6Ly8xNjIuMTQuNzQuMjQ1OjgxNjgvYXR0YWNobWVudC8yMDIzLTExLTA1L2N3cWpmMGsxYjBidXAxZHhjYS5qcGVnIiwiZW1haWwiOiIxMzM4MTQyNTBAcXEuY29tIiwibW9iaWxlIjoiMTUzMDM4MzA1NzEiLCJhcHAiOiJhZG1pbiIsImxvZ2luQXQiOiIyMDI0LTAyLTIyIDE0OjEzOjA0In0.WDRMK6PoTEXOtMQqoReSGLbTztKY97tfZB_WUIREMsM";
