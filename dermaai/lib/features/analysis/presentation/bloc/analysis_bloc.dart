import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/analysis_repository.dart';
import 'analysis_event.dart';
import 'analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  final AnalysisRepository repository;

  AnalysisBloc(this.repository) : super(AnalysisInitial()) {
    on<ConfirmImagePreview>(_onConfirmImagePreview);
    on<ExecuteSkinAnalysis>(_onExecuteSkinAnalysis);
    on<FetchAnalysisHistory>(_onFetchAnalysisHistory);
    on<DeleteHistoryEntry>(_onDeleteHistoryEntry);
  }

  void _onConfirmImagePreview(ConfirmImagePreview event, Emitter<AnalysisState> emit) {
    emit(ImageSelectionSuccess(event.selectedImage));
  }

  Future<void> _onExecuteSkinAnalysis(
      ExecuteSkinAnalysis event,
      Emitter<AnalysisState> emit,
      ) async {
    try {
      // Step 1: Uploading
      emit( AnalysisProcessing('Uploading structural image details...'));

      // Execute network call concurrently with smooth status transitions
      final analysisFuture = repository.analyzeSkinImage(event.confirmedImage);

      // Step 2: Localized features
      await Future.delayed(const Duration(milliseconds: 800));
      if (emit.isDone) return;
      emit( AnalysisProcessing('Extracting localized epidermal features...'));

      // Step 3: RAG model matching
      await Future.delayed(const Duration(milliseconds: 800));
      if (emit.isDone) return;
      emit( AnalysisProcessing('Cross-referencing RAG medical models...'));

      // Step 4: Final Synthesis
      await Future.delayed(const Duration(milliseconds: 800));
      if (emit.isDone) return;
      emit( AnalysisProcessing('Synthesizing final diagnostic report...'));

      // Wait for the actual backend response
      final diagnosticReport = await analysisFuture;

      // Final State: Success
      emit(AnalysisSuccess(diagnosticReport));
    } catch (e) {
      emit(AnalysisFailure(e.toString()));
    }
  }

  Future<void> _onFetchAnalysisHistory(
      FetchAnalysisHistory event,
      Emitter<AnalysisState> emit,
      ) async {
    try {
      final records = await repository.getLocalHistory();
      emit(HistoryLoadSuccess(List.from(records)));
    } catch (e) {
      emit( AnalysisFailure("Failed loading database logs."));
    }
  }

  Future<void> _onDeleteHistoryEntry(
      DeleteHistoryEntry event,
      Emitter<AnalysisState> emit,
      ) async {
    try {
      await repository.deleteAnalysis(event.id);
      final records = await repository.getLocalHistory();
      emit(HistoryLoadSuccess(List.from(records)));
    } catch (e) {
      emit( AnalysisFailure("Error manipulating core storage records."));
    }
  }
}