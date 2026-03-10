import 'package:flutter/material.dart';

import '../../../logic/home_cubit/home_cubit.dart';
import '../../../logic/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TagFilters extends StatelessWidget {
  const TagFilters();

  @override
  Widget build(BuildContext context) {
    final tags = ['All', 'Focus', 'Calm', 'Sleep', 'Reset'];
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final isSelected = state.selectedTag == tags[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(tags[index]),
                  selected: isSelected,
                  onSelected: (_) => context.read<HomeCubit>().filterAmbiences(
                    '',
                    tags[index],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
