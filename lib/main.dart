import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mary_news/firebase_options.dart';
import 'package:mary_news/providers/newsprovider.dart';
import 'package:mary_news/screens/signin_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:splash_view/source/presentation/pages/splash_view.dart';
import 'package:splash_view/source/presentation/widgets/done.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // TRY THIS: Try running your application with "flutter run". You'll see
    //     // the application has a purple toolbar. Then, without quitting the app,
    //     // try changing the seedColor in the colorScheme below to Colors.green
    //     // and then invoke "hot reload" (save your changes or press the "hot
    //     // reload" button in a Flutter-supported IDE, or press "r" if you used
    //     // the command line to start the app).
    //     //
    //     // Notice that the counter didn't reset back to zero; the application
    //     // state is not lost during the reload. To reset the state, use hot
    //     // restart instead.
    //     //
    //     // This works for code too, not just values: Most code changes can be
    //     // tested with just a hot reload.
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const Signin(),
    // );
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<NewsProvider>(
            create: (context) => NewsProvider(),
            builder: (context, _) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: SplashView(
                  title: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'News App',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color.fromARGB(255, 26, 81, 123),
                        Color.fromARGB(255, 179, 62, 177),
                      ]),
                  done: Done(
                    Signin(),
                    animationDuration: Duration(seconds: 2),
                    curve: Curves.easeInOut,
                  ),
                ),
                title: 'News App',
              );
            },
          ),
        ],
      );
    });
  }
}
