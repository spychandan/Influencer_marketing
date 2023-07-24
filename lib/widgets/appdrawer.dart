import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.only(top: 10),
        children: <Widget>[
          Container( 
            height: 150,
            child: UserAccountsDrawerHeader(    
            decoration: const BoxDecoration(
              color: Colors.transparent, 
            ),
            accountName: Row(
              children: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_image.jpg'),
                ),
                // SizedBox(width: 10), // Add spacing between the image and name
                // Text('John Doe',style: TextStyle(color: Colors.black)),
              ],
            ),
             accountEmail: Text('johndoe@example.com'),
          ),
          ),

          ListTile(
            title: Text('Terms and Conditions'),
            onTap: () {
              // Handle terms and conditions tap
            },
          ),
          ListTile(
            title: Text('Banking and KYC'),
            onTap: () {
              // Handle banking and KYC tap
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Handle logout tap
            },
          ),
        ],
      ),
    );
  }
}
