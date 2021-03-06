import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:news_app/src/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsList extends StatefulWidget {
  List<Article> news;

  NewsList(this.news);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    void _onRefresh() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));
      // if failed,use refreshFailed()
      print('entro a onRefresh');
      newsService.getTopHeadlines();
      //busca nuevas noticias
      if (newsService.headlines == this.widget.news) {
        _refreshController.refreshFailed();
        print('Entró a iguales on refresh');
        newsService.headlines = [];
      } else {
        setState(() {});
        _refreshController.refreshCompleted();
      }
    }

    void _onLoading() async {
      // monitor network fetch
      await Future.delayed(Duration(milliseconds: 1000));

      print('entro a onloading');
      newsService.getTopHeadlines();
      //busca nuevas noticias
      if (newsService.headlines == this.widget.news) {
        _refreshController.loadNoData();
        print('Entró a iguales');
        newsService.headlines = [];
      } else {
        setState(() {});
        _refreshController.loadComplete();
      }

      // if failed,use loadFailed(),if no data return,use LoadNodata()
    }

    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropMaterialHeader(),
      footer: ClassicFooter(
        iconPos: IconPosition.top,
        outerBuilder: (child) {
          return Container(
            width: 80.0,
            child: Center(
              child: child,
            ),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemCount: this.widget.news.length,
        itemBuilder: (BuildContext context, int index) {
          return _Report(
            report: this.widget.news[index],
            index: index,
          );
        },
      ),
    );
  }
}

class _Report extends StatelessWidget {
  final Article report;
  final int index;

  const _Report({@required this.report, @required this.index});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ImageCard(report),
        _TopBarCard(report, index),
        _TitleCard(report),
        _DescriptionCard(report),
        _ButtonsCard(),
        SizedBox(height: 10),
        Divider(),
      ],
    );
  }
}

class _TopBarCard extends StatelessWidget {
  final Article report;
  final int index;

  const _TopBarCard(this.report, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: myTheme.accentColor),
        color: myTheme.accentColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Text(
            '${index + 1} ',
          ),
          Text(
            '${report.source.name}',
          ),
        ],
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final Article report;

  const _TitleCard(this.report);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      color: myTheme.accentColor,
      child: Text(
        report.title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final Article report;

  const _ImageCard(this.report);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: (report.urlToImage != null)
            ? FadeInImage(
                placeholder: AssetImage('assets/img/giphy.gif'),
                image: NetworkImage(report.urlToImage),
              )
            : Image(
                image: AssetImage('assets/img/no-image.png'),
              ),
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  final Article report;

  const _DescriptionCard(this.report);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
      child: Container(
        color: myTheme.primaryColor,
        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 10),
        child: Text((report.description != null) ? report.description : ''),
      ),
    );
  }
}

class _ButtonsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {},
            fillColor: myTheme.accentColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.star_border),
          ),
          SizedBox(
            width: 10,
          ),
          RawMaterialButton(
            onPressed: () {},
            fillColor: myTheme.accentColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.more_horiz),
          ),
        ],
      ),
    );
  }
}
