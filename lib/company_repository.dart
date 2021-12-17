import 'dart:core';

import 'data/db_employ.dart';
import 'data_base_employ.dart';

class CompanyRepository {
  var helper = DBHelper();

  // static final Map<String, Employ>  = {
  //  'two': Employ(id: "two", name: 'Ram', fathername: "RamFather"),
  // };

  Future<List<Employ>?> getCompanyList() async {
    try {
      var list = await helper.getEmploy();
      return list;
    } catch (e) {
      print('e');
      print(e);
    }
  }

  Future<void> addMember(Employ employ) async {
    try {
      await helper.save(employ);
    } catch (e) {
      print(e);
      print('We Cant Save The Member');
    }
  }

  updateMember(Employ employ) async {
    try {
      await helper.update(employ);
    } catch (e) {
      print(e);
      print(" Unable to Update the Member");
    }
  }

  deleteKeyNotes(String id) async {
    try {
      await helper.delete(id);
      print(id);
      print('delete Memeber');
    } catch (e) {
      print(e);
      print('Cant Delete ID');
    }
  }
}
