import 'package:cbo_employee/util/UtilMethods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cbo_employee/insertupdate/insertupdate_bloc.dart';
import 'package:cbo_employee/model/employee.dart';
import 'package:cbo_employee/util/SnackBarUtil.dart';

class InsertUpdateLayout extends StatefulWidget {
  final Employee employee;

  InsertUpdateLayout(this.employee);

  @override
  _InsertUpdateLayoutState createState() => _InsertUpdateLayoutState();
}

class _InsertUpdateLayoutState extends State<InsertUpdateLayout> {
  final InsertUpdateBloc _bloc = InsertUpdateBloc();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController empCodeController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController remarksController = TextEditingController();

  final TextEditingController mobileNoController = TextEditingController();

  String dob = "";

  final formKey = GlobalKey<FormState>();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1931, 1),
        lastDate: DateTime(2021, 12));
    if (picked != null && picked != DateTime.now())
      setState(() {
        dob = UtilMethods.getFormattedDate(picked.toString());
      });
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    if (widget.employee.getId() == 0) {
      title = "Insert";
    } else {
      title = "Update";
      nameController.text = widget.employee.getName();
      empCodeController.text = widget.employee.getEmpCode().toString();
      addressController.text = widget.employee.getAddress();
      mobileNoController.text = widget.employee.getMobileNo();
      remarksController.text = widget.employee.getRemarks();
      dob = widget.employee.getDOB();
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("CBO Employee"),
        ),
        body: Builder(
            builder: (context) => Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontSize: 25.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    empNameField(),
                                    empCodeField(),
                                    empMobileField(),
                                    empAddressField(),
                                    empRemarkField(),
                                    dobWidget(context),
                                    SizedBox(height: 16,),
                                    Container(
                                      width: double.infinity,
                                      color: Theme.of(context).accentColor,
                                      child: FlatButton(
                                        onPressed: () => onSave(context),
                                        child: Text("Save", style: TextStyle(color: Colors.white),),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        )
                      ],
                    ),
                  ),
                )));
  }

  ListTile dobWidget(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey.shade100,
      onTap: () => _selectDate(context),
      title: Text("DOB:"),
      trailing: Text("$dob"),
      subtitle: Text("tap to update"),
    );
  }

  Padding empRemarkField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: remarksController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (v) {
          if (v.isEmpty) {
            return "required";
          } else {
            return null;
          }
        },
        minLines: 4,
        maxLines: 10,
        decoration: InputDecoration(labelText: "Remarks"),
      ),
    );
  }

  Padding empAddressField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: addressController,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (v) {
          if (v.isEmpty) {
            return "required";
          } else {
            return null;
          }
        },
        minLines: 2,
        maxLines: 10,
        decoration: InputDecoration(labelText: "Employee Address"),
      ),
    );
  }

  Padding empMobileField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        maxLength: 10,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (v) {
          if (v.isEmpty) {
            return "required";
          } else if (v.length != 10) {
            return "Employee Mobile should be of 10 digits";
          } else {
            return null;
          }
        },
        controller: mobileNoController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: "Employee Mobile"),
      ),
    );
  }

  Padding empCodeField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        maxLength: 6,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (v) {
          if (v.isEmpty) {
            return "required";
          } else if (v.length != 6) {
            return "Employee code should be of 6 digits";
          } else {
            return null;
          }
        },
        controller: empCodeController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: "Employee code"),
      ),
    );
  }

  Padding empNameField() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        validator: (v) {
          if (v.isEmpty) {
            return "require";
          } else {
            return null;
          }
        },
        controller: nameController,
        decoration: InputDecoration(labelText: "Employee Name"),
      ),
    );
  }

  void onSave(BuildContext context) async {
    if (formKey.currentState.validate() && this.dob.isNotEmpty) {
      int result = -1;
      Employee product = Employee()
          .setName(nameController.text.trim())
          .setEmpCode(int.parse(empCodeController.text.trim()))
          .setAddress(addressController.text.trim())
          .setRemarks(remarksController.text.trim())
          .setMobileNo(mobileNoController.text.trim())
          .setDOB(this.dob);
      print("DATA BEFORE INSERTING ${product.toMap()}");
      if (widget.employee.getId() == 0) {
        // INSERT
        product.setId(0);
        result = await _bloc.addEmp(product);
      } else {
        // UPDATE
        product.setId(widget.employee.getId());
        result = await _bloc.updateEmp(product);
      }

      if (result > 0) {
        Navigator.pop(context);
      } else {
        SnackBarUtil.errorSnackBar(context);
      }
    } else {
      SnackBarUtil.showSnackbar(context, "Please fill all the field");
    }
  }
}
