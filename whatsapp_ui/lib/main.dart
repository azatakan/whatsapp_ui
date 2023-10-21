import 'package:flutter/material.dart';

class ChatItemModel {
  String name;
  String mostRecentMessage;
  String messageDate;

  ChatItemModel(this.name, this.mostRecentMessage, this.messageDate);
}

class ChatHelper {
  static var chatList = [
    ChatItemModel("Fırat", "okulda mısın?", "16/07/2023"),
    ChatItemModel("Ali", "Evet", "06/09/2023"),
    ChatItemModel("Gamze", "tamam geliyorum", "02/08/2023"),
    ChatItemModel("Eda", "Bu hafta buluşalım mı?", "05/10/2019"),
    ChatItemModel("A.aa", "Olur nerdesin", "20/10/2019"),
  ];

  static ChatItemModel getChatItem(int position) {
    return chatList[position];
  }

  static var itemCount = chatList.length;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  IconData fabIcon = Icons.add;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      setState(() {
        switch (tabController.index) {
          case 0:
            fabIcon = Icons.add;
            break;
          case 1:
            fabIcon = Icons.camera_enhance;
            break;
          case 2:
            fabIcon = Icons.message;
            break;
          case 3:
            fabIcon = Icons.add;
            break;
          case 4:
            fabIcon = Icons.call;
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
        ),
      ),
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'WhatsApp',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: const <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: 20.0,
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 16.0,
                ),
                child: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ),
            ],
            backgroundColor: const Color.fromARGB(255, 7, 94, 84),
            bottom: TabBar(
              controller: tabController,
              tabs: const [
                Tab(icon: Icon(Icons.people_alt)),
                Tab(icon: Icon(Icons.camera_alt)),
                Tab(text: 'CHATS'),
                Tab(text: 'STATUS'),
                Tab(text: 'CALL'),
              ],
              indicatorColor: Colors.white,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(fabIcon),
            backgroundColor: const Color.fromARGB(255, 7, 94, 84),
          ),
          body: ChatList(),
        ),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ChatHelper.itemCount,
      itemBuilder: (context, position) {
        ChatItemModel chatItem = ChatHelper.getChatItem(position);

        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 64.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                chatItem.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                chatItem.messageDate,
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              chatItem.mostRecentMessage,
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: 16.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
