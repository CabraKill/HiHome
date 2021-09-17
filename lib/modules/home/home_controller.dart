import 'package:get/get.dart';
import 'package:hihome/data/models/unit.dart';
import 'package:hihome/data/models/house.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/data/usecases/get_unit_usecase.dart';
import 'package:hihome/domain/repositories/user_details_repository.dart';
import 'package:hihome/infra/valueState/value_state.dart';
import 'package:hihome/infra/valueState/value_state_getx.dart';
import 'package:hihome/modules/helpers/error_dialog.dart';

class _Rx {
  // final houseList = ValueCommomStateListGetX(<HouseModel>[].obs);
  final family =
      ValueCommomStateGetX(UnitModel(familyId: "", name: "", houseList: []));
  // final roomList = ValueCommomStateListGetX(<RoomModel>[].obs);
  final home = HouseModel(id: "", name: "").obs;
  final userDetails = ValueCommomStateGetX(UserModel(name: ""));
}

class HomeController extends GetxController with ErrorDialog {
  final userCredentials = Get.arguments as UserCredentials;
  final _rx = _Rx();
  final UserDetailsRepository userDetailsRepository;
  final GetUnitUseCaseImpl getUnitUseCaseImpl;

  HomeController(this.userDetailsRepository, this.getUnitUseCaseImpl);

  ValueCommomStateGetX<UnitModel, dynamic> get family => _rx.family;
  bool get isHomeChoosed => _rx.home.value.id.isNotEmpty;
  List<HouseModel> get houseList => _rx.family.value.houseList;
  ValueCommomStateGetX<UserModel, dynamic> get userDetails => _rx.userDetails;

  @override
  void onReady() {
    super.onReady();
    init();
  }

  ///Get the [family] from repo and update the current list
  Future<CommomState> updateFamily() async {
    family(CommomState.loading);
    final result = await getUnitUseCaseImpl(userDetails.value.familyId!);
    result.fold(
      (failure) {
        family(CommomState.error, error: failure);
      },
      (_family) {
        family(CommomState.success, data: _family);
      },
    );
    return family.stateValue;
  }

  void goToDetails(HouseModel house) {
    _rx.home(house);
  }

  Future<CommomState> updateUser() async {
    final result = await userDetailsRepository.getUser(userCredentials.id);
    result.fold((failure) {
      userDetails(CommomState.error, error: failure);
    }, (user) {
      userDetails(CommomState.success, data: user);
    });
    return userDetails.stateValue;
  }

  void init() async {
    if (await updateUser() == CommomState.success) {
      updateFamily();
    }
  }
}
