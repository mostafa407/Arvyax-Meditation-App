import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/home_cubit/home_cubit.dart';
import '../../../logic/home_cubit/home_state.dart';
import '../../../core/di/injection_container.dart';

import '../Widgets/AmbienceCard.dart';
import '../Widgets/SearchBar.dart';
import '../Widgets/TagFilters.dart';

import '../Widgets/mini_player.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..loadAmbiences(),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Explore",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -1,
                            ),
                          ),
                          SizedBox(height: 16),
                          SearchBars(),
                        ],
                      ),
                    ),
                  ),

                  const SliverToBoxAdapter(child: TagFilters()),

                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state.status == HomeStatus.loading) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (state.filteredList.isEmpty) {
                        return SliverFillRemaining(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("No ambiences found"),
                              TextButton(
                                onPressed: () =>
                                    context.read<HomeCubit>().clearFilters(),
                                child: const Text("Clear Filters"),
                              ),
                            ],
                          ),
                        );
                      }

                      return SliverPadding(
                        padding: const EdgeInsets.all(20),
                        sliver: SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio: 0.8,
                              ),
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final item = state.filteredList[index];
                            return AmbienceCard(ambience: item);
                          }, childCount: state.filteredList.length),
                        ),
                      );
                    },
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),

              const Align(
                alignment: Alignment.bottomCenter,
                child: MiniPlayer(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
