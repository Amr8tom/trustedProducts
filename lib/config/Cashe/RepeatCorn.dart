// import 'package:cron/cron.dart';
// import '/config/repository/Bcodes_repo.dart';
// import '/config/Cashe/CasheHelper.dart';
// class Cron_repeat {
//
//   static Future Refreshdata() async {
//     var cron = Cron().schedule(Schedule.parse(' 0 0 6 * * *'), () async{
//       chache.SaveJson(Key: "JsonBC", JsonValue: await BcodesRepo.fetchData())
//       print("============================>>  yarab");
//     });
//   }
//
//
// }