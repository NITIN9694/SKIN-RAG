import 'dart:io';
import '../entities/analysis_result.dart';

abstract class AnalysisRepository {
  Future<AnalysisResult> analyzeSkinImage(File image);
  Future<List<AnalysisResult>> getLocalHistory();
  Future<void> deleteAnalysis(String id);
}