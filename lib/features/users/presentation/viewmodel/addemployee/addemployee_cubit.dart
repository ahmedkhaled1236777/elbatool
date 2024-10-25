import 'dart:io';

import 'package:agman/features/users/data/models/addemployeerequest.dart';
import 'package:agman/features/users/data/repos/addemployeerepoimplementation.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'addemployee_state.dart';

class AddemployeeCubit extends Cubit<AddemployeeState> {
  final emplyeerepoimplementaion addemployeerepo;
  AddemployeeCubit({required this.addemployeerepo})
      : super(AddemployeeInitial());
  File? image;
  String? is_active;
  uploadimage() async {
    XFile? pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      image = File(pickedimage!.path);
      emit(changeprofileimage());
    }
  }

  resetimage() {
    image = null;
    emit(changeprofileimage());
  }

  bool loading = false;
  List headertable = ["اسم الموظف", "الوظيفه", "رقم الهاتف", "تعديل", "حذف"];
  Map permessions = {
    'الحقن': "injections",
    'اوردرات الحقن': "injection_orders",
    'تصنيع الاسطمبات': "stamp_manufacturing",
    'الموظفين': "employees",
    'المستخدمين': "users",
    'العملاء': "customers",
    'الموردين': "suppliers",
    'مخزن الخامات': "material_store",
    'مخزن الاكسسوارات': "accessories_store",
    "مخزن المكونات": "components_store",
    'مخزن ادوات المصنع': "factory_tools_store",
    'الاعدادات': "settings",
    'الاشعارات': "notifications",
  };
  Map showpermessions = {
    "injections": 'الحقن',
    "injection_orders": 'اوردرات الحقن',
    "stamp_manufacturing": 'تصنيع الاسطمبات',
    "employees": 'الموظفين',
    "users": "المستخدمين",
    "customers": 'العملاء',
    "suppliers": 'الموردين',
    "material_store": 'مخزن الخامات',
    "accessories_store": 'مخزن الاكسسوارات',
    "components_store": "مخزن المكونات",
    "factory_tools_store": 'مخزن ادوات المصنع',
    "settings": 'الاعدادات',
    "notifications": 'الاشعارات',
  };
  List<String> selecteditems = [];
  getselecteditems() {
    List<String> employeepermession = [];
    for (int i = 0; i < selecteditems.length; i++) {
      if (selecteditems[i] == "الاشعارات" || selecteditems[i] == "الاعدادات") {
        continue;
      }
      employeepermession.add(permessions[selecteditems[i]]);
    }
    return employeepermession;
  }

  showselecteditems(List<dynamic> permessions) {
    selecteditems = [];
    for (int i = 0; i < permessions.length; i++) {
      if (showpermessions[permessions[i]] != null &&
          !selecteditems.contains(permessions[i]))
        selecteditems.add(showpermessions[permessions[i]]);
    }
  }

  addemployee(
      {required String token, required addemployeemodel employee}) async {
    emit(Addemployeeloading());
    var result =
        await addemployeerepo.addemployee(token: token, employee: employee);
    result.fold((failure) {
      emit(Addemployeefailure(error_message: failure.error_message));
    }, (succes) {
      emit(Addemployeesuccess(succes_message: succes));
    });
  }

  updateemployee(
      {required String token,
      required int id,
      required addemployeemodel employee}) async {
    emit(updateemployeeloading());
    var result = await addemployeerepo.editemployee(
        token: token, id: id, employee: employee);
    result.fold(
        (l) => {emit(updateemployeefailure(errormessage: l.error_message))},
        (r) => {emit(updateemployeesuccess(succes_message: r))});
  }

  resetdata() {
    selecteditems = [];
    image = null;
    emit(resetdatastate());
  }

  changestatus(String val) {
    this.is_active = val;
    emit(changestatusstate());
  }
}
