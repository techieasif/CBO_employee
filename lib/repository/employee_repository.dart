import 'package:cbo_employee/repository/base_repository.dart';
import 'package:cbo_employee/model/employee.dart';

class EmployeeRepository extends BaseRepository{
  Future<int> insertEmployee(Employee emp) async{
    final db = await database;
    var result = await db.rawInsert('INSERT INTO cboEmployee(name, empCode, mobileNo, dob, remarks, address) VALUES (?,?,?,?,?,?)', [emp.getName(), emp.getEmpCode(), emp.getMobileNo(), emp.getDOB(), emp.getRemarks(), emp.getAddress()]);
    return result;
  }

  Future<List<Employee>> getAllEmp() async {
    final db = await database;
    // var result = await db.query('msProduct');
    var result = await db.rawQuery('SELECT * FROM cboEmployee');
    List<Employee> listProduct = result.isNotEmpty ? result.map((c) => Employee.fromMap(c)).toList() : [];
    return listProduct;
  }

  Future<int> updateEmp(Employee product) async {
    final db = await database;
    int result = await db.update('cboEmployee', product.toMap(), where: 'id = ${product.getId()}');
    return result;
  }

  Future<int> deleteAll() async {
    final db = await database;
    return await db.delete('cboEmployee');
  }

  Future<int> deleteProduct(int id) async {
    final db = await database;
    return await db.delete('cboEmployee', where: 'id = $id');
  }
}