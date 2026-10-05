import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_tokens.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        backgroundColor: AppColors.primary600,
        elevation: AppTokens.elevationSm,
      ),
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Placeholder for the actual map widget (e.g., GoogleMap)
          Container(
            color: Colors.grey[300],
            child: const Center(child: Text('Map view placeholder')),
          ),
          Positioned(
            right: AppTokens.spacingLg,
            bottom: AppTokens.spacingLg,
            child: FloatingActionButton(
              backgroundColor: AppColors.secondary600,
              onPressed: () {},
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
