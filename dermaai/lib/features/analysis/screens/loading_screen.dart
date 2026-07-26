import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../presentation/bloc/analysis_bloc.dart';
import '../presentation/bloc/analysis_state.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  int _getStepIndex(String status) {
    if (status.contains('Extracting')) return 1;
    if (status.contains('RAG') || status.contains('Cross-referencing')) return 2;
    if (status.contains('Synthesizing') || status.contains('report')) return 3;
    return 0; // Uploading or initial
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocListener<AnalysisBloc, AnalysisState>(
        listener: (context, state) {
      if (state is AnalysisSuccess) {
        context.go('/result');
      } else if (state is AnalysisFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.failureMessage),
            backgroundColor: theme.colorScheme.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        if (context.canPop()) {
          context.pop();
        } else {
          context.go('/home');
        }
      }
    },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                children: [
                  const Spacer(),

                  // 1. Scanner Pulsing Icon Container
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary.withOpacity(
                            0.05 + (_pulseController.value * 0.1),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withOpacity(
                                0.15 * _pulseController.value,
                              ),
                              blurRadius: 30 * _pulseController.value,
                              spreadRadius: 10 * _pulseController.value,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 90,
                                height: 90,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  strokeCap: StrokeCap.round,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF1E293B)
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.colorScheme.primary.withOpacity(0.3),
                                  ),
                                ),
                                child: Icon(
                                  Icons.auto_awesome_rounded,
                                  size: 32,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 48),

                  // 2. Dynamic Stage Status Text
                  BlocBuilder<AnalysisBloc, AnalysisState>(
                    builder: (context, state) {
                      String dynamicMessage = 'Initializing AI engine...';
                      int currentStep = 0;

                      if (state is AnalysisProcessing) {
                        dynamicMessage = state.activeProcessingMessage;
                        currentStep = _getStepIndex(dynamicMessage);
                      }

                      return Column(
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 350),
                            transitionBuilder: (child, animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.2),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child,
                                ),
                              );
                            },
                            child: Text(
                              dynamicMessage,
                              key: ValueKey<String>(dynamicMessage),
                              textAlign: TextAlign.center,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          Text(
                            'Cross-referencing vision models and RAG knowledge base...',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                            ),
                          ),

                          const SizedBox(height: 36),

                          // 3. Step Progress Indicators
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(4, (index) {
                              final isActive = index <= currentStep;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                height: 6,
                                width: isActive ? 28 : 8,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? theme.colorScheme.primary
                                      : (isDark
                                      ? const Color(0xFF334155)
                                      : const Color(0xFFE2E8F0)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              );
                            }),
                          ),
                        ],
                      );
                    },
                  ),

                  const Spacer(),

                  // 4. Cancel Button
                  TextButton.icon(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close_rounded, size: 18),
                    label: const Text('Cancel Analysis'),
                    style: TextButton.styleFrom(
                      foregroundColor: theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));

  }
}