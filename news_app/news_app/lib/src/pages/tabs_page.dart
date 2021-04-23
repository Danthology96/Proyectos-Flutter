import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    final newsService = Provider.of<NewsService>(context);

    return BottomNavigationBar(
      currentIndex: navigationModel.actualPage,
      onTap: (i) => navigationModel.actualPage = i,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Page 1',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.public_outlined),
          label: 'Page 2',
        ),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);

    return PageView(
      controller: navigationModel.pageController,
      //para que no pueda hacer scroll
      physics: NeverScrollableScrollPhysics(),
      children: [
        Tab1Page(),
        Container(
          color: Colors.green,
        ),
      ],
    );
  }
}

//Estructura de un provider basico
class _NavigationModel with ChangeNotifier {
  int _actualPage = 0;
  PageController _pageController = new PageController();

  int get actualPage => this._actualPage;

  set actualPage(int value) {
    this._actualPage = value;
    _pageController.animateToPage(value,
        duration: Duration(milliseconds: 900), curve: Curves.easeOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}

//api key de newsAPI: d6641f5141294826bbca5fc68f63d3ed
