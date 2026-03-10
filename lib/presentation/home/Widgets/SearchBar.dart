import 'package:flutter/material.dart';

import '../../../logic/home_cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchBars extends StatelessWidget {
  const SearchBars();

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) => context.read<HomeCubit>().filterAmbiences(
        value,
        context.read<HomeCubit>().state.selectedTag,
      ),
      decoration: InputDecoration(
        hintText: "Search ambiences...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
