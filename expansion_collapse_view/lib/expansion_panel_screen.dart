import 'package:flutter/material.dart';

class ExpansionPanelScreen extends StatefulWidget {
  ExpansionPanelScreenState createState() => ExpansionPanelScreenState();
}

class ExpansionPanelScreenState extends State<ExpansionPanelScreen> {
  List<ExpansionPanelItem> items = <ExpansionPanelItem>[
    ExpansionPanelItem(
        isExpanded: false,
        title: 'Header',
        content: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(children: <Widget>[
              Text('data'),
              Text('data'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('data'),
                  Text('data'),
                  Text('data'),
                ],
              ),
              Radio(
                  value: null,
                  groupValue: null,
                  onChanged: null) //put the children here
            ])),
        leading: Icon(Icons.image)),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  items[index].isExpanded = !items[index].isExpanded;
                });
              },
              children: items.map((ExpansionPanelItem item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                        leading: item.leading,
                        title: Text(
                          item.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ));
                  },
                  isExpanded: item.isExpanded,
                  body: item.content,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpansionPanelItem {
  bool isExpanded;
  final String title;
  final Widget content;
  final Icon leading;
  ExpansionPanelItem({this.isExpanded, this.title, this.content, this.leading});
}
