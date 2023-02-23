import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoapp/constants/todo_style.dart';
import 'package:todoapp/screens/home_screen.dart';

import '../data/database.dart';

class UpdateToDo extends StatefulWidget {
  final titlecontroller;
  final todocontroller;
  final int index;
  final String previousdate;
  VoidCallback? onSave;
  VoidCallback onCancel;

  UpdateToDo({
    super.key,
    required this.titlecontroller,
    required this.todocontroller,
    this.onSave,
    required this.index,
    required this.previousdate,
    required this.onCancel,
  });

  @override
  State<UpdateToDo> createState() => _UpdateToDoState();
}

class _UpdateToDoState extends State<UpdateToDo> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _todocontroller = TextEditingController();
  TextEditingController _titlecontroller = TextEditingController();
  var date = DateTime.now();
  ToDoDataBase db = ToDoDataBase();
  final _myBox = Hive.box('mybox');

// update new task
  void UpdateTodo() {
    setState(() {
      // print(db.toDoList);
      // db.toDoList.insert(widget.index, [
      //   _titlecontroller.text,
      //   _todocontroller.text,
      //   "${date.day}/${date.month}/${date.year}"
      // ]);
      db.toDoList[widget.index] = [
        _titlecontroller.text,
        _todocontroller.text,
        "${date.day}/${date.month}/${date.year}"
      ];

      _todocontroller.clear();
      _titlecontroller.clear();
      db.updateDataBase();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  void initState() {
    _todocontroller.text = widget.todocontroller;
    _titlecontroller.text = widget.titlecontroller;
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }

  // delete task
  void deleteTask() {
    setState(() {
      db.toDoList.removeAt(widget.index);
      db.updateDataBase();
      _todocontroller.clear();
      _titlecontroller.clear();

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  void aletbottombar() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                  onPressed: (() {
                    deleteTask();
                  }),
                  child: Text(
                    "DELETE",
                    style: TextStyle(color: Color(0xffF35D5D)),
                  )),
              TextButton(
                  onPressed: (() {
                    Navigator.of(context).pop();
                  }),
                  child: Text(
                    "CANCEL",
                    style: TextStyle(color: Color(0xff9E9E9E)),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: (() {
                              Navigator.pop(context);
                            }),
                            child: Icon(Icons.arrow_back)),
                        PopupMenuButton<int>(
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Text("Delete"),
                            ),
                          ],
                          offset: Offset(0, 60),
                          color: Colors.white,
                          elevation: 2,
                          onSelected: (value) {
                            aletbottombar();
                          },
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 31,
                    ),

                    // get user input
                    Text(widget.previousdate),
                    TextFormField(
                      style: ToDoStyle.fontWeight600FontSize24,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      controller: _titlecontroller,
                      decoration: ToDoStyle.titleDecoration,
                    ),
                    Container(
                      height: height,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight:
                              height, //when it reach the max it will use scroll
                          maxWidth: width,
                        ),
                        child: Expanded(
                          child: TextFormField(
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                              scrollPadding: EdgeInsets.all(20.0),
                              autofocus: true,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              minLines: 1,
                              controller: _todocontroller,
                              decoration: ToDoStyle.newtaskDecoration),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: UpdateTodo,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
