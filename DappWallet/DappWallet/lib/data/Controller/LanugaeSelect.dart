import 'package:dappwallet/utils/export.dart';
import 'package:get_storage/get_storage.dart';

class Lanuage extends GetxController implements GetxService {
  //Add Custom Token
  static String addToken = 'Add Token'.tr;
  static String paste = 'Paste'.tr;
  static String save = 'Save'.tr;

  /// Bottom Bar
  static String wallet = 'Wallet'.tr;
  static String browser = 'Browser'.tr;
  static String settings = 'Setting'.tr;

  //Send and recicee and dashbaord
  static String send = 'Send'.tr;
  static String receive = 'Receive'.tr;
  static String buy = 'Buy'.tr;
  static String swap = 'Swap'.tr;
  static String History = 'History'.tr;
  static String yourToken = 'Your Token'.tr;
  static String yourbalance = 'Your Balance'.tr;
  static String hi = 'Hi'.tr;
  static String welcome = 'Welcome'.tr;

  //Send And Rrcive
  static String EstimateFee = "Estimated Transaction Fee".tr;
  static String Continue = "Continue".tr;
  static String SelectCryptocurrency = "Select Cryptocurrency".tr;
  static String address = "Address".tr;
  static String amount = "Amount".tr;
  static String Optional = "Optional".tr;
  static String Search = "Search".tr;
  static String select = "Select".tr;
  static String coiin = "Coin".tr;
  static String copy = "Copy".tr;
  static String share = "Share".tr;
  static String set = "Set".tr;

  //Setting page
  static String darkmode = "Darkmode".tr;
  static String Security = "Security".tr;
  static String Currency = "Currency".tr;
  static String Country = "Country".tr;
  static String Pricealerts = "Price Alerts".tr;
  static String Support = "Support".tr;
  static String About = "About".tr;
  static String JoinCommunity = "Join Community".tr;
  static String Facebook = "Facebook".tr;
  static String Instagram = "Instagram".tr;
  static String YouTube = "YouTube".tr;
  static String Passcode = "Passcode".tr;
  static String AutoLock = "AutoLock".tr;
  static String LockMethod = "LockMethod".tr;
  static String ChangePassword = "Change Password".tr;
  static String Askauthenticationfor = "Ask authentication for".tr;
  static String TransactionSigning = "Transaction Signing".tr;
  static String Lanuageselect = "Lanuage".tr;
  static String Addtoken = "Add Token".tr;
  static String name = "Name".tr;
  static String symbol = "Symbol".tr;
  static String Decimal = "Decimal".tr;
  static String ShowSeed = "Show Seed Pharse".tr;
  static String Showprivate = "Show Private Key".tr;

