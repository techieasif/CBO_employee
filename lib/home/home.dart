import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cbo_employee/home/home_bloc.dart';
import 'package:cbo_employee/insertupdate/insertupdate.dart';
import 'package:cbo_employee/model/employee.dart';
import 'package:cbo_employee/util/SnackBarUtil.dart';

class HomeLayout extends StatefulWidget {
  @override
  HomeLayoutState createState() => HomeLayoutState();
}

class HomeLayoutState extends State<HomeLayout> {
  final HomeBloc _bloc = HomeBloc();


  final scfKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    _bloc.getAllEmployees();
    return Scaffold(
      key: scfKey,
      appBar: AppBar(
        title: Text("CBO Employee"),
        actions: [
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _bloc.getAllEmployees();
                scfKey.currentState..hideCurrentSnackBar()..showSnackBar(SnackBar(content: Text("Refreshing data"),));
              })
        ],
      ),
      body: StreamBuilder(
        stream: _bloc.list,
        initialData: List<Employee>(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Employee> listProduct = snapshot.data;
            if (listProduct.length == 0) {
              return Center(
                child: Text('No Employees found'),
              );
            }

            return ListView.separated(
              separatorBuilder: (context, i) => Divider(
                color: Colors.grey,
              ),
              itemCount: listProduct.length,
              itemBuilder: (context, i) {
                return ListItem(_bloc, listProduct[i]);
              },
            );
          } else {
            return Center(
              child: Text('No Data'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      InsertUpdateLayout(Employee().setId(0))));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Employee product;
  final HomeBloc _bloc;

  ListItem(this._bloc, this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: EdgeInsets.all(8.0),
      // margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0.0),
            dense: true,
            title: Text(
              product.getName(),
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text("Code: ${product.getEmpCode().toString()}"),
            trailing: Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () => gotoInsertUpdate(context, product),
                    child: Icon(Icons.edit, color: Colors.grey),
                  ),
                ),
                GestureDetector(
                  onTap: () => dialogDelete(context, product),
                  child: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.all(0.0),
            dense: true,
            trailing: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(4),
                child: Text("DOB: ${product.dob}")),
            title: Text("Phone: ${product.getMobileNo()}"),
            subtitle: Text("Address: ${product.address}"),
          ),
          Divider(),
          Text(
            "REMARKS",
            style: Theme.of(context)
                .textTheme
                .subtitle1
                .copyWith(color: Colors.green.shade900),
          ),
          Divider(),
          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            child: Text(
              "${product.remarks}",
            ),
          )
        ],
      ),
    );
  }

  void gotoInsertUpdate(BuildContext context, Employee product) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => InsertUpdateLayout(product)));
  }

  void dialogDelete(BuildContext context, Employee product) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Delete'),
              content:
                  Text('Are you sure want to delete "${product.getName()}"?'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    int result = await _bloc.deleteEmployee(product.getId());
                    if (result > 0) {
                      _bloc.getAllEmployees();
                    }
                    Navigator.pop(context);
                    SnackBarUtil.successSnackBar(context);
                  },
                  child: Text("Yes"),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No"),
                ),
              ],
            ));
  }
}
