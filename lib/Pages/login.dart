import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_supplier/Pages/Toast.dart';
import 'package:flutter_supplier/api.dart';
import 'package:flutter_supplier/Pages/ceshi.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_supplier/Pages/register.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;



  //输入的账号就是手机号
  String username = "";
  //输入的密码
  String password = "";
  //输入的令牌，tokens
  String toKens="";
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
    _isLogin();
  }

  _isLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    toKens=prefs.get("toKens");
    print("初始话toKens");
    print(toKens);
    if(toKens!=null){
      Map<String, dynamic> user = await login(username, password,toKens);
      if(user!=null){
        Navigator.push(context,new MaterialPageRoute(builder: (context)=>new ceshiPage()) );
      }
    }else{
      print("没有所谓的tokens");
    }

  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //下面的登录按钮
  _loginBtn(context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0,20, 0,10),
        child: RaisedButton(
          color: Colors.blueAccent,
          onPressed: () {
            if (username.length <= 0 || password.length <= 0) {
              Toast.show("用户名或密码不能为空");
              return;
            }
            print("手机号:$username, 密码:$password");
            _login();

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
                  "登 录",
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
                  labelText: "请输入您的手机号",
                  prefixIcon: Icon(Icons.account_circle)
              ),
              maxLines: 1,
              onChanged: (val) {
                username = val;
              },
            ),
            TextField(
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(32)
              ],
              decoration: InputDecoration(
                  labelText: "请输入您的密码",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),

              ),
              maxLines: 1,
              obscureText: true,
              onChanged: (val) {
                password = val;
              },
            ),
            Padding(padding:
            const EdgeInsets.only(top: 12),
              child: Row(
                children: <Widget>[
                  Expanded(child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> new registerPage()));
                      
                    },
                    child: Text(
                        "忘记密码?",
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Colors.black54)
                    ),
                  )
                  )
                ],
              ),
            )
          ],
        )
        ),
      );
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('供货商登录'),
        ),
        body: ListView(
          padding: EdgeInsets.fromLTRB(20, 70, 20, 20),
          children: <Widget>[
            Image.asset(
              "images/logo@2x.png", width: 100.0 * 0.6, height: 145.0 * 0.6,),
            _loginForm(),
            _loginBtn(context)
          ],
        ),
      );
    }
      //登录的验证和方法
    _login() async{
      Map<String, dynamic> userMap = await login(username, password,toKens);
      print("我获取的");
      print(userMap);
      if(userMap!=null){
          Navigator.push(context,new MaterialPageRoute(builder: (context)=>new ceshiPage()) );
      }else{
        print("判断返回来的数据");
        Toast.show("用户名或密码错误");
      }
    }

  }



