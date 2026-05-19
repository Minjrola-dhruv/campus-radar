import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Radar',
      theme: ThemeData(
        primaryColor: const Color(0xFF0D47A1),
        scaffoldBackgroundColor: Colors.grey[50],
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, String>> placementList = const [
    {
      "role": "Software Engineer",
      "company": "Google",
      "city": "Bangalore",
      "date": "May 24",
      "package": "30 LPA",
    },
    {
      "role": "Backend Developer",
      "company": "Microsoft",
      "city": "Hyderabad",
      "date": "May 29",
      "package": "28 LPA",
    },
    {
      "role": "Full Stack Engineer",
      "company": "Amazon",
      "city": "Pune",
      "date": "Jun 03",
      "package": "25 LPA",
    },
    {
      "role": "SDE-1",
      "company": "Flipkart",
      "city": "Bangalore",
      "date": "Jun 08",
      "package": "22 LPA",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB), // Light bluish grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey.shade200, height: 1.0),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.radar,
                color: Colors.blueAccent,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Campus Radar',
              style: TextStyle(
                color: Color(0xFF1565C0),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.grey),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
              top: 10.0,
              bottom: 10.0,
            ),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16, color: Colors.white),
              label: const Text('New', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: placementList.length,
        itemBuilder: (context, index) {
          final item = placementList[index];

          return Card(
            elevation: 0,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item['company']![0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['role'] ?? item['company']!,
                          style: const TextStyle(
                            color: Color(0xFF1565C0),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['company']!,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item['city']!,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              item['date']!,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          item['package']!,
                          style: TextStyle(
                            color: Colors.blue.shade700,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue.shade400,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 12),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.delete,
                              color: Colors.red.shade400,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),  
                ],
              ),
            ), 
          );
        },
      ),
    );
  }
}
