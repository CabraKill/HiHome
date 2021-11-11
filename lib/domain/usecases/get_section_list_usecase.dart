import 'package:dartz/dartz.dart';
import 'package:hihome/data/models/failure.dart';
import 'package:hihome/domain/models/section.dart';

abstract class GetSectionListUseCase {
  Future<Either<Failure, List<SectionEntity>>> call(String unitId);
}
