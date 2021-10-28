import 'package:flutter/material.dart';
import 'package:messenger_clone/Screens/SignUp.dart';
import 'package:messenger_clone/constants/common.dart';
import 'package:messenger_clone/services/auth.dart';
import 'package:messenger_clone/ad_helper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  BannerAd _ad;
  bool isLoaded;

  @override
  void initState() {
    super.initState();
    _ad = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: AdListener(
        onAdLoaded: (_) {
          setState(
                () {
              isLoaded = true;
            },
          );
        },
        onAdFailedToLoad: (_, error) {
          print('Failed to Load: $error');
        },
      ),
    );

    _ad.load();
  }

  @override
  void dispose() {
    _ad?.dispose();
    super.dispose();
  }

  Widget checkForAd() {
    if (isLoaded == true) {
      return Container(
        child: AdWidget(
          ad: _ad,
        ),
        width: _ad.size.width.toDouble(),
        height: _ad.size.height.toDouble(),
        alignment: Alignment.center,
      );
    } else {
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome To Madhu Fanpage App"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 5,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
            child: Column(
              children: [
                setTextField(email, Icons.email_outlined,'Enter Email'),
                setTextField(password, Icons.lock_open_outlined,'Enter Password'),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    AuthMethods().signInWithEmailAndPassword(context, email.text, password.text);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.blue,
                    ),
                    height: 40,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                checkForAd(),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    'Create Account?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20,color: Colors.blue),
                    ),
                ),
                SizedBox(height: 50),
                Text('or',textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: (){
                    AuthMethods().signInWithGoogle(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.blue,
                    ),
                    height: 40,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Text(
                        "Sign In Google",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
