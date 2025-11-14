import 'package:flutter/material.dart';

class LeaderboardFilter extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterSelected;

  const LeaderboardFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ChoiceChip(
              label: Text(
                'Weekly',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: selectedFilter == 'WEEKLY'
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              selected: selectedFilter == 'WEEKLY',
              onSelected: (selected) {
                if (selected) onFilterSelected('WEEKLY');
              },
              selectedColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: selectedFilter == 'WEEKLY'
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ChoiceChip(
              label: Text(
                'Monthly',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: selectedFilter == 'MONTHLY'
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              selected: selectedFilter == 'MONTHLY',
              onSelected: (selected) {
                if (selected) onFilterSelected('MONTHLY');
              },
              selectedColor: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: selectedFilter == 'MONTHLY'
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
