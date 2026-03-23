import 'package:flutter/material.dart';
import 'package:flare_skeleton/flare_skeleton.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlareSkeleton Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlareSkeleton'),
        actions: [
          IconButton(
            icon: Icon(_isLoading ? Icons.stop : Icons.refresh),
            onPressed: () => setState(() => _isLoading = !_isLoading),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // List tiles
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Text('List Tiles',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ...List.generate(3, (_) =>
              SkeletonLoader(
                isLoading: _isLoading,
                skeleton: const SkeletonListTile(),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: const Text('John Doe'),
                  subtitle: const Text('iOS Developer'),
                ),
              ),
            ),

            const Divider(),

            // Cards grid
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text('Cards Grid',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SkeletonLoader(
                isLoading: _isLoading,
                skeleton: const SkeletonGrid(crossAxisCount: 2, itemCount: 4),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                  children: List.generate(4, (i) => Card(
                    child: Center(child: Text('Item ${i+1}')),
                  )),
                ),
              ),
            ),

            const Divider(),

            // Paragraph
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text('Paragraph',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SkeletonLoader(
                isLoading: _isLoading,
                skeleton: const SkeletonParagraph(lines: 5),
                child: const Text(
                  'This is the real content that appears after loading. '
                  'The skeleton loading effect provides a smooth user experience '
                  'while data is being fetched from the server.',
                ),
              ),
            ),

            const Divider(),

            // Custom skeleton
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text('Custom Theme',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SkeletonListTile(
                theme: FlareSkeletonTheme(
                  baseColor: Colors.blue.shade100,
                  highlightColor: Colors.blue.shade50,
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
