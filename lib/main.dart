import 'package:flutter/material.dart';

void main() {
  runApp(const PredictorApp());
}

class PredictorApp extends StatelessWidget {
  const PredictorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Predictor',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B1020),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B8CFF),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const PredictorHome(),
    );
  }
}

class PredictorHome extends StatefulWidget {
  const PredictorHome({super.key});

  @override
  State<PredictorHome> createState() => _PredictorHomeState();
}

class _PredictorHomeState extends State<PredictorHome> {
  String signal = 'NO TRADE';
  int confidence = 0;
  int signals = 0;

  void predict() {
    setState(() {
      final value = DateTime.now().second % 3;

      if (value == 0) {
        signal = 'UP';
        confidence = 74;
      } else if (value == 1) {
        signal = 'DOWN';
        confidence = 71;
      } else {
        signal = 'NO TRADE';
        confidence = 52;
      }

      signals++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color signalColor;

    if (signal == 'UP') {
      signalColor = Colors.greenAccent;
    } else if (signal == 'DOWN') {
      signalColor = Colors.redAccent;
    } else {
      signalColor = Colors.amber;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Trading Predictor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFF151C30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Asset',
                    style: TextStyle(color: Colors.white60),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'EUR/USD',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Timeframe: 1 Minute',
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Current Price',
                    style: TextStyle(color: Colors.white60),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'LIVE DATA',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF151C30),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Text(
                    'NEXT DIRECTION',
                    style: TextStyle(
                      color: Colors.white60,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    signal,
                    style: TextStyle(
                      color: signalColor,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    confidence == 0 ? '--' : '$confidence%',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'confidence',
                    style: TextStyle(color: Colors.white54),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 55,
              child: FilledButton(
                onPressed: predict,
                child: const Text(
                  'PREDICT NOW',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(child: statBox('Signals', '$signals')),
                const SizedBox(width: 10),
                Expanded(child: statBox('Correct', '0')),
                const SizedBox(width: 10),
                Expanded(child: statBox('Accuracy', '--')),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Prototype',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'This is only a UI prototype. The current prediction is demo logic and is not a real trading signal.',
              style: TextStyle(
                color: Colors.white54,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF151C30),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
