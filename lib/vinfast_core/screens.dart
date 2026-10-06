// lib/vinfast_core/screens.dart
import 'package:flutter/material.dart';
import 'widgets/common.dart';

/// A generic prototype screen used for the 100+ demo pages.
/// Each screen shows its index and provides navigation buttons to
/// the previous and next screens, demonstrating communication via
/// Navigator and the shared Design System tokens.
class PrototypeScreen extends StatelessWidget {
  final int index;
  const PrototypeScreen(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final int? next = index < 100 ? index + 1 : null;
    final int? prev = index > 1 ? index - 1 : null;

    return BaseScreen(
      title: 'Screen $index',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Center(
              child: Text(
                'Prototype Screen $index',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (prev != null)
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_back),
              label: Text('Previous (Screen $prev)'),
              onPressed: () => Navigator.pushNamed(context, '/screen$prev'),
            ),
          if (next != null)
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward),
              label: Text('Next (Screen $next)'),
              onPressed: () => Navigator.pushNamed(context, '/screen$next'),
            ),
        ],
      ),
    );
  }
}

/// Generates a map of 100 routes (`/screen1` … `/screen100`).
Map<String, WidgetBuilder> generateRoutes() {
  final Map<String, WidgetBuilder> routes = {};
  for (var i = 1; i <= 100; i++) {
    routes['/screen$i'] = (context) => PrototypeScreen(i);
  }
  return routes;
}
