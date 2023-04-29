import 'package:flutter/material.dart';
import 'edit_person_page.dart';

void main() {
  runApp(MyApp());
}

class Person {
  final String name;
  final String address;
  final String birthday;
  final String imageUrl;

  Person(this.name, this.address, this.birthday, this.imageUrl);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Person> _people = [
    Person('Arjay Frias', 'San Carlos, Pangasinan', 'April 26, 2001',
        'https://scontent.fcrk2-2.fna.fbcdn.net/v/t39.30808-6/336274315_1352959432104418_4714135652958688463_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGSDstqmt32agqheXQfXfNaAvEUKtLdYCwC8RQq0t1gLC1bn0L-g-7fI8XTDEvfmJUEoWn2PEzP63EE4Wb7Snf3&_nc_ohc=rCmSXThR6nkAX9EHZdN&_nc_ht=scontent.fcrk2-2.fna&oh=00_AfCq4qiBnOkPiKi_i14PUepM4FbtzKZ91i_kvR6Z7UIIeQ&oe=645108A0'),
    Person('Julia Darby', 'Quezon City, Manila', 'July 7, 2006',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t39.30808-6/341141120_599811762061199_8585176717007761500_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=174925&_nc_eui2=AeF3dVniw1tglK0FvYHnJDrrC6d0OhSOml0Lp3Q6FI6aXYGO8UGyL1_dXNCG8Qnx4AvyCVvReStRyzpLJToeKhg7&_nc_ohc=8oMP8v92VioAX91EeEc&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfCqpNszmMlxeQT7VBS2tXb0KTF6WBJ1bhUPotE5ukSuog&oe=645187C7'),
    Person('Rheynalyn Sudaria', 'San Carlos, Pangasinan', 'December 27, 2000',
        'https://scontent.fcrk2-1.fna.fbcdn.net/v/t1.6435-9/122144532_1113285275740688_4773030796351361248_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=174925&_nc_eui2=AeH5tiS5kEL-JK04KuXPKZCAVQ-GqKejMb5VD4aop6Mxvrx8RqYi9XYOm5pOErR3UzD9tw5n-6VIhuATIICsOyke&_nc_ohc=hHBsNYdSCiQAX-0Z_DG&_nc_ht=scontent.fcrk2-1.fna&oh=00_AfByr8ayNonXDVIPLKeWTwJOX3d7nVmfDh0pTNS11H8Z1w&oe=64744A23'),
  ];

  void _updatePerson(int index, Person person) {
    setState(() {
      _people[index] = person;
    });
  }

  void _addPerson(Person person) {
    setState(() {
      _people.add(person);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'midExam',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('USER PROFILE'),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/tit.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.separated(
            padding: EdgeInsets.all(16.0),
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 16.0),
            itemCount: _people.length,
            itemBuilder: (BuildContext context, int index) {
              Person person = _people[index];

              return Card(
                color: Colors.transparent,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.imageUrl),
                  ),
                  title: Text(
                    person.name,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 7, 5, 5),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        'Address:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 21, 12, 12),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.address,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Birthday:',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        person.birthday,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    color: Color.fromARGB(255, 22, 21, 21),
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => EditPersonPage(
                            person: person,
                            index: index,
                          ),
                        ),
                      );
                      if (result != null) {
                        if (result['isNew'] == true) {
                          _addPerson(result['person']);
                        } else {
                          _updatePerson(result['index'], result['person']);
                        }
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
