import 'package:flutter/material.dart';

class ceshiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("测试页面",style:TextStyle(color: Colors.yellow,fontSize: 24,)),
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Text("您好，供货商",style: TextStyle(fontSize: 20),),
        ),
        Card(
          color: Colors.yellow,
          child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
               Image.asset("images/logo@2x.png",width: 100,height: 100,),
                Text("123456")
              ],
              ),
          ),
        ),
            Card(
              color: Colors.yellow,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("images/logo@2x.png",height: 100,),
                    Text("456789")
                  ],
                ),
              ),
            )

          ],

        ),
      ),
    );
  }
}
