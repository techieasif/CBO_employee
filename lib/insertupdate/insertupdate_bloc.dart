import 'dart:async';
import 'package:cbo_employee/insertupdate/insertupdate_event.dart';
import 'package:cbo_employee/model/employee.dart';
import 'package:cbo_employee/repository/employee_repository.dart';

class InsertUpdateBloc {
  EmployeeRepository empRepository;

  InsertUpdateBloc(){
    empRepository = EmployeeRepository();
  }

  void handleEvent(event){
    if(event == InsertUpdateEvent.INSERT){
      
    }
    else if (event == InsertUpdateEvent.UPDATE){

    }
  }

  Future<int> addEmp(Employee emp) async {
    int result = await empRepository.insertEmployee(emp);
    return result;
  }  

  Future<int> updateEmp(Employee emp) async {
    int result = await empRepository.updateEmp(emp);
    return result;
  }
}