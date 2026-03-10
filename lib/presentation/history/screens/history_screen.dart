import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/injection_container.dart';
import '../../../data/models/journal_model.dart';
import '../../../logic/journal/journal_cubit.dart';
import 'package:intl/intl.dart';

import '../../../logic/journal/journal_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<JournalCubit>()..loadJournals(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          title: const Text(
            "Journal History",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
        ),
        body: BlocBuilder<JournalCubit, JournalState>(
          // التغيير هنا: استخدمنا JournalState
          builder: (context, state) {
            // 1. حالة التحميل
            if (state is JournalLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2. حالة الخطأ
            if (state is JournalError) {
              return Center(child: Text(state.message));
            }

            // 3. حالة النجاح (البيانات وصلت)
            if (state is JournalLoaded) {
              final journals = state.journals;

              if (journals.isEmpty) {
                return const Center(child: Text("No memories yet."));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: journals.length,
                itemBuilder: (context, index) {
                  final journal = journals[index];
                  // تحويل التاريخ بأمان
                  DateTime date;
                  try {
                    date = DateTime.parse(journal.date);
                  } catch (e) {
                    date = DateTime.now();
                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              journal.ambienceTitle,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              DateFormat('MMM dd').format(date),
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          journal.entry,
                          style: const TextStyle(
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
