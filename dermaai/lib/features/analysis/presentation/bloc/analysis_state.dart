import 'dart:io';
import '../../domain/entities/analysis_result.dart';

abstract class AnalysisState {}

class AnalysisInitial extends AnalysisState {}

class ImageSelectionSuccess extends AnalysisState {
  final File image;
  ImageSelectionSuccess(this.image);
}

class AnalysisProcessing extends AnalysisState {
  final String activeProcessingMessage;
  AnalysisProcessing(this.activeProcessingMessage);
}

class AnalysisFailure extends AnalysisState {
  final String failureMessage;
  AnalysisFailure(this.failureMessage);
}

class AnalysisSuccess extends AnalysisState {
  final AnalysisResult dataReport;
  AnalysisSuccess(this.dataReport);
}

class HistoryLoadSuccess extends AnalysisState {
  final List<AnalysisResult> analyticalRecords;
  HistoryLoadSuccess(this.analyticalRecords);
}
