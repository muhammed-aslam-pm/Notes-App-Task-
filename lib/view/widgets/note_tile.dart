import 'package:flutter/material.dart';
import 'package:hive_with_adapter_sample/utils/db/db.dart';

class NoteTile extends StatefulWidget {
  const NoteTile({
    super.key,
    required this.tilte,
    required this.description,
    required this.date,
    required this.category,
    required this.color,
    required this.onDelete,
    required this.onUpdate,
  });
  final String tilte;
  final String description;
  final String date;
  final String category;
  final int color;
  final void Function()? onDelete;
  final void Function()? onUpdate;

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Database.myColors[widget.color],
            borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.tilte,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: widget.onUpdate,
                          icon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: widget.onDelete,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  widget.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.category,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  widget.date,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
