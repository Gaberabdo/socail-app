import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social/helper/component/component.dart';
import 'package:social/screens/home/home_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            navigatorTo(context, HomeScreen());
          },
        ),
        title: Text('Search '),
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 40,
              child: TextField(
                onSubmitted: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Search',
                    suffixIcon: Icon(
                      IconBroken.Search,
                    ),
                    border: const OutlineInputBorder()),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: (name != "" && name != null)
                  ? FirebaseFirestore.instance
                      .collection('users')
                      .doc()
                      .collection('users')
                      .where("name", arrayContains: name)
                      .snapshots()
                  : FirebaseFirestore.instance.collection("users").snapshots(),
              builder: (context, snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(height: 1,width: double.infinity, color: Colors.black54,),
                    );
                  },
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot data = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    data['image'],
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  data['name'],
                                ),
                              ],
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
