import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/disclaimer_card.dart';
import '../presentation/bloc/analysis_bloc.dart';
import '../presentation/bloc/analysis_state.dart';


class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis Insights'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: BlocBuilder<AnalysisBloc, AnalysisState>(
        builder: (context, state) {
          if (state is AnalysisSuccess) {
            final report = state.dataReport;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                report.possibleCondition,
                                style: theme.textTheme.headlineMedium?.copyWith(height: 1.2),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                report.confidence,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(report.explanation, style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text('RAG Knowledge Actions', style: theme.textTheme.titleLarge),
                  const SizedBox(height: 12),
                  ...report.recommendations.map((rec) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.check_circle_outline_rounded, color: Colors.green),
                            const SizedBox(width: 12),
                            Expanded(child: Text(rec, style: theme.textTheme.bodyMedium)),
                          ],
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 24),
                  const DisclaimerCard(),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Analyze Again',
                          isSecondary: true,
                          onPressed: () => context.go('/home'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomButton(
                          text: 'Share Report',
                          icon: Icons.share_rounded,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Structural errors locating diagnostics asset report logs.'));
        },
      ),
    );
  }
}