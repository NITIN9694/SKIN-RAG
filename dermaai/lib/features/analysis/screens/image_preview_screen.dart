import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_button.dart';
import '../presentation/bloc/analysis_bloc.dart';
import '../presentation/bloc/analysis_event.dart';
import '../presentation/bloc/analysis_state.dart';


class ImagePreviewScreen extends StatelessWidget {
  const ImagePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Capture Content')),
      body: BlocBuilder<AnalysisBloc, AnalysisState>(
        builder: (context, state) {
          if (state is ImageSelectionSuccess) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: Container(
                        color: Colors.black12,
                        child: const Icon(Icons.wallpaper_rounded, size: 84, color: Colors.black26),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Retake',
                          isSecondary: true,
                          onPressed: () => context.pop(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomButton(
                          text: 'Analyze',
                          onPressed: () {
                            BlocProvider.of<AnalysisBloc>(context).add(ExecuteSkinAnalysis(state.image));
                            context.push('/loading');
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('No evaluation material target selected.'));
        },
      ),
    );
  }
}