import 'package:hive/hive.dart';
part 'login.g.dart';
@HiveType(typeId: 0)
class Login extends HiveObject{
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String password;




  Login({required this.name,required this.password});
}