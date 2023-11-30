import 'dart:async';

// import 'package:cached_network_image/cached_network_image.dart';

import 'package:dappwallet/data/base/Contant.dart';
import 'package:dappwallet/data/base/perferance.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import '../wallet_connect_v2/dependencies/bottom_sheet/bottom_sheet_listener.dart';
import '../wallet_connect_v2/dependencies/bottom_sheet/bottom_sheet_service.dart';
import '../wallet_connect_v2/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import '../wallet_connect_v2/dependencies/chains/evm_service.dart';
import '../wallet_connect_v2/dependencies/chains/i_chain.dart';
import '../wallet_connect_v2/dependencies/i_web3wallet_service.dart';
import '../wallet_connect_v2/dependencies/key_service/i_key_service.dart';
import '../wallet_connect_v2/dependencies/key_service/key_service.dart';
import '../wallet_connect_v2/dependencies/web3wallet_service.dart';
import 'app_bar/browser_app_bar.dart';
import 'app_bar/tab_viewer_app_bar.dart';
import 'custom_image.dart';
import 'empty_tab.dart';
import 'models/browser_model.dart';
import 'models/webview_model.dart';
import 'tab_viewer.dart';
import 'webview_tab.dart';

class Browser extends StatefulWidget {
  const Browser({Key? key}) : super(key: key);

  @override
  State<Browser> createState() => _BrowserState();
}

class _BrowserState extends State<Browser> with SingleTickerProviderStateMixin {
  var _isRestored = false;
  late Web3Wallet web3Wallet;

  bool _initializing = true;
  Future<void> initialize() async {
    KeyService().keys[0].privateKey =
        await SharedPreferenceClass.GetSharedData(AppContant.WalletprivateKey);
    KeyService().keys[0].publicKey =
        await SharedPreferenceClass.GetSharedData(AppContant.Walletaddres);
    pvtkey =
        await SharedPreferenceClass.GetSharedData(AppContant.WalletprivateKey);
    walletadddres =
        await SharedPreferenceClass.GetSharedData(AppContant.Walletaddres);
    KeyService().changeKeys();
    setState(() {});
    GetIt.I.registerSingleton<IBottomSheetService>(BottomSheetService());

    GetIt.I.registerSingleton<IKeyService>(KeyService());

    final IWeb3WalletService web3WalletService = Web3WalletService();
    web3WalletService.create();
    GetIt.I.registerSingleton<IWeb3WalletService>(web3WalletService);
    for (final cId in EVMChainId.values) {
      GetIt.I.registerSingleton<IChain>(
        EVMService(reference: cId),
        instanceName: cId.chain(),
      );
    }

    await web3WalletService.init();

    setState(() {
      _initializing = false;
    });
    web3Wallet = GetIt.I<IWeb3WalletService>().getWeb3Wallet();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    GetIt.I.unregister<IKeyService>();
    GetIt.I.unregister<IBottomSheetService>();
    GetIt.I.unregister<IWeb3WalletService>();

    for (final cId in EVMChainId.values) {
      GetIt.I.unregister<IChain>(instanceName: cId.chain());
    }

    // ConstantClass.cacheCleared = false;
    super.dispose();
  }

