import 'package:flutter/material.dart';
import 'package:flutter_homework_7/models/user_model.dart';
import 'package:flutter_homework_7/services/database_helper.dart';

class UserScreen extends StatelessWidget {
  final User? user;
  const UserScreen({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final ageController = TextEditingController();

    if (user != null) {
      nameController.text = user!.name;
      ageController.text = user!.age;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(user == null ? 'Add a user' : 'Edit user'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextFormField(
                controller: nameController,
                maxLines: 1,
                decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.75,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ))),
              ),
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ))),
              onChanged: (str) {},
              maxLines: 1,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () async {
                      final name = nameController.value.text;
                      final age = ageController.value.text;

                      if (name.isEmpty || age.isEmpty) {
                        return;
                      }

                      final User model =
                          User(name: name, age: age, id: user?.id);
                      if (user == null) {
                        await DatabaseHelper.addUser(model);
                      } else {
                        await DatabaseHelper.updateUser(model);
                      }

                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blue,
                                  width: 0.75,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                )))),
                    child: Text(
                      user == null ? 'Save' : 'Edit',
                      style: const TextStyle(fontSize: 20),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
