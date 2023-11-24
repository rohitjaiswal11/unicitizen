
class CoinModal {
  final String coinimage;
  final String coinname;
  final String coinrate;
  final String coingraph;
  final String coinwallet;

  CoinModal(
      {required this.coinimage,
      required this.coinname,
      required this.coinrate,
      required this.coingraph,
      required this.coinwallet});}

  List<CoinModal> coinItems = [
    CoinModal(
        coinimage: "assets/dashboard/myassetcard/binance.png",
        coinname: "Binance",
        coingraph: "assets/dashboard/myassetcard/graph.png",
        coinrate: "USD 125,56,26",
        coinwallet: "\$125.46"),
    CoinModal(
        coinimage: "assets/coins/algorand.png",
        coinname: "Etherium",
        coingraph: "assets/dashboard/myassetcard/graph.png",
        coinrate: "USD 125,56,26",
        coinwallet: "\$125.46"),
    CoinModal(
        coinimage:"assets/coins/btc.png",
        coinname: "Bitcoin",
        coingraph: "assets/dashboard/myassetcard/graph.png",
        coinrate: "USD 125,56,26",
        coinwallet: "\$125.46"),
    CoinModal(
        coinimage: "assets/coins/tether.png",
        coinname: "Tether",
        coingraph: "assets/dashboard/myassetcard/graph.png",
        coinrate: "USD 125,56,26",
        coinwallet: "\$125.46"),
  ];

