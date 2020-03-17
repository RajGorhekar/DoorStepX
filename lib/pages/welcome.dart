import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final usersRef = Firestore.instance.collection('users');
String name = 'Dear ',
    url = 'https://image.flaticon.com/icons/svg/1077/1077012.svg';

final List<Widget> items = [
  FurnitureCategoryItem(
      imagepath: './assets/images/Electrician.png',
      type: 'Electrician',
      onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/Doctor.png', type: 'Doctor', onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/Gardener.png',
      type: 'Gardener',
      onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/HouseCleaning.png',
      type: 'House\nCleaning',
      onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/Movers.png',
      type: 'Packers & \nMovers',
      onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/plumber.png',
      type: 'plumber',
      onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/Veterian.png',
      type: 'Veterian',
      onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/maintenance.png',
      type: 'maintenance',
      onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/massage.png',
      type: 'Massage',
      onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/petcare.png',
      type: 'Petcare',
      onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/babysitting.png',
      type: 'Babysitting',
      onTap: () => {}),
  FurnitureCategoryItem(
      imagepath: './assets/images/Others.png', type: 'Others', onTap: () => {}),
];

class WelcomeScreen extends StatefulWidget {
  final FirebaseUser user;
  WelcomeScreen({Key key, this.user}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    getNameandUrl();
    setState(() {
      print(widget.user.uid);
    });
  }

  getNameandUrl() async {
    DocumentSnapshot doc = await usersRef.document(widget.user.uid).get();
    String s = doc['name'];
    String mediaUrl = doc['imageUrl'];
    setState(() {
      name = s;
      url = mediaUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: _buildBody(height, width),
    );
  }

  Widget _buildAppBar(height, width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hello, " + name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Searching for Something?",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Container(
          width: 60,
          alignment: Alignment.centerLeft,
          child: ClipRRect(child: Container(
            height :50,width: 50 ,color : Colors.white,
            child: Image.network(url),
          ),borderRadius: BorderRadius.circular(25),),
          // child: Stack(
          //   children: <Widget>[
          //     Container(
          //       width: 45,
          //       height: 45,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Colors.white,
          //       ),
          //       child: Image.network(url),
          //     ),
          //     Positioned(
          //       top: 0,
          //       right: 2,
          //       child: Container(
          //         width: 12,
          //         height: 12,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Colors.red,
          //           border: Border.all(color: Colors.white),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ),
      ],
    );
  }

  Widget _buildBody(height, width) {
    return Container(
      height: height,
      width: width,
      color: Color.fromRGBO(6, 38, 54, 1),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            width: width,
            height: height * .35,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.2, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.deepPurple[900],
                    Colors.deepPurple[700],
                    Colors.deepPurple[400],
                    Colors.deepPurple[200],
                  ],
                ),
              ),
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 15),
                    _buildAppBar(height, width),
                    SizedBox(height: 30),
                    Container(
                      width: width - 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black87,
                          ),
                          hintText: 'Search Here...',
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          _buildCategoriesSection(height, width),
        ],
      ),
    );
  }

  // Widget _buildContent(height, width) {
  //   return Positioned(
  //     top: (height * .35) + 50,
  //     width: width,
  //     height: height - (height * .35) + 50,
  //     child: LayoutBuilder(
  //       builder: (BuildContext c, BoxConstraints constraints) {
  //         final List<Widget> items = [];

  //         items.add(SizedBox(
  //           height: constraints.maxHeight / 3,
  //         ));

  //         return ListView(
  //           padding: EdgeInsets.only(left: 20),
  //           children: items,
  //         );
  //       },
  //     ),
  //   );
  //}

  Widget _buildCategoriesSection(height, width) {
    return Positioned(
      width: width,
      height: height,
      top: (height * .35) - 45,
      child: GridView(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 50),
        scrollDirection: Axis.vertical,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        children: items,
      ),
    );
  }
}

class FurnitureCategoryItem extends StatelessWidget {
  final String imagepath;
  final String type;
  final Function onTap;

  const FurnitureCategoryItem({Key key, this.imagepath, this.type, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        height: 100,
        width: 100,
        child: Container(
          width: 90,
          height: 110,
          decoration: BoxDecoration(
            border: Border.all(width: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          child: InkWell(
            onTap: () {
              onTap();
            },
            child: Material(
              elevation: 5.5,
              borderRadius: BorderRadius.all(
                Radius.circular(7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    imagepath,
                    height: 50,
                    width: 50,
                  ),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
