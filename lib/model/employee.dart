import 'dart:convert';

Employee fromJson(String str) {
  final jsonData = json.decode(str);
  return Employee.fromMap(jsonData);
}

String toJson(Employee employee) {
  final dyn = employee.toMap();
  return json.encode(dyn);
}

class Employee {
  int id;
  String name;
  int empCode;
  String address;
  String mobileNo;
  String remarks;
  String dob;

  Employee(
      {this.id,
      this.name,
      this.empCode,
      this.address,
      this.dob,
      this.mobileNo,
      this.remarks});

  ///--------------GETTER AND SETTERS-----------------------------------------

  String getRemarks() {
    return remarks;
  }

  Employee setRemarks(String remark) {
    this.remarks = remark;
    return this;
  }

  String getDOB() {
    return dob;
  }

  Employee setDOB(String dob) {
    this.dob = dob;
    return this;
  }

  String getMobileNo() {
    return mobileNo;
  }

  Employee setMobileNo(String mobile) {
    this.mobileNo = mobile;
    return this;
  }

  String getAddress() {
    return address;
  }

  Employee setAddress(String address) {
    this.address = address;
    return this;
  }

  int getId() {
    return id;
  }

  Employee setId(int id) {
    this.id = id;
    return this;
  }

  Employee setName(String name) {
    this.name = name;
    return this;
  }

  String getName() {
    return name;
  }

  Employee setEmpCode(int empCode) {
    this.empCode = empCode;
    return this;
  }

  int getEmpCode() {
    return empCode;
  }

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
      id: json['id'],
      name: json['name'],
      empCode: json['empCode'],
      address: json['address'],
      dob: json['dob'],
      mobileNo: json['mobileNo'],
      remarks: json['remarks']);

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'empCode': empCode,
        'mobileNo': mobileNo,
        'remarks': remarks,
        'dob': dob,
        'address': address,
      };
}
