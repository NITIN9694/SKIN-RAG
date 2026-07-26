import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation/bloc/analysis_bloc.dart';
import '../presentation/bloc/analysis_state.dart';


class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocListener<AnalysisBloc, AnalysisState>(
      listener: (context, state) {
        if (state is AnalysisSuccess) {
          context.go('/result');
        } else if (state is AnalysisFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.failureMessage), backgroundColor: theme.colorScheme.error),
          );
          context.pop();
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: BlocBuilder<AnalysisBloc, AnalysisState>(
              builder: (context, state) {
                String dynamicMessage = 'Processing image matrix data...';
                if (state is AnalysisProcessing) {
                  dynamicMessage = state.activeProcessingMessage;
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                            strokeCap: StrokeCap.round,
                            valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                          ),
                        ),
                        Icon(Icons.biotech_rounded, size: 40, color: theme.colorScheme.primary),
                      ],
                    ),
                    const SizedBox(height: 40),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        dynamicMessage,
                        key: ValueKey<String>(dynamicMessage),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}