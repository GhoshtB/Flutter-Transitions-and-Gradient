import 'package:flutter/material.dart';
import 'package:flutter_app_test/bloc/postsbloc.dart';
import 'package:flutter_app_test/model/posts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyNewHomePage(),
    );
  }
}

class MyNewHomePage extends StatefulWidget {
  @override
  State createState() => MyNewHomePageState();
}

class MyNewHomePageState extends State<MyNewHomePage> {
  var postList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Posts"),
          backgroundColor: Colors.blueAccent,
          leading: Icon(
            Icons.add_location,
            color: Colors.amber,
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      PageRouteBuilder(transitionDuration:Duration(milliseconds: 4000),pageBuilder: (context,animation,newanimation) => MyTabPages()
                      ,transitionsBuilder: (context,animation,newanimation,child){
                           return FadeTransition(
                             opacity:animation,
                              child: child,
                            );
                          }));
                })
          ],
        ),
        body: Center(
          child: Flexible(
              child: StreamBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return formedCard(snapshot.data[index]);
                  },
                  itemCount: snapshot.data.length,
                );
              } else {
                return CircularProgressIndicator();
              }
            },
            stream: bloc.postList,
          )),
        ));
  }

  Widget FormedCard(Posts data) {
    return Padding(
      padding: EdgeInsets.all(9),
      child: Material(
        elevation: 3.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                data.title,
                style: TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(3),
              child: Text(
                data.body,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Text(
              "User Id:${data.userId}",
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 14, color: Colors.blueGrey),
            ),
            SizedBox(
              height: 8,
            )
          ],
        ),
      ),
    );
  }

  Widget formedCard(Posts data) {
    return Padding(
      padding: EdgeInsets.all(7),
      child: Material(
        elevation: 5,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          child: ListTile(
            title: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                data.title,
                style: TextStyle(fontSize: 18, color: Colors.amber[300]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                data.body,
                style: TextStyle(fontSize: 12),
              ),
            ),
            trailing: Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "User Id:${data.userId}",
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 14, color: Colors.blueGrey),
              ),
            ),
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: <Color>[Colors.blue[100], Colors.blueGrey[100]]),
              shape: BoxShape.rectangle,
              boxShadow: [
                BoxShadow(color: Colors.blue),
                BoxShadow(color: Colors.blueAccent)
              ]),
        ),
      ),
    );
  }
}

class MyTabPages extends StatefulWidget {
  @override
  State createState() => MyTabPagesState();
}

class MyTabPagesState extends State<MyTabPages> with SingleTickerProviderStateMixin{
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabs Page",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.lightGreenAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.ac_unit,color: Colors.pink,), onPressed: (){
            Navigator.push(context, PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 2000),
              pageBuilder: (context, animation, anotherAnimation)=>SecondWidget()
            ,transitionsBuilder: (context, animation, anotherAnimation,child){
              var curveList=<Curve>[];
              var index=0;
              animation = CurvedAnimation(
                  curve: Curves.fastOutSlowIn, parent: animation);
              return SlideTransition(
                position: Tween(
                    begin: Offset(1.0, 0.0),
                    end: Offset(0.0, 0.0))
                    .animate(animation),
                child: child,
              );/*FadeTransition(
                  opacity:animation,
                  child: child,
              );*/
              }));
          })
        ],
        bottom: TabBar(controller:controller,indicatorColor:Colors.pink,
            unselectedLabelColor:Colors.white,tabs: [
          Tab(
            text: "First Tab",
            icon: Icon(
              Icons.ac_unit,
              color: Colors.white,
            ),
          ),
          Tab(
            text: "Second Tab",
            icon: Icon(
              Icons.stars,
              color: Colors.white,
            ),
          ),
          Tab(
            text: "Third Tab",
            icon: Icon(
              Icons.airport_shuttle,
              color: Colors.white,
            ),
          ),
        ]),
      ),
      body: TabBarView(children: <Widget>[
        FirstWidget(), FirstWidget(), FirstWidget(),
      ],controller:controller ,),
    );
  }

  FirstWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightGreenAccent[200],
        gradient: RadialGradient(colors: [Colors.amber[50],Colors.amberAccent[100]],radius: 5)
      ),
    );
  }

  @override
  void didUpdateWidget(MyTabPages oldWidget) {

  }
}

class SecondWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.brown[400],
            leading: Icon(Icons.menu,color: Colors.white,),
            title: Text("Flutter"),actions: <Widget>[
            Icon(Icons.volume_off),
          ], bottom: PreferredSize(child: Icon(Icons.linear_scale,size: 60.0,), preferredSize: Size.fromHeight(50.0)),
          flexibleSpace: ListView(
          children: <Widget>[
              Text("Sample 1"),
          Text("Sample 2"),
          Text("Sample 3")

        ],
      ),),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(leading: Icon(Icons.volume_off), title: Text("Volume Off"),),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(leading: Icon(Icons.volume_mute), title: Text("Volume Mute")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),
              ListTile(leading: Icon(Icons.volume_down), title: Text("Volume Down")),

            ]),
          )
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
