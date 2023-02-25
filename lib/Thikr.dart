import 'package:flutter/material.dart';

class ThikerPage extends StatefulWidget {
  const ThikerPage({super.key});

  @override
  State<ThikerPage> createState() => _ThikerPageState();
}

class _ThikerPageState extends State<ThikerPage> {
  @override
  int count = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thiker"),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 12,
        ),
        Container(
          margin: const EdgeInsets.only(top: 0, left: 10, right: 20, bottom: 0),
          width: double.infinity,
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 20,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Color.fromARGB(255, 21, 151, 211),
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                    "سبحان الله",
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      count += 1;
                    });
                  },
                  icon: Icon(Icons.add)),
              Spacer(),
              Text(
                "$count",
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    setState(() {
                      count -= 1;
                    });
                  },
                  icon: Icon(Icons.remove)),
            ],
          ),
        )
      ]),
    );
  }
}
