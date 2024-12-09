import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> tasks = [
    {
      'title': 'Meeting With Client',
      'description':
          'Redesign motion graphic and call to client. Also ask him to give more info. about project.',
      'time': '10:05 am 24th April',
    },
    {
      'title': 'Design Cards',
      'description': 'Design cards for upcoming party days.',
      'time': '11:20 am 24th April',
    },
    {
      'title': 'Go for meeting',
      'description': 'Design cards for upcoming party days.',
      'time': '12:30 pm 24th April',
    },
    {
      'title': 'Send project to client',
      'description':
          'Redesign motion graphic and call to client. Also ask him to give more info. about project.',
      'time': '01:00 pm 24th April',
    },
    {
      'title': 'Scrum meeting',
      'description': 'Design cards for upcoming party days.',
      'time': '02:30 pm 24th April',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 4, 36, 124),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 36, 124),
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_box_outlined,
              color: Colors.white,
            ),
            Text(
              'To-do',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: const Color(0xFF5476de),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tasks[index]["title"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                tasks[index]["description"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(height: 15),
                              const Divider(),
                              Text(
                                tasks[index]["time"],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "add new Task",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
