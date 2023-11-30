import 'package:dappwallet/utils/export.dart';
import 'package:get_storage/get_storage.dart';

class LanuageSelect extends StatefulWidget {
  const LanuageSelect({super.key});

  @override
  State<LanuageSelect> createState() => _LanuageSelectState();
}

class _LanuageSelectState extends State<LanuageSelect> {
  List<listlanuage> _list = [
    listlanuage(name: "English", code: 'eu'),
    listlanuage(name: "ਪੰਜਾਬੀ", code: 'pu'),
    listlanuage(name: "हिंदी", code: 'hi'),
  ];
  int _slect = -1;
  bool loading = false;
  @override
  void initState() {
    getdata();
    super.initState();
  }

  getdata() async {
    var code = await SharedPreferenceClass.GetSharedData(AppContant.lanuage);
    int ind = _list.indexWhere((element) => element.code == code) ?? -1;
    _slect = ind;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSecond(
          title: Lanuage.Lanuageselect, context: context, back: true),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: RadioListTile(
                title: Text(_list[index].name.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                value: index,
                activeColor: Theme.of(context).primaryColor,
                selectedTileColor: Theme.of(context).primaryColor,
                tileColor: Theme.of(context).scaffoldBackgroundColor,
                groupValue: _slect,
                onChanged: (value) async {
                  await SharedPreferenceClass.SetSharedData(
                      AppContant.lanuage, _list[index].code.toString());
                  changelanuage(_list[index].code);
                },
              ),
            );
          }),
    );
  }

  changelanuage(String lg) {
    var locale = Locale(lg);
    final box = GetStorage();
    box.write('language', locale);
    Get.updateLocale(Locale(lg));
    Get.find<Lanuage>().getupdate();
    print("Done");
    Get.back();
    showCustomSnackBar(
      message: "Lanuage Change",
    );
  }
}

class listlanuage {
  String name;
  String code;

  listlanuage({required this.name, required this.code});
}
