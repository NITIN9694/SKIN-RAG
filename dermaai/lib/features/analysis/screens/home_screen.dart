import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/widgets/disclaimer_card.dart';
import '../presentation/bloc/analysis_bloc.dart';
import '../presentation/bloc/analysis_event.dart';
import '../presentation/bloc/analysis_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// Opens the native device camera or image gallery.
  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 85, // Optimizes payload size for fast API upload
        maxWidth: 1080,
        maxHeight: 1080,
      );

      if (pickedFile == null) return;

      final File imageFile = File(pickedFile.path);

      if (context.mounted) {
        BlocProvider.of<AnalysisBloc>(context).add(ConfirmImagePreview(imageFile));
        context.push('/preview');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to select image: ${e.toString()}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Top Bar Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.health_and_safety_rounded,
                          color: theme.colorScheme.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'DermaAI',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 2. Welcome Headline & Description
              Text(
                'AI Skin Analysis',
                style: theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Capture or upload a clear photo for instantaneous AI-powered skin feature evaluation.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 28),

              // 3. Action Cards (Camera & Gallery)
              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      context,
                      label: 'Take Photo',
                      subtitle: 'Use Camera',
                      icon: Icons.camera_alt_rounded,
                      isPrimary: true,
                      onTap: () => _pickImage(context, ImageSource.camera),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildActionCard(
                      context,
                      label: 'Choose Gallery',
                      subtitle: 'Upload Photo',
                      icon: Icons.photo_library_rounded,
                      isPrimary: false,
                      onTap: () => _pickImage(context, ImageSource.gallery),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // 4. History Section Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Scans',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View all',
                      style: TextStyle(color: theme.colorScheme.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),



              const SizedBox(height: 32),

              // 6. Disclaimer Card
              const DisclaimerCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionCard(
      BuildContext context, {
        required String label,
        required String subtitle,
        required IconData icon,
        required bool isPrimary,
        required VoidCallback onTap,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBg = isPrimary
        ? (isDark ? const Color(0xFF1E293B) : const Color(0xFFF0FDF4))
        : theme.cardTheme.color;

    final borderColor = isPrimary
        ? (isDark ? const Color(0xFF00A896).withOpacity(0.4) : const Color(0xFFCCFBF1))
        : (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0));

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isPrimary
                    ? theme.colorScheme.primary
                    : theme.colorScheme.primary.withOpacity(0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                size: 26,
                color: isPrimary ? Colors.white : theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}