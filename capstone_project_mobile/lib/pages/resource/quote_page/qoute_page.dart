import 'package:capstone_project_mobile/layouts/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class QoutePage extends StatefulWidget {
  const QoutePage({super.key});

  @override
  State<QoutePage> createState() => _QoutePageState();
}

class _QoutePageState extends State<QoutePage> {
  final List<String> imageUrls = [
    'https://cdn.shopify.com/s/files/1/0070/7032/files/rohn-quote.png?v=1706739779',
    'https://m.media-amazon.com/images/I/71MQYuGHUkL._AC_UF1000,1000_QL80_.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2BgOfjoH6kuOgqHd0xPg_KxKOwJ2CQ-QU4w&s',
    'https://i.pinimg.com/236x/58/50/6b/58506b21cb2333e481478bf0631ca5c9.jpg'
  ];

  late CarouselController _controller;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          Center(
            child: CarouselSlider.builder(
              carouselController: _controller,
              itemCount: imageUrls.length,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: false,
                viewportFraction: 1.0,
                height: double.infinity, // Fixed height for the slider
              ),
              itemBuilder: (context, index, realIndex) {
                final imageUrl = imageUrls[index];
                return Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity, // Fixed height for the images
                );
              },
            ),
          ),
          Positioned(
            bottom: 20, // Position the button above the bottom edge
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LayoutPage(selectedIndex: 3),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