  getupdate() {
    //Add Custom Token
    Lanuage.addToken = 'Add Token'.tr;
    Lanuage.paste = 'Paste'.tr;
    Lanuage.save = 'Save'.tr;

    Lanuage.wallet = 'Wallet'.tr;
    Lanuage.browser = 'Browser'.tr;
    Lanuage.settings = 'Setting'.tr;

    Lanuage.send = 'Send'.tr;
    Lanuage.receive = 'Receive'.tr;
    Lanuage.buy = 'Buy'.tr;
    Lanuage.swap = 'Swap'.tr;
    Lanuage.History = 'History'.tr;
    Lanuage.yourToken = 'Your Token'.tr;
    Lanuage.yourbalance = 'Your Balance'.tr;
    Lanuage.hi = 'Hi'.tr;
    Lanuage.welcome = 'Welcome'.tr;

    Lanuage.EstimateFee = "Estimated Transaction Fee".tr;
    Lanuage.Continue = "Continue".tr;
    Lanuage.SelectCryptocurrency = "Select Cryptocurrency".tr;
    Lanuage.address = "Address".tr;
    Lanuage.amount = "Amount".tr;
    Lanuage.Optional = "Optional".tr;
    Lanuage.Search = "Search".tr;
    Lanuage.select = "Select".tr;
    Lanuage.coiin = "Coin".tr;
    Lanuage.copy = "Copy".tr;
    Lanuage.share = "Share".tr;
    Lanuage.set = "Set".tr;

    Lanuage.darkmode = "Darkmode".tr;
    Lanuage.Security = "Security".tr;
    Lanuage.Currency = "Currency".tr;
    Lanuage.Country = "Country".tr;
    Lanuage.Pricealerts = "Price Alerts".tr;
    Lanuage.Support = "Support".tr;
    Lanuage.About = "About".tr;
    Lanuage.JoinCommunity = "Join Community".tr;
    Lanuage.Facebook = "Facebook".tr;
    Lanuage.Instagram = "Instagram".tr;
    Lanuage.YouTube = "YouTube".tr;
    Lanuage.Passcode = "Passcode".tr;
    Lanuage.AutoLock = "AutoLock".tr;
    Lanuage.LockMethod = "LockMethod".tr;
    Lanuage.ChangePassword = "Change Password".tr;
    Lanuage.Askauthenticationfor = "Ask authentication for".tr;
    Lanuage.TransactionSigning = "Transaction Signing".tr;
    Lanuage.Lanuageselect = "Lanuage".tr;
    Lanuage.Addtoken = "Add Token".tr;
    Lanuage.name = "Name".tr;
    Lanuage.symbol = "Symbol".tr;
    Lanuage.Decimal = "Decimal".tr;
    Lanuage.ShowSeed = "Show Seed Pharse".tr;
    Lanuage.Showprivate = "Show Private Key".tr;

    update();
    print("DOne 1");
  }

  changelanuage() async {
    String lg =
        await SharedPreferenceClass.GetSharedData(AppContant.lanuage) ?? "eu";
    var locale = Locale(lg);
    final box = GetStorage();
    box.write('language', locale);
    Get.updateLocale(Locale(lg));
    getupdate();
  }
}

// abstract class AppTranslation {
//   static Map<String, Map<String, String>> translationsKeys = {
//     "en": enUS,
//     "bn": bn,
//     "pu": pu,
//     "hi": hi,
//   };
// }

final Map<String, String> enUS = {
  'Paste': "Paste",
  "Save": "Save",
  "Wallet": "Wallet",
  "Swap": "Swap",
  "Browser": "Browser",
  "Setting": "Setting",
  "Buy": "Buy",
  "About": "About",
  "Version": "Version",
  "Add Token": "Add Token",
  "Send": "Send",
  "Receive": "Receive",
  "Your Token": "Your Token",
  "Amount": "Amount",
  "History": "History",
  "To": "To",
  "From": "From",
  "Next": "Next",
  "APPROVE": "APPROVE",
  "REJECT": "REJECT",
  "Error": "Error",
  "Show Secret Phrase": "Show Secret Phrase",
  "Welcome": "Welcome",
  "Hi": "Hi",
  "Your Balance": "Your Balance",
  "Import Wallet": "Import Wallet",
  "Phrase": "Phrase",
  "Private Key": "Private Key",
  "Languages": "Languages",
  "Choose language": "Choose language",
  "Enter Passcode": "Enter Passcode",
  "Price": "Price",
  "Estimated Transaction Fee": "Estimated Transaction Fee",
  "Continue": "Continue",
  "Select Cryptocurrency": "Select Cryptocurrency",
  "Address": "Address",
  "Optional": "Optional",
  "Search": "Search",
  "Select": "Select",
  "Coin": "Coin",
  "Copy": "Copy",
  "Share": "Share",
  "Set": "Set",
  "Darkmode": "Dark Mode",
  "Security": "Security",
  "Currency": "Currency",
  "Country": "Country",
  "Price Alerts": "Price Alerts",
  "Support": "Support",
  "Join Community": "Join Community",
  "Facebook": "Facebook",
  "Instagram": "Instagram",
  "YouTube": "YouTube",
  "Passcode": "Passcode",
  "AutoLock": "Auto-Lock",
  "LockMethod": "Lock-Method",
  "ChangePassword": "Change Password",
  "Ask authentication for": "Ask authentication for",
  "Transaction Signing": "Transaction Signing",
  "Lanuage": "Lanuage",
  "Add Token": "AddToken",
  "Name": "Name",
  "Decimal": "Decimal",
  "Symbol": "Symbol",
  "Show Seed Pharse": "Show Seed Pharse",
  "Show Private Key": "Show Private Key",
};

