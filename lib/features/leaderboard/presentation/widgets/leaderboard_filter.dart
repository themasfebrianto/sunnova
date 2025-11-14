import 'package:flutter/material.dart';

class LeaderboardFilter extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const LeaderboardFilter({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: const <ButtonSegment<String>>[
        ButtonSegment<String>(value: 'WEEKLY', label: Text('Weekly')),
        ButtonSegment<String>(value: 'MONTHLY', label: Text('Monthly')),
      ],
      selected: <String>{selectedFilter},
      onSelectionChanged: (Set<String> newSelection) {
        onFilterChanged(newSelection.first);
      },
    );
  }
}
