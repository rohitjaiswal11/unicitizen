import 'package:dappwallet/utils/export.dart';

import '../../utils/Json/Country.dart';

class Country extends StatefulWidget {
  const Country({super.key});

  @override
  State<Country> createState() => _CountryState();
}

class _CountryState extends State<Country> {
  List<Countrys> Countrydata = [];
  int _select = -1;

  @override
  void initState() {
    Countrydata.addAll(CountrysList);
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppbarSecond(title: Lanuage.Country, context: context, back: true),
      body: Countrydata.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: Countrydata.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RadioListTile(
                    title: Text(Countrydata[index].CountrysName.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                    subtitle: Text(Countrydata[index].CountrysCode.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                fontSize: 13, fontWeight: FontWeight.w400)),
                    value: index,
                    activeColor: Theme.of(context).primaryColor,
                    selectedTileColor: Theme.of(context).primaryColor,
                    tileColor: Theme.of(context).cardColor,
                    groupValue: _select,
                    onChanged: (value) {
                      setState(() {
                        _select = index;
                      });
                      print(_select);
                    },
                  ),
                );
              }),
    );
  }
}
