import 'package:flutter/material.dart';
import 'package:themoviedb/src/model/item_model.dart';

class GridCardWidget extends StatelessWidget {
  final ItemModel itemModel;

  GridCardWidget({this.itemModel});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Card(
        child: Stack(
          children: <Widget>[
            // imageStack(itemModel.results[]),
            descStack("This"),
          ],
        ),
      ),
    );
  }

  Widget imageStack(String img) => Image.network(
    img,
    fit: BoxFit.cover,
  );

  Widget descStack(String asd) => Positioned(
    bottom: 0.0,
    left: 0.0,
    right: 0.0,
    child: Container(
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                asd,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(asd,
                style: TextStyle(
                    color: Colors.yellow,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold))
          ],
        ),
      ),
    ),
  );
}