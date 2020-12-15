import 'dart:async';

import 'package:cbo_employee/repository/employee_repository.dart';
import 'package:cbo_employee/model/employee.dart';

class HomeBloc {
  EmployeeRepository employeeRepository;

  final _listController = StreamController<List<Employee>>();
  StreamSink<List<Employee>> get _inList => _listController.sink;
  Stream<List<Employee>> get list => _listController.stream;

  HomeBloc(){
    employeeRepository = EmployeeRepository();
  }

  getAllEmployees() async {
    List<Employee> result = await employeeRepository.getAllEmp();
    _inList.add(result);
  }

  Future<int> deleteEmployee(int id) async {
    int result = await employeeRepository.deleteProduct(id);
    return result;
  }

  deleteAll() async {
    int result = await employeeRepository.deleteAll();
    return result;
  }
}