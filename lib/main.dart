import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';


class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    print("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    print("Started $url");
  }

  @override
  Future onLoadStop(url) async {
    print("Stopped $url");
  }

  @override
  void onLoadError(url, code, message) {
    print("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    print("Progress: $progress");
  }

  @override
  void onExit() {
    print("Browser closed!");
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title:'Apsley',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: MyApp(),
    ),
  );
}

void launchWhatsapp() async {
  var whatsappURl_android = "whatsapp://send?phone=+421944315610&text=Hello";
  var whatappURL_ios ="https://wa.me/+421944315610?text=${Uri.parse("hello")}";


  if(Platform.isIOS){
    // for iOS phone only
    if( await canLaunch(whatappURL_ios)){
      await launch(whatappURL_ios, forceSafariVC: false);
    }/*else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp not installed")));
      }*/

  }else{
    // android , web
    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }/*else{
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: new Text("whatsapp no installed")));
    }*/
  }
}

class MyApp extends StatefulWidget {
  final MyInAppBrowser browser = new MyInAppBrowser();


  /*void launchWhatsapp({@required number, @required message}) async {
    String whatsappURl_android = "whatsapp://send?phone=$number&text=$message";

    await canLaunch(whatsappURl_android) ? lanuch(whatsappURl_android) : print("Can't open whatsapp");
  }*/

  /*openwhatsapp() async{
    var whatsapp ="+447972752215";
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
    if(Platform.isIOS){
      // for iOS phone only
      if( await canLaunch(whatappURL_ios)){
        await launch(whatappURL_ios, forceSafariVC: false);
      }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp not installed")));
      }

    }else{
      // android , web
      if( await canLaunch(whatsappURl_android)){
        await launch(whatsappURl_android);
      }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: new Text("whatsapp no installed")));
      }
    }
  }*/

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final double panelWidth = 336;

  var options = InAppBrowserClassOptions(
      crossPlatform: InAppBrowserOptions(
        hideToolbarTop: false,
        hideUrlBar: true,
        toolbarTopBackgroundColor: Colors.white54,
      ),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)
      )
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual, overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/london_blurred.png'),
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
            child: SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                //mainAxisSize: MainAxisSize.max,
                children: [
                  ApsleyLogo(logoSize: 132), // Apsley Logo
                  Spacer(),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: panelWidth,
                      //color: Colors.pink,
                      child: Align(
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Welcome to the\nApsley App',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              letterSpacing: 2,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), //Welcome panel
                  Spacer(),
                  Container(
                    width: panelWidth,
                    height: 72.0,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            widget.browser.openUrlRequest(
                                urlRequest: URLRequest(url: Uri.parse("https://apsley.cloud/portal/my/")),
                                options: options);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            //side: BorderSide(color: Colors.white70, width: 2),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(24))),
                          ),
                          child: SizedBox(width: double.infinity, height: 48,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Student Login',
                                style: TextStyle(
                                  color: Colors.blueGrey[800],
                                  fontSize: 17.0,
                                  letterSpacing: 2,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ), // Login panel
                  Container(
                    width: panelWidth,
                    height: 48,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // mail
                          TextButton(
                            onPressed: () => launch("mailto:info@apsley.eu"),
                            style: TextButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.all(6.0),
                              primary: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(24))),
                            ),
                            child: Image.asset(
                              'assets/icon_email.png',
                              color: Colors.white54,
                              height: 32.0,
                            ),
                          ),

                          // linked in
                          TextButton(
                            onPressed: () {
                              widget.browser.openUrlRequest(
                                  urlRequest: URLRequest(url: Uri.parse("https://www.linkedin.com/school/apsley-business-school-london/")),
                                  options: options);
                            },
                            style: TextButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.all(6.0),
                              primary: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(24))),
                            ),
                            child: Image.asset(
                              'assets/icon_linkedIn.png',
                              color: Colors.white54,
                              height: 32.0,
                            ),
                          ),

                          // whatsapp
                          TextButton(
                            onPressed: () => launch("whatsapp://send?phone=+447310714895text=Hello, I'd like to know more about your programs"),
                            /*onPressed: () {
                              launchWhatsapp();
                            },*/
                            style: TextButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.all(6.0),
                              primary: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(24))),
                            ),
                            child: Image.asset(
                              'assets/icon_whatsapp.png',
                              color: Colors.white54,
                              height: 32.0,
                            ),
                          ),

                          // instagram
                          /*TextButton(
                            onPressed: () {
                              widget.browser.openUrlRequest(
                                  urlRequest: URLRequest(url: Uri.parse("https://www.instagram.com/apsleylondon/")),
                                  options: options);
                            },
                            style: TextButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.all(6.0),
                              primary: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(24))),
                            ),
                            child: Image.asset(
                              'assets/icon_instagram.png',
                              color: Colors.white54,
                              height: 32.0,
                            ),
                          ),*/

                          //facebook
                          TextButton(
                            onPressed: () {
                              widget.browser.openUrlRequest(
                                  urlRequest: URLRequest(url: Uri.parse("https://www.facebook.com/apsleybusinessschool/")),
                                  options: options);
                            },
                            style: TextButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.all(6.0),
                              primary: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(24))),
                            ),
                            child: Image.asset(
                              'assets/icon_facebook_white.png',
                              color: Colors.white54,
                              height: 32.0,
                            ),
                          ),

                          //twitter
                          TextButton(
                            onPressed: () {
                              widget.browser.openUrlRequest(
                                  urlRequest: URLRequest(url: Uri.parse("https://twitter.com/ApsleyLondon/")),
                                  options: options);
                            },
                            style: TextButton.styleFrom(
                              elevation: 0,
                              padding: EdgeInsets.all(6.0),
                              primary: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(24))),
                            ),
                            child: Image.asset(
                              'assets/icon_twitter.png',
                              color: Colors.white54,
                              height: 32.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), // Social Networks
                  Container(
                    width: panelWidth,
                    height: 64,
                    padding: EdgeInsets.all(6.0),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            onPressed: () => launch("tel://+44 20 3286 6718"),
                            label: Text('+44 (0) 20 3286 6718'),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.all(12.0),
                              primary: Colors.white70,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(24))),
                              textStyle: TextStyle(
                                fontSize: 17.0,
                                letterSpacing: 2,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            icon: Image.asset(
                              'assets/icon_phone.png',
                              color: Colors.white54,
                              //height: 32.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), // Call us
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ApsleyLogo extends StatelessWidget {

  ApsleyLogo({required this.logoSize});

  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        //color: Colors.blue,
        height: logoSize,
        //width: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 64.0),
          child: Image(
            //color: Colors.white12,
            image: AssetImage('assets/abs_logo-1-300x132.png'),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class DefaultButton extends StatelessWidget {

  DefaultButton({required this.label, required this.target});

  final String label;
  final String target;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){Navigator.pushNamed(context, '/$target');},
      style: ElevatedButton.styleFrom(
        primary: Colors.amber,
        //side: BorderSide(color: Colors.white70, width: 2),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24))),
      ),
      child: SizedBox(width: double.infinity, height: 48,
        child: Align(
          alignment: Alignment.center,
          child: Text(
            '$label',
            style: TextStyle(
              color: Colors.blueGrey[800],
              fontSize: 17.0,
              letterSpacing: 2,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  Header({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: Text(
          '$label',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            letterSpacing: 2,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w100,
          ),
        ),
      ),
    );
  }
}