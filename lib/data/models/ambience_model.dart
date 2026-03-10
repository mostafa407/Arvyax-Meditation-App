class AmbienceModel {
  final String id;
  final String title;
  final String tag; // Focus, Calm, Sleep, Reset
  final String duration;
  final String description;
  final String imagePath;
  final String audioPath;
  final List<String> recipes;

  AmbienceModel({
    required this.id,
    required this.title,
    required this.tag,
    required this.duration,
    required this.description,
    required this.imagePath,
    required this.audioPath,
    required this.recipes,
  });

  // لتحويل الـ JSON لـ Model
  factory AmbienceModel.fromJson(Map<String, dynamic> json) {
    return AmbienceModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      tag: json['tag'] ?? '',
      duration: json['duration'] ?? '',
      description: json['description'] ?? '',
      imagePath: json['imagePath'] ?? '',
      audioPath: json['audioPath'] ?? '',
      recipes: List<String>.from(json['recipes'] ?? []),
    );
  }

  // لتحويل الـ Model لـ JSON (لو احتجنا نخزنه في Hive مثلاً)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tag': tag,
      'duration': duration,
      'description': description,
      'imagePath': imagePath,
      'audioPath': audioPath,
      'recipes': recipes,
    };
  }
}
