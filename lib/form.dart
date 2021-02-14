import 'package:flutter/material.dart';
import 'package:multi_form/user.dart';
import 'package:dropdownfield/dropdownfield.dart';

typedef OnDelete();

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();

  double p = 0;
  double r = 0;
  double t = 0;
  double a = 0;

  amountCalc() {
    setState(() {
      a = p * (1 + r * t);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('User Details'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: DropDownField(
                  controller: citiesSelected,
                  hintText: "Selected any City",
                  itemsVisibleInDropdown: 2,
                  enabled: true,
                  items:
                      cities, //now you point of view you can take any type of list but remeber the point
                  onValueChanged: (value) {
                    setState(() {
                      selectCity = value;
                    });
                  },
                ),
                // child: TextFormField(
                //   initialValue: widget.user.fullName,
                //   onSaved: (val) => widget.user.fullName = val,
                //   validator: (val) =>
                //       val.length > 3 ? null : 'Full name is invalid',
                //   decoration:
                //    InputDecoration(
                //     labelText: 'Full Name',
                //     hintText: 'Enter your full name',
                //     icon: Icon(Icons.person),
                //     isDense: true,
                //   ),
                // ),
              ),

              Slider(
                max: 1000,
                min: 0,
                activeColor: Colors.teal,
                inactiveColor: Colors.teal[200],
                onChanged: (principal) {
                  setState(() {
                    p = principal;
                  });
                },
                value: p,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.teal),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Price',
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        Text(
                          '${double.parse(p.toStringAsFixed(0))} \$',
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Padding(
              //   padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
              //   child: TextFormField(
              //     initialValue: widget.user.email,
              //     onSaved: (val) => widget.user.email = val,
              //     validator: (val) =>
              //         val.contains('@') ? null : 'Email is invalid',
              //     decoration: InputDecoration(
              //       labelText: 'Email Address',
              //       hintText: 'Enter your email',
              //       icon: Icon(Icons.email),
              //       isDense: true,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}

String selectCity = ""; // by default we are not providing any of the city
final citiesSelected = TextEditingController();

List<String> cities = [
  "Mumbai",
  "Surat",
  "LA",
  "Husby",
  // "Akalla",
  // "Bow",
  // "Notthinghill",
  // "uk",
  // "Washington",
  // "New Jersey",
  // "Kolkatta",
  // "Jalander",
  // "New York",
];
