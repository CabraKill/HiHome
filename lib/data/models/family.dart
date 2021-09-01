import 'package:hihome/data/models/house.dart';

class FamilyModel {
  final String documentName;
  final String name;
  List<HouseModel>? houseList;

  FamilyModel({required this.documentName, required this.name, this.houseList});
}
