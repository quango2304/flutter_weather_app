import 'package:flutter/material.dart';

/// General utility widget used to render a cell divided into three rows
/// First row displays [label]
/// second row displays [iconData]
/// third row displays [value]
class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final String? iconUrl;

  ValueTile(this.label, this.value, {this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          this.label,
        ),
        SizedBox(
          height: 5,
        ),
        iconUrl != null
            ? Image.network(
                iconUrl!,
                width: 20,
              )
            : SizedBox(),
        SizedBox(
          height: 10,
        ),
        Text(
          this.value,
        ),
      ],
    );
  }
}
