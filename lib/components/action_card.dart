import 'package:check_app/config_size.dart';
import 'package:check_app/constants.dart';
import 'package:check_app/models/action_info.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ActionCard extends StatefulWidget {
  final ActionInfo action;

  ActionCard(this.action);

  @override
  _ActionCardState createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, informativeRoute),
      child: Card(
        elevation: 2.5,
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
          width: SizeConfig.screenWidth,
          height: SizeConfig.blockSizeVertical * 15,
          color: Colors.white12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ListTile(
                leading: Icon(
                  IconData(0xe57b, fontFamily: 'MaterialIcons'),
                  color: Colors.amber,
                ),
                title: Text(
                  widget.action.name,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                  child: Text(
                    widget.action.disclaimer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
