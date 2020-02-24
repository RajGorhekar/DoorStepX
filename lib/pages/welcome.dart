import 'package:Doorstepx/pages/Register.dart';
import 'package:Doorstepx/pages/login.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
              "Hello, Raj",
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
          child: Stack(
            children: <Widget>[
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.notifications_none,
                  color: Colors.black87,
                  size: 28,
                ),
              ),
              Positioned(
                top: 0,
                right: 2,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    border: Border.all(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBody(height, width) {
    return Container(
      height: height,
      width: width,
      color: Colors.white,
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
                  stops: [0.1, 0.3, 0.5, 0.7],
                  colors: [
                    Colors.blue[800],
                    Colors.blue[700],
                    Colors.blue[600],
                    Colors.blue[400],
                  ],
                ),
              ),
              padding: EdgeInsets.only(left: 20),
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
          _buildContent(height, width),
        ],
      ),
    );
  }

  Widget _buildContent(height, width) {
    return Positioned(
      top: (height * .35) + 50,
      width: width,
      height: height - (height * .35) + 50,
      child: LayoutBuilder(
        builder: (BuildContext c, BoxConstraints constraints) {
          final List<Widget> items = [];

          items.add(SizedBox(
            height: constraints.maxHeight / 3,
          ));

          return ListView(
            padding: EdgeInsets.only(left: 20),
            children: items,
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection(height, width) {
    return Positioned(
      width: width,
      height: 100,
      top: (height * .35) - 45,
      child: ListView(
        padding: EdgeInsets.only(left: 20),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          FurnitureCategoryItem(
            icon: Icons.directions_bike,
            type: 'Electrician',
            onTap: ()=>Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register())),
          ),
          FurnitureCategoryItem(
            icon: Icons.directions_bike,
            type: 'Doctor',
            onTap: ()=>Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login())),
          ),
          FurnitureCategoryItem(
            icon: Icons.directions_bike,
            type: 'House Cleaning',
          ),
          FurnitureCategoryItem(
            icon: Icons.directions_bike,
            type: 'Gardener',
          ),
          FurnitureCategoryItem(
            icon: Icons.directions_bike,
            type: 'BabySitter',
          ),
          FurnitureCategoryItem(
            icon: Icons.directions_bike,
            type: 'Plumber',
          ),
          FurnitureCategoryItem(
            icon: Icons.directions_bike,
            type: 'Packers \nand Movers',
          ),
        ],
      ),
    );
  }
}

class FurnitureCategoryItem extends StatelessWidget {
  final IconData icon;
  final String type;
  final Function onTap;

  const FurnitureCategoryItem({Key key, this.icon, this.type, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Container(
        height: 110,
        width: 90,
        child: Container(
          width: 90,
          height: 110,
          decoration: BoxDecoration(
            border: Border.all(width: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          //child: Image.asset('./assets/images/faucet.png')
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
                  Icon(
                    icon,
                    size: 40,
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