final Map<String, String> bn = {
  'greeting': 'হ্যালো, আপনি কেমন আছেন?',
  'day': "সন্ত্রস্ত দিন..."
};
final Map<String, String> hi = {
  "Paste": "पेस्ट",
  "Save": "सेव करें",
  "Wallet": "वॉलेट",
  "Swap": "स्वैप",
  "Browser": "ब्राउज़र",
  "Setting": "सेटिंग",
  "Buy": "खरीदें",
  "About": "बारे में",
  "Version": "संस्करण",
  "Add Token": "टोकन जोड़ें",
  "Send": "भेजें",
  "Receive": "प्राप्त करें",
  "Your Token": "आपका टोकन",
  "Amount": "राशि",
  "To": "को",
  "From": "से",
  "Next": "आगामी",
  "APPROVE": "मंजूरी",
  "REJECT": "अस्वीकार",
  "Error": "त्रुटि",
  "Show Secret Phrase": "रहस्यमय वाक्य दिखाएं",
  "Welcome": "स्वागत है",
  "Hi": "नमस्ते",
  "Your Balance": "आपका शेष राशि",
  "Import Wallet": "वॉलेट आयात करें",
  "Phrase": "वाक्य",
  "Private Key": "निजी कुंजी",
  "Languages": "भाषाएँ",
  "Choose language": "भाषा चुनें",
  "Enter Passcode": "पासकोड दर्ज करें",
  "Price": "मूल्य",
  "Estimated Transaction Fee": "अनुमानित लेन-देन शुल्क",
  "Continue": "जारी रखें",
  "Select Cryptocurrency": "क्रिप्टोकरेंसी चुनें",
  "Address": "पता",
  "Optional": "वैकल्पिक",
  "Search": "खोजें",
  "Select": "चुनें",
  "Coin": "सिक्का",
  "Copy": "कॉपी",
  "Share": "साझा करें",
  "Set": "सेट करें",
  "Darkmode": "डार्क मोड",
  "Security": "सुरक्षा",
  "Currency": "मुद्रा",
  "Country": "देश",
  "Price Alerts": "मूल्य अलर्ट्स",
  "Support": "समर्थन",
  "Join Community": "समुदाय में शामिल हों",
  "Facebook": "फेसबुक",
  "Instagram": "इंस्टाग्राम",
  "YouTube": "यूट्यूब",
  "Passcode": "पासकोड",
  "AutoLock": "स्वत: लॉक",
  "LockMethod": "लॉक-विधि",
  "ChangePassword": "पासवर्ड बदलें",
  "Ask authentication for": "के लिए प्रमाणीकरण का अनुरोध करें",
  "Transaction Signing": "लेन-देन साइनिंग",
  "Lanuage": "भाषा",
  "Add Token": "टोकन जोड़ें",
  "Name": "नाम",
  "Decimal": "दशमलव",
  "Symbol": "प्रतीक",
  "Show Seed Pharse": "बीज चरण दिखाएँ",
  "Show Private Key": "निजी कुंजी दिखाएँ",
  "History": "इतिहास",
};

