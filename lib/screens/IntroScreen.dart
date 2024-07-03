import 'package:flutter/material.dart';



class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _pages = [
    IntroductionPage(
      title: 'Page 1 Title',
      description: 'Description of Page 1',
      image: 'assets/images/jerusalem.jpg',
    ),
    IntroductionPage(
      title: 'Page 2 Title',
      description: 'Description of Page 2',
      image: 'assets/images/olives.jpg',
    ),
    IntroductionPage(
      title: 'Page 3 Title',
      description: 'Description of Page 3',
      image: 'assets/images/za3tar.jpg',
    ),
    // Add more pages as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _pages[index];
            },
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i < _pages.length; i++) {
      indicators.add(_indicator(i == _currentPage));
    }
    return indicators;
  }

  Widget _indicator(bool isActive) {
    return Expanded(
      child: Container(
        height: 8.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: isActive ? Colors.blueAccent : Colors.grey,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}

class IntroductionPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  IntroductionPage({
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            fit: BoxFit.cover,
            image,
            height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.width
          ),
          SizedBox(height: 32.0),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),


        ],
      ),
    );
  }
}
