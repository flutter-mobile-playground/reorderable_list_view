import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reorderable List View',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        backgroundColor: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<int> _list = List.generate(50, (index) => index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Reorderable List View'),
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.all(8),
        proxyDecorator: (child, index, animation) {
          return child;
          /*return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              return Material(
                color: Colors.blue,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(6),
                child: child,
              );
            },
            child: child,
          );*/
        },
        children: List.generate(
          _list.length,
          (index) => Card(
            key: Key('$index'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: ListTile(
              // tileColor: Colors.blue[100 + (100 * (index % 2))], // Use this to ever have one line diferent to outer
              tileColor: _list[index].isOdd ? Colors.blue[100] : Colors.blue[200],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              title: Text('Item: ${_list[index]}'),
              trailing: const Icon(Icons.drag_handle),
            ),
          ),
        ),
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }
            final int item = _list.removeAt(oldIndex);
            _list.insert(newIndex, item);
          });
        },
      ),
    );
  }
}
