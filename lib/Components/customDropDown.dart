import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'datamodal.dart';

class CustomDropdown extends StatefulWidget {
  final Function(String)? onChanged;

  const CustomDropdown({super.key, this.onChanged});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  var my_services;

  _onclicked(value) {
    print('Clicked...' + value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Container(
              height: 50,
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromARGB(255, 204, 216, 215)),
              ),
              child: Center(
                child: DropdownButton<String>(
                    hint: const Text('Choose Option'),
                    elevation: 16,
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    // onChanged: onChanged,
                    onChanged: (String? changedValue) {
                      my_services = changedValue;
                      setState(() {
                        my_services;
                        _onclicked(my_services);
                      });
                    },
                    value: my_services,
                    items: ServiceList.serviceOptions().map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList()),
              ),
            ),
          ),
        ]);
  }
}
