import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: const[
            Expanded(
            child: Center(      
            child: Padding(
            
              padding: EdgeInsets.symmetric(
                vertical: 50,
                horizontal: 50
              ),
              child: TextField()),
            )
            ),
          ],
        ),
      ),
      //resizeToAvoidBottomInset: false,
      //drawerEdgeDragWidth: 100,
      drawerEnableOpenDragGesture: false,
      onDrawerChanged: (isOpen) {
        print(isOpen);
      },
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Home"),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.warning_amber,
          size: 30,
        ),
        onPressed: () {
          print("Preionó");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      drawer: Drawer(
        width: 150,
        elevation: 50,
        child: Column(children: const [
          SizedBox(
            height: 50,
          ),
          Text(
            "Prueba@prueba.com",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ]),
      ),
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.logout),)
        ],
        elevation: 5,
        shadowColor: Colors.black,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
        ),
        titleTextStyle: const TextStyle(
          color: Color(0xffB17A50),
          fontSize: 50,
          fontFamily: 'FuenteWeSafe',
        ),
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "weSafe",
            ),
          ],
        ),
      ),
    );
  }
}
