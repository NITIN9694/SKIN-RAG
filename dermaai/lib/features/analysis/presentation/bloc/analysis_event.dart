
import 'dart:io';

abstract class AnalysisEvent {}

class TriggerImageSelection extends AnalysisEvent {
  final bool useCamera;
  TriggerImageSelection({required this.useCamera});
}

class ConfirmImagePreview extends AnalysisEvent {
  final File selectedImage;
  ConfirmImagePreview(this.selectedImage);
}

class ExecuteSkinAnalysis extends AnalysisEvent {
  final File confirmedImage;
  ExecuteSkinAnalysis(this.confirmedImage);
}

class FetchAnalysisHistory extends AnalysisEvent {}

class DeleteHistoryEntry extends AnalysisEvent {
  final String id;
  DeleteHistoryEntry(this.id);
}