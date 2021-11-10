import 'package:get/get.dart';
import 'package:hihome/data/models/user.dart';
import 'package:hihome/data/models/user_credentials.dart';
import 'package:hihome/domain/models/section.dart';
import 'package:hihome/domain/models/unit.dart';
import 'package:hihome/domain/repositories/user_details_repository.dart';
import 'package:hihome/domain/usecases/get_unit_usecase.dart';
import 'package:hihome/infra/valueState/value_state.dart';
import 'package:hihome/infra/valueState/value_state_getx.dart';
import 'package:hihome/modules/details/details_binding.dart';
import 'package:hihome/modules/details/details_page.dart';
import 'package:hihome/modules/helpers/error_dialog.dart';

class _Rx {
  // final houseList = ValueCommomStateListGetX(<HouseModel>[].obs);
  final family = ValueCommomStateGetX(
      UnitEntity(familyId: "", name: "", houseList: [], path: ''));
  // final roomList = ValueCommomStateListGetX(<RoomModel>[].obs);
  final home = SectionEntity(id: "", name: "", path: '').obs;
  final userDetails = ValueCommomStateGetX(UserEntity(name: ""));
  final offSetHeight = 0.0.obs;
}

class HomeController extends GetxController with ErrorDialog {
  final userCredentials = Get.arguments as UserCredentials;
  final _rx = _Rx();
  final UserDetailsRepository userDetailsRepository;
  final GetUnitUseCase getUnitUseCaseImpl;

  HomeController(this.userDetailsRepository, this.getUnitUseCaseImpl);

  ValueCommomStateGetX<UnitEntity, dynamic> get family => _rx.family;
  bool get isHomeChoosed => _rx.home.value.id.isNotEmpty;
  List<SectionEntity> get houseList => _rx.family.value.houseList ?? [];
  ValueCommomStateGetX<UserEntity, dynamic> get userDetails => _rx.userDetails;
  double get offSetHeight => _rx.offSetHeight.value;
  set offSetHeight(double value) => _rx.offSetHeight.value = value;

  @override
  void onReady() {
    super.onReady();
    init();
  }

  ///Get the [family] from repo and update the current list
  Future<CommomState> updateFamily() async {
    family(CommomState.loading);
    await Future.delayed(Duration(seconds: 1));
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

  void goToDetails(SectionEntity house) {
    //TODO: remove in the future.
    // _rx.home(house);
    //TODO: add specific name
    Get.to(DetailsPage(offSetHeight: offSetHeight),
        arguments: house, binding: DetailsBinding());
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
    final updateUserResult = await updateUser();
    if (updateUserResult == CommomState.success) {
      updateFamily();
    }
  }
}
