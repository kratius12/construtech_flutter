import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController dateInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dialog'),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: TextFormField(
          decoration: const InputDecoration(
            hintText: 'Date',
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1)),
          ),
          controller: dateInputController,
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                lastDate: DateTime(2050));

            if (pickedDate != null) {
              dateInputController.text =pickedDate.toString();
            }
          },
        ),
      )
      ),
    );
  }
  }