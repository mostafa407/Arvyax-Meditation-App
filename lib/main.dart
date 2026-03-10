import 'package:arvyax/presentation/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Imports الخاصة بمشروعك (تأكد من صحة المسارات حسب مشروعك)
import 'core/di/injection_container.dart' as di;
import 'data/models/journal_model.dart';
import 'logic/player_bloc/player_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(JournalModelAdapter());
  }

  // فتح الـ Box الخاص بالـ Journal
  await Hive.openBox<JournalModel>('journals');

  // 2. إعداد Dependency Injection (GetIt)
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // توفير الـ PlayerBloc على مستوى التطبيق بالكامل عشان الـ Mini Player
      providers: [BlocProvider(create: (context) => di.sl<PlayerBloc>())],
      child: MaterialApp(
        title: 'ArvyaX',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          // إعداد ثيم هادئ Apple-style
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2D3142),
            background: const Color(0xFFF8F9FA),
          ),
          textTheme: const TextTheme(
            headlineMedium: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D1D1F),
            ),
          ),
        ),
        // الشاشة الرئيسية هي الـ HomeScreen التي صممناها
        home: const HomeScreen(),
      ),
    );
  }
}
