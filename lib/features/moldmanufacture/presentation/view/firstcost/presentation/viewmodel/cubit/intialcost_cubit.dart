import 'dart:io';

import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/model/intialcostmodelrequest.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/repos/intialcostrepoimp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/model/intialcostmodel/datum.dart';

part 'intialcost_state.dart';

class IntialcostCubit extends Cubit<IntialcostState> {
  final Intialcostrepoimp intialcostrepoimp;
  IntialcostCubit({required this.intialcostrepoimp})
      : super(IntialcostInitial());
  File? image;
  bool firstloading = false;
  List<Datum> data = [];
  addintialcost({required Intialcostmodelrequest intialcost}) async {
    emit(addintialcostloading());
    var result = await intialcostrepoimp.addintialcost(intialmodel: intialcost);
    result.fold((failure) {
      emit(addintialcostfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addintialcostsuccess(successmessage: success));
    });
  }

  uploadimage() async {
    XFile? pickedimage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      image = File(pickedimage!.path);
      emit(addnewimagestate());
    }
  }

  resetimage() {
    image = null;
    emit(addnewimagestate());
  }

  getfirstcosts({required int stampid}) async {
    if (firstloading == false) emit(getintialcostloading());
    var result = await intialcostrepoimp.getintialcost(stampid: stampid);
    result.fold((failue) {
      emit(getintialcostfailure(errormessage: failue.error_message));
    }, (success) {
      data.clear();
      firstloading = true;
      data.addAll(success.data!);
      emit(getintialcostsuccess(successmessage: ""));
    });
  }

  deleteintialcost({
    required int id,
  }) async {
    emit(deleteintialcostloading());
    var result = await intialcostrepoimp.deleteintialcost(id: id);
    result.fold((failure) {
      emit(deleteintialcostfailure(failuremessage: failure.error_message));
    }, (success) {
      for (int i = 0; i < data.length; i++) {
        if (data[i].id == id) {
          data.removeAt(i);
          break;
        }
      }

      emit(deleteintialcostsuccess(successmessage: success));
    });
  }
}
