import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_album/screens/home/add_image.dart';
import 'package:photo_album/setTheme.dart';
import 'package:transparent_image/transparent_image.dart';

class DashboardPhoto extends StatefulWidget {
  @override
  _DashboardPhotoState createState() => _DashboardPhotoState();
}

class _DashboardPhotoState extends State<DashboardPhoto> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Album'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text('Settings'),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SettingsTheme()));
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddImage()));
        },
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('imageURLs').snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData ?
            Center(
              child: CircularProgressIndicator(),
            )
          : Container(
            padding: EdgeInsets.all(4),
              child: GridView.builder(
                itemCount : snapshot.data.documents.length,
                gridDelegate : SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount : 3),
                itemBuilder : (context, index) {
                  return Container(
                    margin: EdgeInsets.all(3),
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: snapshot.data.documents[index].get('url')),
                  );
                }),
              );
            },  
          ),
      );
  }
}
