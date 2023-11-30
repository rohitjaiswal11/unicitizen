import 'package:dappwallet/utils/export.dart';

class Currency extends StatefulWidget {
  const Currency({super.key});

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  List Currencydata = [];
  int _select = -1;

  @override
  void initState() {
    Currencydata.addAll(supportedCurrencyList);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSecond(title: "Currency", context: context, back: true),
      body: Currencydata.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: Currencydata.length,
              itemBuilder: (BuildContext context, int index) {
                if (Currencydata[index].toString().split("-").first.trim() ==
                    AppContant.selectedCurrency.toUpperCase()) {
                  _select = index;
                }

                return RadioListTile(
                  title: Text(Currencydata[index],
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w500)),
                  value: index,
                  activeColor: Theme.of(context).primaryColor,
                  selectedTileColor: Theme.of(context).primaryColor,
                  tileColor: Theme.of(context).scaffoldBackgroundColor,
                  groupValue: _select,
                  onChanged: (value) {
                    setState(() {
                      AppContant.selectedCurrency = Currencydata[index]
                          .toString()
                          .split("-")
                          .first
                          .trim()
                          .toLowerCase();
                      _select = index;
                    });
                    Get.back();
                    print(_select);
                  },
                );
              }),
    );
  }
}