  restore() async {
    var browserModel = Provider.of<BrowserModel>(context, listen: true);
    browserModel.restore();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isRestored) {
      _isRestored = true;
      restore();
    }
    // precacheImage(const AssetImage("assets/icon/icon.png"), context);
  }

  @override
  Widget build(BuildContext context) {
    return _buildBrowser();
  }

  Widget _buildBrowser() {
    var currentWebViewModel = Provider.of<WebViewModel>(context, listen: true);
    var browserModel = Provider.of<BrowserModel>(context, listen: true);

    browserModel.addListener(() {
      browserModel.save();
    });
    currentWebViewModel.addListener(() {
      browserModel.save();
    });

    var canShowTabScroller =
        browserModel.showTabScroller && browserModel.webViewTabs.isNotEmpty;

    return IndexedStack(
      index: canShowTabScroller ? 1 : 0,
      children: [
        _buildWebViewTabs(),
        //canShowTabScroller ? _buildWebViewTabsViewer() : Container()
      ],
    );
  }

  Widget _buildWebViewTabs() {
    return WillPopScope(
        onWillPop: () async {
          var browserModel = Provider.of<BrowserModel>(context, listen: false);
          var webViewModel = browserModel.getCurrentTab()?.webViewModel;
          var webViewController = webViewModel?.webViewController;

          if (webViewController != null) {
            if (await webViewController.canGoBack()) {
              webViewController.goBack();
              return false;
            }
            print('here returning true');
            if (browserModel.webViewTabs.length > 1) {
              if (webViewModel != null && webViewModel.tabIndex != null) {
                browserModel.closeTab(webViewModel.tabIndex!);
                return false;
              }
            }
            return true;
          }

          if (webViewModel != null && webViewModel.tabIndex != null) {
            if (mounted)
              setState(() {
                browserModel.closeTab(webViewModel.tabIndex!);
              });
            if (mounted) {
              FocusScope.of(context).unfocus();
            }
            return false;
          }

          return browserModel.webViewTabs.isEmpty;
        },
        child: Listener(
          onPointerUp: (_) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              // currentFocus.focusedChild!.unfocus();
            }
          },
          child: Scaffold(
              //  appBar: const BrowserAppBar(),
              body: _initializing
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : BottomSheetListener(child: _buildWebViewTabsContent())),
        ));
  }

  Widget _buildWebViewTabsContent() {
    var browserModel = Provider.of<BrowserModel>(context, listen: true);

    // if (browserModel.webViewTabs.isEmpty) {
    //   return const EmptyTab();
    // }

    var stackChildren = <Widget>[
      IndexedStack(
        index: browserModel.getCurrentTabIndex(),
        children: browserModel.webViewTabs.map((webViewTab) {
          var isCurrentTab = webViewTab.webViewModel.tabIndex ==
              browserModel.getCurrentTabIndex();

          if (isCurrentTab) {
            Future.delayed(const Duration(milliseconds: 100), () {
              webViewTabStateKey.currentState?.onShowTab();
            });
          } else {
            webViewTabStateKey.currentState?.onHideTab();
          }

          return webViewTab;
        }).toList(),
      ),
      _createProgressIndicator()
    ];

    return Stack(
      children: stackChildren,
    );
  }

  Widget _createProgressIndicator() {
    return Selector<WebViewModel, double>(
        selector: (context, webViewModel) => webViewModel.progress,
        builder: (context, progress, child) {
          if (progress >= 1.0) {
            return Container();
          }
          return PreferredSize(
              preferredSize: const Size(double.infinity, 4.0),
              child: SizedBox(
                  height: 4.0,
                  child: LinearProgressIndicator(
                    value: progress,
                  )));
        });
  }

  Widget _buildWebViewTabsViewer() {
    var browserModel = Provider.of<BrowserModel>(context, listen: true);

    return WillPopScope(
        onWillPop: () async {
          // print('here');
          browserModel.showTabScroller = false;
          return false;
        },
        child: Scaffold(
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.blue
                : Colors.white,
            //appBar: const TabViewerAppBar(),
            body: TabViewer(
              currentIndex: browserModel.getCurrentTabIndex(),
              children: browserModel.webViewTabs.map((webViewTab) {
                webViewTabStateKey.currentState?.pause();
                var screenshotData = webViewTab.webViewModel.screenshot;
                Widget screenshotImage = Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  width: double.infinity,
                  child: screenshotData != null
                      ? Image.memory(screenshotData)
                      : null,
                );

                var url = webViewTab.webViewModel.url;
                var faviconUrl = webViewTab.webViewModel.favicon != null
                    ? webViewTab.webViewModel.favicon!.url
                    : (url != null && ["http", "https"].contains(url.scheme)
                        ? Uri.parse("${url.origin}/favicon.ico")
                        : null);

                var isCurrentTab = browserModel.getCurrentTabIndex() ==
                    webViewTab.webViewModel.tabIndex;

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Material(
                      color: isCurrentTab
                          ? Colors.blue
                          : (webViewTab.webViewModel.isIncognitoMode
                              ? Colors.black
                              : Colors.white),
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CustomImage(
                                url: faviconUrl, maxWidth: 30.0, height: 30.0)
                          ],
                        ),
                        title: Text(
                            webViewTab.webViewModel.title ??
                                webViewTab.webViewModel.url?.toString() ??
                                "",
                            maxLines: 2,
                            style: TextStyle(
                              color: webViewTab.webViewModel.isIncognitoMode ||
                                      isCurrentTab
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis),
                        subtitle:
                            Text(webViewTab.webViewModel.url?.toString() ?? "",
                                style: TextStyle(
                                  color:
                                      webViewTab.webViewModel.isIncognitoMode ||
                                              isCurrentTab
                                          ? Colors.white60
                                          : Colors.black54,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 20.0,
                                color:
                                    webViewTab.webViewModel.isIncognitoMode ||
                                            isCurrentTab
                                        ? Colors.white60
                                        : Colors.black54,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (webViewTab.webViewModel.tabIndex !=
                                      null) {
                                    browserModel.closeTab(
                                        webViewTab.webViewModel.tabIndex!);
                                    if (browserModel.webViewTabs.isEmpty) {
                                      browserModel.showTabScroller = false;
                                    }
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: screenshotImage,
                    )
                  ],
                );
              }).toList(),
              onTap: (index) async {
                browserModel.showTabScroller = false;
                browserModel.showTab(index);
              },
            )));
  }
}