final Map<String, String> pu = {
  "Paste": "ਚੇਪੋ",
  "Save": "ਸੇਵ ਕਰੋ",
  "Wallet": "ਵਾਲਟ",
  "Swap": "ਬਦਲੋ",
  "Browser": "ਬਰਾਊਜ਼ਰ",
  "Setting": "ਸੈਟਿੰਗ",
  "Buy": "ਖਰੀਦੋ",
  "About": "ਬਾਰੇ ਵਿੱਚ",
  "Version": "ਸੰਸਕਰਣ",
  "Add Token": "ਟੋਕਨ ਸ਼ਾਮਲ ਕਰੋ",
  "Send": "ਭੇਜੋ",
  "Receive": "ਪ੍ਰਾਪਤ ਕਰੋ",
  "History": "ਇਤਿਹਾਸ",
  "Your Token": "ਤੁਹਾਡਾ ਟੋਕਨ",
  "Amount": "ਰਕਮ",
  "To": "ਤੇ",
  "From": "ਤੋਂ",
  "Next": "ਅਗਲਾ",
  "APPROVE": "ਮਨਜ਼ੂਰ ਕਰੋ",
  "REJECT": "ਅਸਵੀਕਾਰ ਕਰੋ",
  "Error": "ਗਲਤੀ",
  "Show Secret Phrase": "ਰਾਜ਼ੀ ਵਾਕ ਦਿਖਾਓ",
  "Welcome": "ਜੀ ਆਇਆਂ ਨੂੰ",
  "Hi": "ਹੈਲੋ",
  "Your Balance": "ਤੁਹਾਡਾ ਬਕਾਇਆ",
  "Import Wallet": "ਵਾਲਟ ਆਯਾਤ ਕਰੋ",
  "Phrase": "ਵਾਕ",
  "Private Key": "ਨਿੱਜੀ ਕੁੰਜੀ",
  "Languages": "ਭਾਸ਼ਾਵਾਂ",
  "Choose language": "ਭਾਸ਼ਾ ਚੁਣੋ",
  "Enter Passcode": "ਪਾਸਕੋਡ ਦਾਖ਼ਲ ਕਰੋ",
  "Price": "ਮੁਲਾਜ਼ਮ",
  "Estimated Transaction Fee": "ਅਨੁਮਾਨਿਤ ਲੇਣ-ਦੇਣ ਫੀਸ",
  "Continue": "ਜਾਰੀ ਰੱਖੋ",
  "Select Cryptocurrency": "ਕ੍ਰਿਪਟੋਕਰੰਸੀ ਚੁਣੋ",
  "Address": "ਪਤਾ",
  "Optional": "ਵੈਕਲਪਿਕ",
  "Search": "ਖੋਜ",
  "Select": "ਚੁਣੋ",
  "Coin": "ਸਿੱਕਾ",
  "Copy": "ਕਾਪੀ",
  "Share": "ਸਾਂਝਾ ਕਰੋ",
  "Set": "ਸੈੱਟ ਕਰੋ",
  "Darkmode": "ਡਾਰਕ ਮੋਡ",
  "Security": "ਸੁਰੱਖਿਆ",
  "Currency": "ਮੁਦਰਾ",
  "Country": "ਦੇਸ਼",
  "Price Alerts": "ਮੁਲਾਜ਼ਮ ਚੇਤਾਵਨੀ",
  "Support": "ਸਹਿਯੋਗ",
  "Join Community": "ਕਮਿਊਨਿਟੀ ਵਿੱਚ ਸ਼ਾਮਿਲ ਹੋਵੋ",
  "Facebook": "ਫੇਸਬੁੱਕ",
  "Instagram": "ਇੰਸਟਾਗਰਾਮ",
  "YouTube": "ਯੂਟਿਊਬ",
  "Passcode": "ਪਾਸਕੋਡ",
  "AutoLock": "ਆਟੋ-ਲਾਕ",
  "LockMethod": "ਲਾਕ-ਮੈਥਡ",
  "ChangePassword": "ਪਾਸਵਰਡ ਬਦਲੋ",
  "Ask authentication for": "ਦੇ ਲਈ ਪ੍ਰਮਾਣੀਕਰਣ ਪੁੱਛੋ",
  "Transaction Signing": "ਲੇਣ-ਦੇਣ ਦੀ ਸਾਇਨਿੰਗ",
  "Lanuage": "ਭਾਸ਼ਾ",
  "Add Token": "ਟੋਕਨ ਸ਼ਾਮਲ ਕਰੋ",
  "Name": "ਨਾਮ",
  "Decimal": "ਦਸ਼ਮਲਵ",
  "Symbol": "ਚਿੰਨ੍ਹ",
  "Show Seed Pharse": "ਬੀਜ ਵਾਕਾਂਸ਼ ਦਿਖਾਓ",
  "Show Private Key": "ਨਿੱਜੀ ਕੁੰਜੀ ਦਿਖਾਓ",
};
