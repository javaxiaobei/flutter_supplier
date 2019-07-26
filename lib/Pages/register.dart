import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_supplier/Pages/Toast.dart';
class registerPage extends StatefulWidget {
  @override
  _registerPageState createState() => _registerPageState();
}
class _registerPageState extends State<registerPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;


  //输入的账号就是手机号
  String username = "";
  //输入的密码
  String password = "";
  //输入的二次密码
  String password2="";
  //邀请码
  String invitation="";

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //输入手机号密码的输入框插件等
  _loginForm() {
    return Padding(padding: const EdgeInsets.only(top: 12.0),
      child: Form(child: Column(
        children: <Widget>[
          TextField(
            keyboardType:TextInputType.numberWithOptions(),
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly,
             LengthLimitingTextInputFormatter(11)
            ],
            decoration: InputDecoration(
                labelText: "请输入您注册的手机号",
                prefixIcon: Icon(Icons.account_circle)
            ),
            maxLines: 1,
            maxLengthEnforced: true,
            onChanged: (val) {
              username = val;
            },
          ),
          TextField(
              inputFormatters: [
                LengthLimitingTextInputFormatter(32)
              ],
            decoration: InputDecoration(
                labelText: "请输入您注册的密码",
                prefixIcon: Icon(Icons.lock)
            ),
            maxLines: 1,
            maxLengthEnforced: true,
            obscureText: true,
            onChanged: (val) {
              password = val;
            },
          ),
          TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(32)
            ],
            decoration: InputDecoration(
                labelText: "请再次输入您注册的密码",
                prefixIcon: Icon(Icons.lock)
            ),
            maxLines: 1,
            maxLengthEnforced: true,
            obscureText: true,
            onChanged: (val) {
              password2 = val;
            },
          ),
          TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(32)
            ],
            decoration: InputDecoration(
                labelText: "请输入您的邀请码",
                prefixIcon: Icon(Icons.contact_mail)
            ),
            maxLines: 1,
            maxLengthEnforced: true,
            onChanged: (val) {
              invitation = val;
            },
          ),
        ],
      )
      ),
    );
  }
  //下面的注册按钮
  _loginBtn(context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0,20, 0,10),
        child: RaisedButton(
          color: Colors.blueAccent,
          onPressed: () {
            if (username.length <= 0 || password.length <= 0||invitation.length<=0) {
              Toast.show("您注册用户名或密码不能为空");
              return;
            }
            print("手机号:$username, 密码:$password");


          },
          elevation: 16,
          shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.blueAccent,
                width: 1.5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20.5))
          ),
          highlightColor: Colors.blue,
          splashColor: Colors.indigoAccent,
          child: Padding(padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  " 注 册 ",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w900
                  ),
                )
              ],
            ),
          ),
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("供货商注册"),),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
        children: <Widget>[
          Image.asset( "images/logo@2x.png", width: 100.0 * 0.6, height: 145.0 * 0.6,),
          _loginForm(),
          _loginBtn(context)
        ],

      ),
    );
  }
}


