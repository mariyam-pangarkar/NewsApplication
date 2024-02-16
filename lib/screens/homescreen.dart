import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mary_news/providers/newsprovider.dart';
import 'package:mary_news/screens/news_description.dart';
import 'package:mary_news/screens/signin_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      
    final newget = Provider.of<NewsProvider>(context, listen: false);
    newget.getnewsdata();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(builder: (context, provider, child) {
      return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                'News',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              actions: [
                ElevatedButton(
                  child: Text('Logout'),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      print('logout');
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => const Signin(),
                        ),
                      );
                    });
                  },
                ),
              ]),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: RefreshIndicator(
                  onRefresh: () async{
    await provider.getnewsdata();

                    
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String publishedAtString =
                          provider.newsdataall[index].publishedAt.toString();
                      DateTime publishedAt = DateTime.parse(publishedAtString);
                      DateTime now = DateTime.now();
                      Duration difference = now.difference(publishedAt);
                  
                      int hours = difference.inHours;
                      String timeAgo = '$hours hours ago';
                      return GestureDetector(
                        onTap: () {
                          Navigator.push<void>(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>  NewsDescription(provider.newsdataall[index]),
                            ),
                          );
                        },
                        child:provider.newsdataall !=null ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        provider.newsdataall[index].title
                                            .toString(),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  ClipOval(
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      color: Colors.blue,
                                      child: provider.newsdataall[index]
                                                  .urlToImage !=
                                              null
                                          ? Image.network(
                                              provider
                                                  .newsdataall[index].urlToImage
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                    ),
                                                  );
                                                }
                                              },
                                            )
                                          : Icon(Icons.error),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      timeAgo.toString(),
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical:12.0),
                                child: Container(
                                  height: 2,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ):CircularProgressIndicator(color: Colors.white,),
                      );
                    },
                    itemCount: provider.newsdataall.length,
                  ),
                ),
              ),
            ),
          ));
    });
  }
}
