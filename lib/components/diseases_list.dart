import 'package:check_app/components/action_card.dart';
import 'package:check_app/models/diseases.dart';
import 'package:flutter/material.dart';

class DiseasesList extends StatefulWidget {
  final List<Disease> diseases;

  DiseasesList(this.diseases);

  @override
  _DiseasesListState createState() => _DiseasesListState();
}

class _DiseasesListState extends State<DiseasesList> {
  final Map<int, bool> expandedTiles = {};

  bool _initiallyExpanded(index) {
    return expandedTiles[index] ?? false;
  }

  void _onExpansionChanged(bool state, int index) {
    if (state) {
      setState(() {
        expandedTiles[index] = true;
        expandedTiles.forEach((key, val) {
          if (key != index) expandedTiles[key] = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(4),
      itemCount: widget.diseases.length,
      itemBuilder: (context, index) {
        var disease = widget.diseases[index];
        return ExpansionTile(
          initiallyExpanded: _initiallyExpanded(index),
          onExpansionChanged: (state) => _onExpansionChanged(state, index),
          key: GlobalKey(),
          title: Text(
            disease.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w300,
            ),
          ),
          subtitle: Text(disease.description),
          children: disease.actions
              .map<Widget>((action) => ActionCard(action))
              .toList(),
        );
      },
    );
  }
}
