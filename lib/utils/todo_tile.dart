import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoapp/constants/todo_style.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/utils/update_todo.dart';

import 'dialog_box.dart';

class ToDoTile extends StatefulWidget {
  final String taskName;
  final String taskCompleted;
  final String date;
  final int index;

  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.date,
    required this.taskCompleted,
    required this.index,
    required this.deleteFunction,
  });

  @override
  State<ToDoTile> createState() => _ToDoTileState();
}

class _ToDoTileState extends State<ToDoTile> {
  ToDoDataBase db = ToDoDataBase();
  var date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: widget.deleteFunction,
              icon: Icons.delete,
              backgroundColor: Color(0xffF35D5D),
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: InkWell(
          onTap: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UpdateToDo(
                          index: widget.index,
                          previousdate: widget.date,
                          titlecontroller: widget.taskName,
                          todocontroller: widget.taskCompleted,
                          onCancel: () => Navigator.of(context).pop(),
                        )));
          }),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xffF4F4F4),
              borderRadius: BorderRadius.circular(08),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.date, style: ToDoStyle.fontWeight400FontSize12),
                SizedBox(
                  height: 6,
                ),
                Text(widget.taskName,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: ToDoStyle.fontWeight600FontSize16),
                SizedBox(
                  height: 6,
                ),
                Text(widget.taskCompleted,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: ToDoStyle.fontWeight400FontSize15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
