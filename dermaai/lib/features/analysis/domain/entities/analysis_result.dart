import '../../domain/entities/analysis_result.dart';

class AnalysisModel extends AnalysisResult {
  AnalysisModel({
    required super.id,
    required super.imagePath,
    required super.possibleCondition,
    required super.confidence,
    required super.explanation,
    required super.recommendations,
    required super.disclaimer,
    required super.dateTime,
  });

  factory AnalysisModel.fromJson(Map<String, dynamic> json, String localImagePath) {
    // Format confidence nicely (e.g., "moderate" -> "Moderate", "94%" -> "94%")
    final rawConfidence = (json['confidence'] ?? 'Unknown').toString().trim();
    final formattedConfidence = rawConfidence.length > 1
        ? '${rawConfidence[0].toUpperCase()}${rawConfidence.substring(1)}'
        : rawConfidence.toUpperCase();

    // Safely parse recommendations list
    final parsedRecommendations = (json['recommendations'] as List?)
        ?.map((e) => e.toString())
        .toList() ??
        [];

    // Parse existing date if loading from cache, otherwise default to current time
    final parsedDate = json['dateTime'] != null
        ? DateTime.tryParse(json['dateTime'].toString()) ?? DateTime.now()
        : DateTime.now();

    return AnalysisModel(
      id: json['id']?.toString() ?? DateTime.now().microsecondsSinceEpoch.toString(),
      imagePath: localImagePath,
      possibleCondition: json['possible_condition']?.toString() ?? 'Unknown Condition',
      confidence: formattedConfidence,
      explanation: json['explanation']?.toString() ?? 'No detailed explanation provided by engine.',
      recommendations: parsedRecommendations,
      disclaimer: json['disclaimer']?.toString() ?? '',
      dateTime: parsedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imagePath': imagePath,
      'possible_condition': possibleCondition,
      'confidence': confidence,
      'explanation': explanation,
      'recommendations': recommendations,
      'disclaimer': disclaimer,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}

class AnalysisResult {
  final String id;
  final String imagePath;
  final String possibleCondition;
  final String confidence;
  final String explanation;
  final List<String> recommendations;
  final String disclaimer;
  final DateTime dateTime;

  AnalysisResult({
    required this.id,
    required this.imagePath,
    required this.possibleCondition,
    required this.confidence,
    required this.explanation,
    required this.recommendations,
    required this.disclaimer,
    required this.dateTime,
  });
}