import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // Data berita statis dengan deskripsi multi-paragraf
  final List<Map<String, dynamic>> news = [
    {
      'imageUrl':
          'https://images.pexels.com/photos/1457983/pexels-photo-1457983.jpeg?auto=compress&cs=tinysrgb&w=600',
      'title': 'Russian warship: Moskva sinks in Black Sea',
      'author': 'Andini Tidore',
      'descriptions': [
        'Paragraf pertama: Kapal perang Rusia "Moskva" tenggelam di Laut Hitam setelah mengalami kerusakan serius.',
        'Paragraf kedua: Pemerintah Rusia menyebut kapal itu tenggelam akibat kebakaran, sementara Ukraina mengklaim bahwa mereka menyerangnya dengan rudal.',
        'Paragraf ketiga: Peristiwa ini meningkatkan ketegangan di wilayah tersebut dan menimbulkan berbagai spekulasi internasional.',
      ],
      'time': '4h ago',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
      'title': 'Climate Change and Its Impact',
      'author': 'Andini Tidore',
      'descriptions': [
        'Paragraf pertama: Perubahan iklim telah menjadi masalah global yang mendesak.',
        'Paragraf kedua: Badai lebih sering terjadi, musim semakin tidak dapat diprediksi, dan suhu global terus meningkat.',
        'Paragraf ketiga: Para pemimpin dunia terus berdiskusi tentang langkah-langkah untuk mengurangi emisi karbon.',
      ],
      'time': '2h ago',
    },
    {
      'imageUrl':
          'https://images.pexels.com/photos/794064/pexels-photo-794064.jpeg?auto=compress&cs=tinysrgb&w=600',
      'title': 'Advancements in AI Technology',
      'author': 'Andini Tidore',
      'descriptions': [
        'Paragraf pertama: Teknologi kecerdasan buatan (AI) telah merevolusi berbagai sektor.',
        'Paragraf kedua: Dalam dunia kesehatan, AI membantu mendiagnosis penyakit dengan lebih cepat dan akurat.',
        'Paragraf ketiga: Meskipun banyak manfaatnya, ada kekhawatiran terkait privasi dan etika dalam penggunaan AI.',
      ],
      'time': '1h ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Page home dengan daftar berita menggunakan ListView.builder
      ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      title: news[index]['title'].toString(),
                      descriptions: news[index]['descriptions'] as List<String>,
                      imageUrl: news[index]['imageUrl'].toString(),
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        news[index]['imageUrl']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        news[index]['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        news[index]['author']! + " * " + news[index]['time']!,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      const Center(child: Text('Explore Page')),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text(
              'HMTI',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'News',
              style: TextStyle(
                color: Color(0xFF1877F2),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1877F2),
              ),
              child: Text('Pengaturan', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF1877F2),
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;
  final List<String> descriptions;
  final String imageUrl;

  const DetailScreen({
    super.key,
    required this.title,
    required this.descriptions,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: descriptions.map((paragraph) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      paragraph,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: HomeScreen(),
  ));
}
