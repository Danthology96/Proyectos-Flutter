import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 6.5, horizontal: 4.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.shortpixel.ai/client/q_glossy,ret_img,w_1000,h_600/https://wipy.tv/wp-content/uploads/2020/07/imagen-nunca-antes-vista-de-stan-lee.jpg'),
              radius: 20.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              child: Text('SL'),
              backgroundColor: Colors.brown,
            ),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(
              'https://www.biography.com/.image/c_fill%2Ccs_srgb%2Cfl_progressive%2Ch_400%2Cq_auto:good%2Cw_620/MTIwNjA4NjM0MTk3MjE0NzMy/stan-lee-21101093-1-402.jpg'),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
