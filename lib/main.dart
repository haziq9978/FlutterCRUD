import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
  MaterialApp(
  
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    accentColor: Colors.cyan
  ),
  home: MyApp(),
));}

class MyApp extends StatefulWidget{
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp>{

  String studentName, studentID, studyProgramID;
  double studentGPA;

  getStudentName(name){
    this.studentName=name;
  }

  getStudentID(id){
    this.studentID=id;
  }

  getStudyProgramID(programID){
    this.studyProgramID=programID;
  }

  getStudentGPA(gpa){
    this.studentGPA=double.parse(gpa);
  }

  createData(){
    DocumentReference documentReference =
      FirebaseFirestore.instance.collection("MyStudents").
      doc(studentName);

      Map<String, dynamic> students ={
        "studentName": studentName,
        "studentID" : studentID,
        "studyProgramID": studyProgramID,
        "studentGPA" : studentGPA
      };

      documentReference.set(students).whenComplete((){
        print("$studentName created");
      });
  }

  readData(){
    DocumentReference documentReference = 
      FirebaseFirestore.instance.collection("MyStudents").
      doc(studentName);
    documentReference.get().then((datasnapshot){
      print(datasnapshot.data()["studentName"]);
      print(datasnapshot.data()["studentID"]);
      print(datasnapshot.data()["studyProgramID"]);
      print(datasnapshot.data()["studentGPA"]);
    });
  }

  updateData(){
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection("MyStudents").
      doc(studentName);

      Map<String, dynamic> students ={
        "studentName": studentName,
        "studentID" : studentID,
        "studyProgramID": studyProgramID,
        "studentGPA" : studentGPA
      };

      documentReference.set(students).whenComplete((){
        print("$studentName Updated");
      });
  }

  deleteData(){
    DocumentReference documentReference =
      FirebaseFirestore.instance.collection("MyStudents").
      doc(studentName);

      documentReference.delete().whenComplete((){
        print("$studentName deleted");
      });
  }
 
  @override
  Widget build(BuildContext context){

    return Scaffold(
      
      appBar: AppBar(
        title:Text("My Flutter"),
      ),
      body : Padding(
        padding:EdgeInsets.all(16.0),
          child:Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom:8.0),
              child:TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0))),
                onChanged:(String name){
                    getStudentName(name);
                },
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom:8.0),
              child:TextFormField(
                decoration: InputDecoration(
                  labelText: "Student ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0))),
                onChanged:(String id){
                  getStudentID(id);
                },
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom:8.0),
              child:TextFormField(
                decoration: InputDecoration(
                  labelText: "Study Program ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0))),
                onChanged:(String programID){
                  getStudyProgramID(programID);
                },
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom:8.0),
              child:TextFormField(
                decoration: InputDecoration(
                  labelText: "GPA",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0))),
                onChanged:(String gpa){
                  getStudentGPA(gpa);
                },
              ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text("Create"),
                  textColor: Colors.white,
                  onPressed: (){
                    createData();
                  },
                ),
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text("Read"),
                  textColor: Colors.white,
                  onPressed: (){
                    readData();
                  },
                ),
                RaisedButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text("Update"),
                  textColor: Colors.white,
                  onPressed: (){
                    updateData();
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text("Delete"),
                  textColor: Colors.white,
                  onPressed: (){
                    deleteData();
                  },
                ),
              ]
            ),
            Padding(padding: EdgeInsets.all(8.0),
            child:Row(
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Expanded(
                  child: Text("Name"),
                    ),
                Expanded(
                  child: Text("studentID"),
                    ),
                Expanded(
                  child: Text("ProgramID"),
                    ),
                Expanded(
                  child: Text("GPA"),
                    ),
              ],
              ),
              ),


            StreamBuilder(
              stream: FirebaseFirestore.instance.collection
              ("MyStudents").snapshots(),
              builder:(context,snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      DocumentSnapshot documentSnapshot=
                      snapshot.data.documents[index];
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(documentSnapshot
                            ["studentName"]),
                          ),
                          Expanded(
                            child: Text(documentSnapshot
                            ["studentID"]),
                          ),
                          Expanded(
                            child: Text(documentSnapshot
                            ["studyProgramID"]),
                          ),
                          Expanded(
                            child: Text(documentSnapshot
                            ["studentGPA"].toString()),
                          ),
                        ],
                      );
                    });
                }else{
                  return Align(
                    alignment: FractionalOffset.
                    bottomCenter,
                  child:CircularProgressIndicator());
                }
              }
            )
          ],
        ),
      )
    );
  }
}


