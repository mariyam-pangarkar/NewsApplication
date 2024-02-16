import 'package:flutter/material.dart';

class NewsDescription extends StatefulWidget {
  var data;
  NewsDescription(this.data, {super.key});

  @override
  State<NewsDescription> createState() => _NewsDescriptionState();
}

class _NewsDescriptionState extends State<NewsDescription> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('njcjdn ${widget.data.description}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Description'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(children: [
            Text(
              widget.data.title.toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: Colors.blue,
                child: widget.data.urlToImage != null
                    ? Image.network(
                        widget.data.urlToImage.toString(),
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          }
                        },
                      )
                    : Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(widget.data.description.toString()),
            )
          ]),
        ),
      ),
    );
  }
}
