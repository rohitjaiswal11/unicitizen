import 'package:flutter/material.dart';

class CustomImages {
  static Image Customimg(context, String img,  {double? scale,Color? color,double? width,double? height}) {
    return Image.asset(
      img,
      fit: BoxFit.contain,
      scale: scale,
      color: color,
      width: width,
      height: height,
    );
  }

  static Image setAssetImage(String imagePath,
      {Color? color, BoxFit? fit, double? height, double? width}) {
    return Image.asset(
      imagePath,
      fit: fit ?? BoxFit.fill,
      height: height,
      width: width,
      color: color,
    );
  }

  /// HOME ...........................................................
  // static String iconwhite = "assets/Home/iconWhite.png";
  // static String icon = "assets/Home/icon.png";
  // static String mode = 'assets/Home/mode.png';
  static String Diverse = 'assets/Register/Diverse.png';
  static String secure = 'assets/Register/secure.png';
  static String images = "assets/Register/images.png";
  static String graph = 'assets/Register/graph_screen.png';
  static String waletpro = 'assets/Register/profile_wallet.png';
  static String darkmodeprofile = 'assets/Register/dark_mode.png';
  static String security = 'assets/Register/security.png';
  static String currency = 'assets/Register/currency.png';
  static String country = 'assets/Register/country.png';
  static String pricealert = 'assets/Register/price_alert.png';
  static String support = 'assets/Register/Support.png';
  static String about = 'assets/Register/about.png';
  static String recivescanner = 'assets/Register/receive_scanner.png';




  static String pox = 'assets/Home/pox.png';
  static String logo = 'assets/Home/logo.png';
  static String nightmode = 'assets/Home/nightmode.png';
  static String profileM = 'assets/Home/profileM.png';
  static String profileG = 'assets/Home/profileG.png';
  static String handback = 'assets/Register/handback.png';
  static String firstboard = 'assets/Register/firstboard.png';
  static String secondboard = 'assets/Register/secondboard.png';
  static String thirdboard = 'assets/Register/thirdboard.png';
  static String linetabs = 'assets/Register/linetabs.png';
  static String thumbup = 'assets/Register/thumbup.png';
  static String anim = 'assets/Register/anim.mp4';
  static String idea = 'assets/Register/idea.png';
  static String eyebrow = 'assets/Home/eyebrow.png';

  static String dropdown = 'assets/Home/dropdown.png';
  static String scannericon = 'assets/Home/scanner.png';
  static String addhome = 'assets/Home/add.png';
  static String eye = 'assets/Home/eye.png';
  static String wallet = 'assets/Home/wallet.png';
  static String copy = 'assets/Home/copy.png';
  static String line = 'assets/Home/line.png';
  static String nft = 'assets/Home/nft.png';

  ///
  static String send = 'assets/Home/send.png';
  static String recieve = 'assets/Home/receive.png';
  static String myscan = 'assets/Home/myscan.png';
  static String save = 'assets/Home/save.png';
  static String share = 'assets/Home/share.png';
  static String swap = 'assets/Home/swap.png';
  static String stake = 'assets/Home/stake.png';
  static String vote = 'assets/Home/vote.png';
  static String divider = 'assets/Home/divider.png';
  static String help = 'assets/Home/help.png';
  static String bitcoin = 'assets/Home/bitcoin.png';
  static String uncollectedyield = 'assets/Home/uncollectedyield.png';
  static String verticaldivide = 'assets/Home/verticaldivide.png';
  static String eth = 'assets/Home/eth.png';
  static String chainlink = 'assets/Home/chainlink.png';

  static String filter = 'assets/Home/filter.png';
  static String plus = 'assets/Home/plus.png';
  static String warning = 'assets/Home/warning.png';


  static String bandwidth = 'assets/Home/bandwidth.png';
  static String energy = 'assets/Home/energy.png';



  ///Drawer
  static String home = "assets/Home/home.png";
  static String market = "assets/Home/market.png";
  static String discover = "assets/Home/discover.png";
  static String profile = "assets/Home/profile.png";

  /// My Wallet Page
  static String address = "assets/Wallet/address.png";
  static String advanced = "assets/Wallet/advanced.png";
  static String announce = "assets/Wallet/announce.png";
  static String backup = "assets/Wallet/backup.png";
  static String friend = "assets/Wallet/friend.png";
  static String notification = "assets/Wallet/notification.png";
  static String settings = "assets/Wallet/settings.png";
  static String transaction = "assets/Wallet/transaction.png";
  static String myWallet = "assets/Wallet/wallet.png";
  static String myWalletG = "assets/Wallet/walletG.png";
  static String abouts = "assets/Register/about.png";

  /// Wallet Details Page
  static String editText = "assets/Wallet/editText.png";
  static String exchange = "assets/Register/exchange.png";
  static String question = "assets/Wallet/question.png";
  static String key = "assets/Wallet/key.png";
  static String write = "assets/Wallet/write.png";
  static String page = "assets/Wallet/page.png";
  static String accountKey = "assets/Wallet/accountKey.png";
  static String accountApprove = "assets/Wallet/accountApprove.png";
  static String moneyRound = "assets/Wallet/moneyRound.png";
  static String link = "assets/Wallet/link.png";
  static String coldwallet = "assets/Home/coldwallet.png";
  static String screenshot = "assets/Home/screenshot.png";
  static String backgroundprivatekey = "assets/Home/background.png";
  static String backupPrivatekey = "assets/Home/backup.png";
  static String permission = "assets/Home/permission.png";
  static String stepline = "assets/Home/stepline.png";
  static String exchangeselect = "assets/Home/exchange.png";
  static String walletselect = "assets/Home/walletselect.png";
  static String snow = "assets/Home/snow.png";
  static String securitytick = "assets/Home/securitytick.png";
  static String passwordStep = "assets/Home/passwordStep.png";

  /// My Earn Page
  static String portfolio = "assets/Wallet/portfolio.png";
  static String camera = "assets/Wallet/camera.png";

  /// Add Wallet Page
  static String moneySaving = "assets/Wallet/moneySaving.png";
  static String import = "assets/Wallet/import.png";
  static String pairLedger = "assets/Wallet/pairledger.png";
  static String pairCold = "assets/Wallet/pairCold.png";
  static String watchOnly = "assets/Wallet/watchOnly.png";
  static String nexttab = "assets/Home/nexttab.png";
  static String moreoptions = "assets/Home/moreoptions.png";
  static String justlend = "assets/Home/justlend.png";
  static String tron = "assets/Home/tron.png";



  ///Earn // swap

  static String exchangeearn = "assets/Earn_swap/exchange.png";
  static String expand = "assets/Earn_swap/expand.png";
  static String ques = "assets/Earn_swap/question.png";
  static String active = "assets/Earn_swap/active.png";
  static String bannner1 = "assets/Earn_swap/bannner1.png";
  // static String chainlink = "assets/Earn_swap/chainlink.png";
  static String trx = "assets/Earn_swap/TRX.png";
  static String usdt = "assets/Earn_swap/usdt.png";
  static String swapicon = "assets/Earn_swap/swapicon.png";
  static String sunswap = "assets/Earn_swap/SUNSWAP.png";
  static String nodata = "assets/Earn_swap/nodata.png";


  /// Add New Device Page
  static String notfound = "assets/Wallet/notfound.png";



  ///discover
  static String background = "assets/Discover/background.png";
}
