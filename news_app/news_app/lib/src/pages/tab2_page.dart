import 'package:flutter/material.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:news_app/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _CategoriesList(),
            if (!newsService.isLoading)
              Expanded(
                child: NewsList(newsService.getArticlesBySelectedCategory),
              ),
            if (newsService.isLoading)
              Expanded(
                  child: Center(
                child: CircularProgressIndicator(
                  valueColor:
                      new AlwaysStoppedAnimation<Color>(myTheme.accentColor),
                ),
              )),
          ],
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          final categoryName = categories[index].name;
          return Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [
                _CategoryButton(categories[index]),
                SizedBox(
                  height: 5,
                ),
                Text(
                    '${categoryName[0].toUpperCase()}${categoryName.substring(1)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final Category category;

  const _CategoryButton(this.category);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
        width: 40.0,
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (category.name == newsService.selectedCategory)
              ? Colors.white
              : myTheme.accentColor,
        ),
        child: Icon(
          category.icon,
          color: myTheme.backgroundColor,
        ),
      ),
    );
  }
}
