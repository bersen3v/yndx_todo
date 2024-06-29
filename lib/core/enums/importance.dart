import 'package:hive/hive.dart';
part 'importance.g.dart';

@HiveType(typeId: 3)
enum Importance {
  @HiveField(0)
  low,
  @HiveField(1)
  basic,
  @HiveField(2)
  important,
}
