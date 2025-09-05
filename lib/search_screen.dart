import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Remove the default app bar properties and create a custom search bar
        automaticallyImplyLeading: false, // Prevents a back button from showing up
        title: Container(
          // Match the padding and margin from the Spotify app
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
          child: const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.black),
              // Use hint text that matches the Spotify search bar
              hintText: 'What do you want to listen to?',
              hintStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Browse all',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.5,
              ),
              itemCount: genres.length,
              itemBuilder: (context, index) {
                return _buildGenreCard(genres[index]);
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black, // Set the background color of the scaffold
    );
  }

  Widget _buildGenreCard(Map<String, dynamic> genre) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: genre['color'],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              genre['title'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          if (genre['image'] != null)
            Positioned(
              right: -10,
              bottom: -10,
              child: Transform.rotate(
                angle: 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    genre['image'],
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Mock data for genres
final List<Map<String, dynamic>> genres = [
  {
    'title': 'Podcasts',
    'color': Colors.blue[800]!,
    'image': 'assets/images/podcast.jpg',
  },
  {
    'title': 'New Releases',
    'color': Colors.red[800]!,
    'image': 'assets/images/new_releases.jpg',
  },
  {
    'title': 'Charts',
    'color': Colors.purple[800]!,
    'image': 'assets/images/charts.jpg',
  },
  {
    'title': 'Live Events',
    'color': Colors.orange[800]!,
    'image': 'assets/images/spotify-back-to-live.png',
  },
  {
    'title': 'Mood',
    'color': Colors.green[800]!,
    'image': 'assets/images/mood.jpg',
  },
  {
    'title': 'Discover',
    'color': Colors.pink[800]!,
    'image': 'assets/images/discover.jpg',
  },
  {
    'title': 'Hip Hop',
    'color': Colors.brown[800]!,
    'image': 'assets/images/hip_hop.jpg',
  },
  {
    'title': 'Pop',
    'color': Colors.cyan[800]!,
    'image': 'assets/images/pop.jpg',
  },
  {
    'title': 'Rock',
    'color': Colors.deepOrange[800]!,
    'image': 'assets/images/rock.jpg',
  },
  {
    'title': 'Electronic',
    'color': Colors.indigo[800]!,
    'image': 'assets/images/eltectronic.jpg',
  },
  {
    'title': 'Jazz',
    'color': Colors.amber[800]!,
    'image': 'assets/images/jazz.jpg',
  },
  {
    'title': 'Bollywood',
    'color': Colors.teal[800]!,
    'image': 'assets/images/hindi.jpg',
  },
];