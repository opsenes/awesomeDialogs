import 'package:awesome_dialog/animated_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fancy_dialog_example/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Dialog Example',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  showDebugPrint() {
    debugPrint('Print from Callback Function');
  }

  _slideMainPage(BuildContext context) {
    showDebugPrint();
    Navigator.of(context).pushNamed(RouteGenerator.testPage);
  }

  void showAlertDialogOnOkCallback(String title, String msg,
      DialogType dialogType, BuildContext context, VoidCallback onOkPress) {
    AwesomeDialog(
      context: context,
      animType: AnimType.TOP_SLIDE,
      dialogType: dialogType,
      tittle: title,
      desc: msg,
      btnOkIcon: Icons.check_circle,
      btnOkColor: Colors.green.shade900,
      btnOkOnPress: onOkPress,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fancy Dialog Example'),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                AnimatedButton(
                  text: 'Issue Dialog',
                  pressEvent: () {
                    showAlertDialogOnOkCallback(
                        'Verified',
                        'Sign In Success!, prees Ok to navigate.',
                        DialogType.SUCCESS,
                        context,
                        () => _slideMainPage(context));
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Info Dialog',
                  pressEvent: () {
                    AwesomeDialog(
                            context: context,
                            headerAnimationLoop: false,
                            dialogType: DialogType.INFO,
                            animType: AnimType.BOTTOM_SLIDE,
                            tittle: 'INFO',
                            desc:
                                'Dialog description here..................................................',
                            btnCancelOnPress: () {},
                            btnOkOnPress: showDebugPrint)
                        .show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Info Dialog Without buttons',
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      headerAnimationLoop: false,
                      dialogType: DialogType.INFO,
                      animType: AnimType.BOTTOM_SLIDE,
                      tittle: 'INFO',
                      desc: 'Dialog de.',
                    ).show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Warning Dialog',
                  color: Colors.orange,
                  pressEvent: () {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.WARNING,
                            headerAnimationLoop: false,
                            animType: AnimType.TOP_SLIDE,
                            tittle: 'Warning',
                            desc:
                                'Dialog description here..................................................',
                            btnCancelOnPress: () {},
                            btnOkOnPress: () {})
                        .show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Error Dialog',
                  color: Colors.red,
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                  pressEvent: () {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.RIGHT_SLIDE,
                            headerAnimationLoop: false,
                            tittle: 'Error',
                            desc:
                                'Dialog description here..................................................',
                            btnOkOnPress: () {},
                            btnOkColor: Colors.red)
                        .show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Succes Dialog',
                  color: Colors.green,
                  pressEvent: () {
                    AwesomeDialog(
                        context: context,
                        animType: AnimType.LEFT_SLIDE,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCESS,
                        tittle: 'Succes',
                        desc:
                            'Dialog description here..................................................',
                        btnOkOnPress: () {
                          debugPrint('OnClcik');
                        },
                        btnOkIcon: Icons.check_circle,
                        onDismissCallback: () {
                          debugPrint('Dialog Dissmiss from callback');
                        }).show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Custom Body Dialog',
                  color: Colors.blueGrey,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.INFO,
                      body: Center(
                        child: Text(
                          'If the body is specified, then title and description will be ignored, this allows to further customize the dialogue.',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      tittle: 'This is Ignored',
                      desc: 'This is also Ignored',
                    ).show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Custom Buttons Dialog',
                  color: Colors.brown,
                  pressEvent: () {
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      customHeader: Icon(
                        Icons.face,
                        size: 50,
                      ),

                      tittle: 'This is Custom',
                      desc: 'This is custom button and header',
                      btnOk: AnimatedButton(
                        width: 100,
                        pressEvent: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Custom Animated Button',
                        color: Color(0xFF00CA71),
                      ),
                      //this is ignored
                      btnOkOnPress: () {},
                    ).show();
                  },
                ),
              ],
            ),
          )),
        ));
  }
}
