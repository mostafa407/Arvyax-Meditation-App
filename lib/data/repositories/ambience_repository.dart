import '../models/ambience_model.dart';

class AmbienceRepository {
  Future<List<AmbienceModel>> getAmbiences() async {
    // هنرجع List فيها بيانات حقيقية مطابقة للـ Model بتاعك
    return [
      AmbienceModel(
        id: '1',
        title: 'Rainy Night',
        tag: 'Calm',
        duration: '10 min',
        description: 'Deep relaxation with the sound of tropical rain.',
        imagePath: 'assets/images/app_icon.jpg', // صورة الأيقونة مؤقتاً
        audioPath: 'assets/audio/rain.mp3',      // تأكد من وجود الملف ده
        recipes: ['Deep Breathing', 'Close your eyes'],
      ),
      AmbienceModel(
        id: '2',
        title: 'Focus Flow',
        tag: 'Focus',
        duration: '25 min',
        description: 'Ambient white noise for deep work.',
        imagePath: 'assets/images/app_icon.jpg',
        audioPath: 'assets/audio/focus.mp3',
        recipes: ['Pomodoro Technique'],
      ),
    ];
  }
}