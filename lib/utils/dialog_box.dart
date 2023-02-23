import 'package:flutter/material.dart';
import 'package:todoapp/constants/todo_style.dart';

class DialogBox extends StatelessWidget {
  final titlecontroller;
  final todocontroller;
  final int? index;
  VoidCallback? onSave;

  DialogBox({
    super.key,
    required this.titlecontroller,
    required this.todocontroller,
    this.onSave,
    this.index,
  });
  final _formKey = GlobalKey<FormState>();
  var date = DateTime.now();

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

                    InkWell(
                        onTap: (() {
                          Navigator.pop(context);
                        }),
                        child: Icon(Icons.arrow_back)),

                    SizedBox(
                      height: 31,
                    ),

                    // get user input
                    Text("${date.day}/${date.month}/${date.year}"),
                    TextFormField(
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        controller: titlecontroller,
                        decoration: ToDoStyle.titleDecoration),
                    Container(
                      height: height,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight:
                              height, //when it reach the max it will use scroll
                          maxWidth: width,
                        ),
                        child: TextFormField(
                            style: ToDoStyle.fontWeight400FontSize15,
                            scrollPadding: EdgeInsets.all(20.0),
                            autofocus: true,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            minLines: 1,
                            controller: todocontroller,
                            decoration: ToDoStyle.newtaskDecoration),
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
        onPressed: onSave,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
    );
  }
}
