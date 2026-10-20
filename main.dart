import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class Plant {
  final String name;
  final double price;
  final int ageInMonths;
  final bool needsDirectSunlight;
  final bool needsWateringToday;

  const Plant({
    required this.name,
    required this.price,
    required this.ageInMonths,
    required this.needsDirectSunlight,
    required this.needsWateringToday,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Katalog Tanaman Hias',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LayarUtama(),
    );
  }
}

class LayarUtama extends StatefulWidget {
  const LayarUtama({super.key});

  @override
  State<LayarUtama> createState() => _LayarUtamaState();
}

class _LayarUtamaState extends State<LayarUtama> {
  final List<Plant> plantList = const [
    Plant(
      name: "Monstera Deliciosa",
      price: 150000,
      ageInMonths: 8,
      needsDirectSunlight: false,
      needsWateringToday: true,
    ),
    Plant(
      name: "Kaktus Centong",
      price: 35000,
      ageInMonths: 12,
      needsDirectSunlight: true,
      needsWateringToday: false,
    ),
    Plant(
      name: "Aglonema Red Anjamani",
      price: 85000,
      ageInMonths: 5,
      needsDirectSunlight: false,
      needsWateringToday: true,
    ),
    Plant(
      name: "Calathea Velvet",
      price: 65000,
      ageInMonths: 3,
      needsDirectSunlight: false,
      needsWateringToday: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalTanaman = plantList.length;
    final perluDisiram = plantList.where((p) => p.needsWateringToday).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Koleksi Tanaman Hias'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(Icons.eco, size: 40, color: Colors.green),
                  const SizedBox(height: 8),
                  const Text(
                    "Ringkasan Tanaman",
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Total: $totalTanaman',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Perlu Disiram: $perluDisiram',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Daftar Koleksi Tanaman:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: plantList.length,
              itemBuilder: (context, index) {
                return KartuTanaman(item: plantList[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class KartuTanaman extends StatelessWidget {
  final Plant item;

  const KartuTanaman({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.local_florist, color: Colors.green, size: 32),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Umur: ${item.ageInMonths} Bulan | Rp ${item.price}'),
                  Text(
                    item.needsWateringToday
                        ? 'Status: Perlu Disiram'
                        : 'Status: Cukup Air',
                    style: TextStyle(
                      color: item.needsWateringToday
                          ? Colors.orange
                          : Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                debugPrint("Detail ${item.name} diklik");
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(item.name),
                    content: Text(
                      'Harga: Rp ${item.price}\n'
                      'Umur: ${item.ageInMonths} Bulan\n'
                      'Sinar Langsung: ${item.needsDirectSunlight ? "Ya" : "Tidak"}',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: const Text('Tutup'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text("Detail"),
            ),
          ],
        ),
      ),
    );
  }
}