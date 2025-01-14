import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:capstone_project_mobile/pages/resource/quote_page/qoute_page.dart';

class SlideShowItem {
  final String img;
  final Function(BuildContext) navigation;
  SlideShowItem({required this.img, required this.navigation});
}

class SlideshowPage extends StatefulWidget {
  final List<String>? slideImgUrl;
  final List<SlideShowItem>? slideImgNav;

  final bool actionsEnabled;

  const SlideshowPage(
      {super.key,
      this.slideImgUrl,
      this.actionsEnabled = false,
      this.slideImgNav});

  @override
  State<SlideshowPage> createState() => _SlideshowPageState();
}

class _SlideshowPageState extends State<SlideshowPage> {
  late CarouselController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.actionsEnabled == true) _buildImgUrl(),
        if (widget.actionsEnabled == false) _buildImgNav(),
      ],
    );
  }

  Widget _buildImgUrl() {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          carouselController: _controller,
          itemCount: widget.slideImgUrl!.length,
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            height: 300,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final imageUrl = widget.slideImgUrl![index];

            return ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 300,
              ),
            );
          },
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.slideImgUrl!.length,
                (index) => Container(
                  width: 10.0,
                  height: 30.0,
                  margin: const EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                height: 10,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QoutePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: colorScheme.inversePrimary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                  ),
                  child: Text(
                    'See All',
                    style: TextStyle(fontSize: 16, color: colorScheme.primary),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildImgNav() {
    return CarouselSlider.builder(
      carouselController: _controller,
      itemCount: widget.slideImgNav!.length,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        height: 300,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final imageUrl = widget.slideImgNav![index];

        return ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => imageUrl.navigation(context)),
              );
            },
            child: Image.asset(
              imageUrl.img,
              fit: BoxFit.fitHeight,
              width: double.infinity,
              height: 300,
            ),
          ),
        );
      },
    );
  }
}
