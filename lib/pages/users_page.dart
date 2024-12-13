import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../custom_theme/color_palette.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  // Function to fetch the users from Firestore
  Future<List<Map<String, dynamic>>> _getUsers() async {
    try {
      // Fetch data from Firestore
      final querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      // Convert the documents into a list of maps
      return querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 720;
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        constraints: isMobile
            ? null
            : BoxConstraints(maxWidth: (screenWidth * 0.63) - 60),
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _getUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                    child: CircularProgressIndicator(
                  color: ColorPalette.primary,
                )),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading users.'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No users found.'));
            } else {
              List<Map<String, dynamic>> users = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'Overall users :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(users.length.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ))
                    ],
                  ),
                  SizedBox(height: 50),
                  TableHeader(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(users.length, (index) {
                      bool isLastItem = index == users.length - 1;

                      return isLastItem
                          ? TableTile(
                              userName: users[index]['username'],
                              dob: users[index]['dob'],
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                            )
                          : TableTile(
                              userName: users[index]['username'],
                              dob: users[index]['dob'],
                            );
                    }),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class TableTile extends StatelessWidget {
  final String userName;
  final String dob;
  final BorderRadiusGeometry? borderRadius;
  const TableTile(
      {super.key,
      required this.userName,
      required this.dob,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 720;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints:
          isMobile ? null : BoxConstraints(maxWidth: (screenWidth * 0.63) - 60),
      height: 50,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: ColorPalette.primary),
          right: BorderSide(color: ColorPalette.primary),
          bottom: BorderSide(color: ColorPalette.primary),
        ),
        borderRadius: borderRadius,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: Row(
            children: [
              SizedBox(width: 30),
              Text(
                userName,
                softWrap: true,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )),
          Expanded(
              child: VerticalDivider(
            color: ColorPalette.primary,
          )),
          Expanded(
              child: Text(
            dob,
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 720;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      constraints:
          isMobile ? null : BoxConstraints(maxWidth: (screenWidth * 0.63) - 60),
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalette.primary),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ))),
          Expanded(
              child: VerticalDivider(
            color: ColorPalette.primary,
          )),
          Expanded(
            child: Text(
              'Date of birth',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
