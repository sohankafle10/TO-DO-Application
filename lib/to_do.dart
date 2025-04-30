import 'package:flutter/material.dart';
import 'package:todoapplication/model/todo.dart';
// import 'package:to_do_application/model/todo.dart';


class Screen_1 extends StatefulWidget {
  Screen_1({super.key});

  @override
  State<Screen_1> createState() => _Screen_1State();
}

class _Screen_1State extends State<Screen_1> {

  final GlobalKey<FormState> _todoFormKey = GlobalKey();
  String thisTitle = "";
  String thisDescription = "";



  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Application"),
      ),
      body: Column(
        children: [
       
        Expanded(
         
          child:
                todos.isEmpty
                    ? Center(child: Text("Kei kam garna baki xaina aba ta"))
                    : ListView.builder(
                      itemBuilder: (ctx, i) {
          return ListTile(
              leading: Checkbox(
                value: todos[i].isCompleted,
                onChanged:(value){
                  setState(() {
                    todos[i].isCompleted = value!;
                  });
                },
              
              ),
              trailing: IconButton(onPressed: (){
                showDialog(context: (context), builder: (context){
                    return AlertDialog(
                      title: Text("Are you sure, you want to delete?"),
                      content: Text("This action is not reversible"),
                      actions: [
                              FilledButton(
                                onPressed: () {
                                  setState(() {
                                    todos.remove(todos[i]);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    
                                    SnackBar(content: Text("Deleted"),
                                    backgroundColor: Colors.greenAccent.shade700,
                                    dismissDirection: DismissDirection.endToStart,
                                    duration: Duration(seconds: 1),
                                    
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                },
                                child: Text("Yes"),
                              ),
                              FilledButton.tonal(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("No"),
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ],
                    );
                });
              }, icon: Icon(Icons.delete_outline_rounded)),
              title: Text(
                todos[i].title,
              style: TextStyle(
                color: todos[i].isCompleted? Colors.red: null,
                decoration: todos[i].isCompleted? TextDecoration.lineThrough: null,
                
              ),),
              subtitle: Text(todos[i].description),
            );
          },
          itemCount: todos.length,
        ),
        )
        ],


      ),

      floatingActionButton: FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key:_todoFormKey,
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                        Text("Add Todo", style: TextStyle(fontSize: 20)),
                        TextFormField(
                          
                          decoration: InputDecoration(hintText: "What to do?"),
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "K lekhni hokahi ta halieko vai";
                            }else{
                              return null;
                            }
                          },
                          onSaved: (value){
                            setState(() {
                              thisTitle = value!;
                            });
                          },
                          onTapOutside: (event) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          
                        ),
                        TextFormField(
                          
                          decoration: InputDecoration(hintText: "Description"),
                          maxLines: 3,
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return "Kehi ta lekhna paro nii yr";
                            }else{
                              return null;
                            }
                          }, 
                          onSaved: (value){
                            setState(() {
                              thisDescription = value!;
                            });
                          },

                          onTapOutside: (event) {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FilledButton(
                              onPressed: () {
                                if (!_todoFormKey.currentState!.validate()) {
                                  return;
                                }
                                _todoFormKey.currentState!.save();
                                setState(() {
                                  todos.add(
                                    Todo(
                                      id: DateTime.now().toString(),
                                      description: thisDescription,
                                      title: thisTitle,
                                    ),
                                  );
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text("Add todo"),
                            ),


                            FilledButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text("Back"),)
                          ],
                        ),
                      ],
                )
                
                ),
              ),
            );
          },
        );
      },
      child: Icon(Icons.add),),
    );
  }
}