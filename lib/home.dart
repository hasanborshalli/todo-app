import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formGlobalKey = GlobalKey<FormState>();
  Priority _selectedPriority = Priority.low;
  String _title = '';
  String _description = '';
  // final TextEditingController _emailController = TextEditingController();
  final List<Todo> todos = [
    const Todo(
        title: 'Buy milk',
        description: 'There is no milk left in the fridge!',
        priority: Priority.high),
    const Todo(
        title: 'Make the bed',
        description: 'Keep things tidy please..',
        priority: Priority.low),
    const Todo(
        title: 'Pay bills',
        description: 'The gas bill needs paying ASAP.',
        priority: Priority.urgent),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: TodoList(todos: todos)),

            // form stuff below here
            //   TextField(
            //     controller: _emailController,
            //     keyboardType: TextInputType.emailAddress,
            //     decoration: const InputDecoration(label: Text('Email Address')),
            //   ),
            //   const SizedBox(height: 20),
            //   FilledButton(
            //       onPressed: () {
            //         print(_emailController.text.trim());
            //       },
            //       child: const Text('print the email')),

            Form(
                key: _formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextFormField(
                        maxLength: 20,
                        decoration:
                            const InputDecoration(label: Text('Todo title')),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'You must enter a value for the title.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _title = value!;
                        }),
                    TextFormField(
                        maxLength: 50,
                        decoration: const InputDecoration(
                            label: Text('Todo description')),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 5) {
                            return 'Enter a description at least 5 characters long.';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _description = value!;
                        }),
                    DropdownButtonFormField(
                        value: _selectedPriority,
                        decoration: const InputDecoration(
                            label: Text('Priority of todo')),
                        items: Priority.values.map((p) {
                          return DropdownMenuItem(
                              value: p, child: Text(p.title));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedPriority = value!;
                          });
                        }),
                    const SizedBox(height: 20),
                    FilledButton(
                        onPressed: () {
                          if (_formGlobalKey.currentState!.validate()) {
                            _formGlobalKey.currentState!.save();
                            setState(() {
                              todos.add(Todo(
                                  title: _title,
                                  description: _description,
                                  priority: _selectedPriority));
                            });
                            _formGlobalKey.currentState!.reset();
                            _selectedPriority = Priority.low;
                          }
                        },
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4))),
                        child: const Text('Add'))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
