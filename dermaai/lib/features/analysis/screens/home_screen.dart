import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/widgets/disclaimer_card.dart';
import '../presentation/bloc/analysis_bloc.dart';
import '../presentation/bloc/analysis_event.dart';


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

      if (pickedFile == null) {
        // User canceled the picker dialog without picking an image
        return;
      }

      final File imageFile = File(pickedFile.path);

      if (context.mounted) {
        // Notify the BLoC with the actual file
        BlocProvider.of<AnalysisBloc>(context).add(ConfirmImagePreview(imageFile));

        // Navigate to preview screen
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text('AI Skin Analysis', style: theme.textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text(
                'Capture or upload an image for immediate, AI-powered skin assessment insights.',
                style: theme.textTheme.bodyLarge?.copyWith(color: theme.hintColor),
              ),
              const SizedBox(height: 36),

              Row(
                children: [
                  Expanded(
                    child: _buildActionCard(
                      context,
                      label: 'Take Photo',
                      icon: Icons.camera_alt_rounded,
                      onTap: () => _pickImage(context, ImageSource.camera),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildActionCard(
                      context,
                      label: 'Choose Gallery',
                      icon: Icons.photo_library_rounded,
                      onTap: () => _pickImage(context, ImageSource.gallery),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),
              Text('Recent Analysis Tasks', style: theme.textTheme.titleLarge),
              const SizedBox(height: 12),

              Card(
                elevation: 0,
                color: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: theme.dividerColor.withOpacity(0.05)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(Icons.folder_open_rounded, size: 48, color: theme.disabledColor),
                      const SizedBox(height: 12),
                      Text('No evaluations documented yet.', style: theme.textTheme.bodyMedium),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
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
        required IconData icon,
        required VoidCallback onTap,
      }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 36, color: theme.colorScheme.primary),
            const SizedBox(height: 16),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}