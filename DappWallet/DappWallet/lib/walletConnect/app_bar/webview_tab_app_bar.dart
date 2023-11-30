// import 'package:cached_network_image/cached_network_image.dart';
// import 'dart:io';

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import '../app_bar/url_info_popup.dart';
import '../custom_image.dart';
// import '../main.dart';
import '../models/browser_model.dart';
import '../models/favorite_model.dart';
// import '../models/web_archive_model.dart';
import '../models/webview_model.dart';
// import '../pages/developers/main.dart';
// import '../pages/settings/main.dart';
import '../tab_popup_menu_actions.dart';
import '../util.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

// import '../animated_flutter_browser_logo.dart';
import '../custom_popup_menu_item.dart';
import '../popup_menu_actions.dart';
import '../webview_tab.dart';

class WebViewTabAppBar extends StatefulWidget {
  // final void Function()? showFindOnPage;

  const WebViewTabAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<WebViewTabAppBar> createState() => _WebViewTabAppBarState();
}

class _WebViewTabAppBarState extends State<WebViewTabAppBar>
    with SingleTickerProviderStateMixin {
  TextEditingController? _searchController = TextEditingController();
  FocusNode? _focusNode;

  GlobalKey tabInkWellKey = GlobalKey();

  Duration customPopupDialogTransitionDuration =
      const Duration(milliseconds: 300);
  // CustomPopupDialogPageRoute? route;

  OutlineInputBorder outlineBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    borderRadius: BorderRadius.all(
      Radius.circular(50.0),
    ),
  );

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode?.addListener(() async {
      if (_focusNode != null &&
          !_focusNode!.hasFocus &&
          _searchController != null &&
          _searchController!.text.isEmpty) {
        var browserModel = Provider.of<BrowserModel>(context, listen: true);
        var webViewModel = browserModel.getCurrentTab()?.webViewModel;
        var webViewController = webViewModel?.webViewController;
        _searchController!.text =
            (await webViewController?.getUrl())?.toString() ?? "";
      }
    });
  }

  @override
  void dispose() {
    _focusNode?.dispose();
    _focusNode = null;
    _searchController?.dispose();
    _searchController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<WebViewModel, WebUri?>(
        selector: (context, webViewModel) => webViewModel.url,
        builder: (context, url, child) {
          if (url == null) {
            _searchController?.text = "";
          }
          if (url != null && _focusNode != null && !_focusNode!.hasFocus) {
            _searchController?.text = url.toString();
          }

          Widget? leading = _buildAppBarHomePageWidget();

          return Selector<WebViewModel, bool>(
              selector: (context, webViewModel) => webViewModel.isIncognitoMode,
              builder: (context, isIncognitoMode, child) {
                return leading != null
                    ? AppBar(
                        backgroundColor: isIncognitoMode
                            ? Colors.black87
                            : Colors.blue,
                        leading: _buildAppBarHomePageWidget(),
                        titleSpacing: 0.0,
                        title: _buildSearchTextField(),
                        actions: _buildActionsMenu(),
                      )
                    : AppBar(
                        backgroundColor: isIncognitoMode
                            ? Colors.black87
                            : Colors.blue,
                        titleSpacing: 10.0,
                        title: _buildSearchTextField(),
                        actions: _buildActionsMenu(),
                      );
              });
        });
  }

  Widget? _buildAppBarHomePageWidget() {
    var browserModel = Provider.of<BrowserModel>(context, listen: true);
    var settings = browserModel.getSettings();

    var webViewModel = Provider.of<WebViewModel>(context, listen: true);
    var webViewController = webViewModel.webViewController;

    if (!settings.homePageEnabled) {
      return null;
    }

    return IconButton(
      icon: const Icon(Icons.home),
      onPressed: () {
        if (webViewController != null) {
          var url =
              settings.homePageEnabled && settings.customUrlHomePage.isNotEmpty
                  ? WebUri(settings.customUrlHomePage)
                  : WebUri(settings.searchEngine.url);
          webViewController.loadUrl(urlRequest: URLRequest(url: url));
        } else {
          addNewTab();
        }
      },
    );
  }

  Widget _buildSearchTextField() {
    var browserModel = Provider.of<BrowserModel>(context, listen: true);
    var settings = browserModel.getSettings();

    var webViewModel = Provider.of<WebViewModel>(context, listen: true);
    var webViewController = webViewModel.webViewController;

    return SizedBox(
      height: 40.0,
      child: Stack(
        children: <Widget>[
          TextField(
            onSubmitted: (value) {
              var url = WebUri(value.trim());
              if (!url.scheme.startsWith("http") &&
                  !Util.isLocalizedContent(url)) {
                url = WebUri(settings.searchEngine.searchUrl + value);
              }

              if (webViewController != null) {
                webViewController.loadUrl(urlRequest: URLRequest(url: url));
              } else {
                addNewTab(url: url);
                webViewModel.url = url;
              }
            },
            keyboardType: TextInputType.url,
            focusNode: _focusNode,
            autofocus: false,
            controller: _searchController,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(
                    left: 45.0, top: 10.0, right: 10.0, bottom: 10.0),
                filled: true,
                fillColor: Colors.white,
                border: outlineBorder,
                focusedBorder: outlineBorder,
                enabledBorder: outlineBorder,
                hintText: "Search for or type a web address",
                hintStyle:
                    const TextStyle(color: Colors.black54, fontSize: 16.0),
                suffixIcon: _searchController!.text.isEmpty
                    ? (_focusNode != null && _focusNode!.hasFocus)
                        ? TextButton(
                            onPressed: () {
                              _focusNode?.unfocus();
                            },
                            child: Text(
                              'Close',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ))
                        : null
                    : IconButton(
                        onPressed: () {
                          _searchController!.clear();
                          _focusNode?.requestFocus();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey,
                        ))),
            style: const TextStyle(color: Colors.black, fontSize: 16.0),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActionsMenu() {
    var browserModel = Provider.of<BrowserModel>(context, listen: true);
    var settings = browserModel.getSettings();

    return <Widget>[
      settings.homePageEnabled
          ? const SizedBox(
              width: 10.0,
            )
          : Container(),
      InkWell(
        key: tabInkWellKey,
        onLongPress: () {
          final RenderBox? box =
              tabInkWellKey.currentContext!.findRenderObject() as RenderBox?;
          if (box == null) {
            return;
          }

          Offset position = box.localToGlobal(Offset.zero);

          showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(position.dx,
                      position.dy + box.size.height, box.size.width, 0),
                  items: TabPopupMenuActions.choices.map((tabPopupMenuAction) {
                    IconData? iconData;
                    switch (tabPopupMenuAction) {
                      case TabPopupMenuActions.CLOSE_TABS:
                        iconData = Icons.cancel;
                        break;
                      case TabPopupMenuActions.NEW_TAB:
                        iconData = Icons.add;
                        break;
                      case TabPopupMenuActions.NEW_INCOGNITO_TAB:
                        iconData = Icons.add;
                        break;
                    }

                    return PopupMenuItem<String>(
                      value: tabPopupMenuAction,
                      child: Row(children: [
                        Icon(
                          iconData,
                          color: Colors.black,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(tabPopupMenuAction),
                        )
                      ]),
                    );
                  }).toList())
              .then((value) {
            switch (value) {
              case TabPopupMenuActions.CLOSE_TABS:
                browserModel.closeAllTabs();
                break;
              case TabPopupMenuActions.NEW_TAB:
                addNewTab();
                break;
              case TabPopupMenuActions.NEW_INCOGNITO_TAB:
                addNewIncognitoTab();
                break;
            }
          });
        },
        onTap: () async {
          if (browserModel.webViewTabs.isNotEmpty) {
            var webViewModel = browserModel.getCurrentTab()?.webViewModel;
            var webViewController = webViewModel?.webViewController;
            var widgetsBingind = WidgetsBinding.instance;

            if (widgetsBingind.window.viewInsets.bottom > 0.0) {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              if (FocusManager.instance.primaryFocus != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
              if (webViewController != null) {
                await webViewController.evaluateJavascript(
                    source: "document.activeElement.blur();");
              }
              await Future.delayed(const Duration(milliseconds: 300));
            }

            if (webViewModel != null && webViewController != null) {
              webViewModel.screenshot = await webViewController
                  .takeScreenshot(
                      screenshotConfiguration: ScreenshotConfiguration(
                          compressFormat: CompressFormat.JPEG, quality: 20))
                  .timeout(
                    const Duration(milliseconds: 200),
                    onTimeout: () => null,
                  );
            }

            browserModel.showTabScroller = true;
          }else{
             addNewTab();
          }
        },
        child: Container(
          margin: const EdgeInsets.only(
              left: 10.0, top: 15.0, right: 10.0, bottom: 15.0),
          decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.white),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5.0)),
          constraints: const BoxConstraints(minWidth: 25.0),
          child: Center(
              child: Text(
            browserModel.webViewTabs.length.toString(),
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,
                fontSize: 14.0),
          )),
        ),
      ),
      PopupMenuButton<String>(
        onSelected: _popupMenuChoiceAction,
        itemBuilder: (popupMenuContext) {
          var items = [
            CustomPopupMenuItem<String>(
              enabled: true,
              isIconButtonRow: true,
              child: StatefulBuilder(
                builder: (statefulContext, setState) {
                  var browserModel =
                      Provider.of<BrowserModel>(statefulContext, listen: true);
                  var webViewModel =
                      Provider.of<WebViewModel>(statefulContext, listen: true);
                  var webViewController = webViewModel.webViewController;

                  var isFavorite = false;
                  FavoriteModel? favorite;

                  if (webViewModel.url != null &&
                      webViewModel.url!.toString().isNotEmpty) {
                    favorite = FavoriteModel(
                        url: webViewModel.url,
                        title: webViewModel.title ?? "",
                        favicon: webViewModel.favicon);
                    isFavorite = browserModel.containsFavorite(favorite);
                  }

                  var children = <Widget>[];

                  if (Util.isIOS()) {
                    children.add(
                      SizedBox(
                          width: 35.0,
                          child: IconButton(
                              padding: const EdgeInsets.all(0.0),
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                webViewController?.goBack();
                                Navigator.pop(popupMenuContext);
                              })),
                    );
                  }

                  children.addAll([
                    SizedBox(
                        width: 35.0,
                        child: IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              webViewController?.goForward();
                              Navigator.pop(popupMenuContext);
                            })),
                    SizedBox(
                        width: 35.0,
                        child: IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: Icon(
                              isFavorite ? Icons.star : Icons.star_border,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                if (favorite != null) {
                                  if (!browserModel
                                      .containsFavorite(favorite)) {
                                    browserModel.addFavorite(favorite);
                                  } else if (browserModel
                                      .containsFavorite(favorite)) {
                                    browserModel.removeFavorite(favorite);
                                  }
                                }
                              });
                            })),
                    SizedBox(
                        width: 35.0,
                        child: IconButton(
                            padding: const EdgeInsets.all(0.0),
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              webViewController?.reload();
                              Navigator.pop(popupMenuContext);
                            })),
                  ]);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: children,
                  );
                },
              ),
            )
          ];

          items.addAll(PopupMenuActions.choices.map((choice) {
            switch (choice) {
              case PopupMenuActions.NEW_TAB:
                return CustomPopupMenuItem<String>(
                  enabled: true,
                  value: choice,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(choice),
                        const Icon(
                          Icons.add,
                          color: Colors.black,
                        )
                      ]),
                );
              case PopupMenuActions.NEW_INCOGNITO_TAB:
                return CustomPopupMenuItem<String>(
                  enabled: true,
                  value: choice,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(choice),
                        const Icon(
                          Icons.add,
                          color: Colors.black,
                        )
                      ]),
                );
              case PopupMenuActions.FAVORITES:
                return CustomPopupMenuItem<String>(
                  enabled: true,
                  value: choice,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(choice),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        )
                      ]),
                );

              case PopupMenuActions.HISTORY:
                return CustomPopupMenuItem<String>(
                  enabled: browserModel.getCurrentTab() != null,
                  value: choice,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(choice),
                        const Icon(
                          Icons.history,
                          color: Colors.black,
                        )
                      ]),
                );
              case PopupMenuActions.CACHE:
                return CustomPopupMenuItem<String>(
                  enabled: browserModel.getCurrentTab() != null,
                  value: choice,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(choice),
                        const Icon(
                          Icons.cached,
                          color: Colors.black,
                        )
                      ]),
                );
              default:
                return CustomPopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
            }
          }).toList());

          return items;
        },
      )
    ];
  }

  void _popupMenuChoiceAction(String choice) async {
    // var currentWebViewModel = Provider.of<WebViewModel>(context, listen: false);

    switch (choice) {
      case PopupMenuActions.NEW_TAB:
        addNewTab();
        break;
      case PopupMenuActions.NEW_INCOGNITO_TAB:
        addNewIncognitoTab();
        break;
      case PopupMenuActions.FAVORITES:
        showFavorites();
        break;
      case PopupMenuActions.HISTORY:
        showHistory();
        break;
      case PopupMenuActions.CACHE:
        clearCache();
        break;
    }
  }

  void addNewTab({WebUri? url}) {
    print('herer adding');
    var browserModel = Provider.of<BrowserModel>(context, listen: false);
    if (browserModel.webViewTabs.length >= 15) {
     // ToastMessage.showToast(context, 'Max Tab Limit Reached', Colors.red);
      return;
    } else {
      var settings = browserModel.getSettings();

      url ??= settings.homePageEnabled && settings.customUrlHomePage.isNotEmpty
          ? WebUri(settings.customUrlHomePage)
          : WebUri(settings.searchEngine.url);

      browserModel.addTab(WebViewTab(
        key: GlobalKey(),
        webViewModel: WebViewModel(url: url),
      ));
    }
  }

  void clearCache() async {
    try {
      var browserModel = Provider.of<BrowserModel>(context, listen: false);
      if (browserModel.webViewTabs.isNotEmpty) {
        var webViewModel = browserModel.getCurrentTab()?.webViewModel;
        var webViewController = webViewModel?.webViewController;

        if (webViewModel != null && webViewController != null) {
          await webViewController.clearCache();
         // ToastMessage.showToast(context, 'Cache Cleared', Colors.green);
        }
      }
    } catch (e) {
      log('Error --< $e');
     // ToastMessage.showToast(context, 'Unable to clear cache', Colors.red);
    }
  }

  void addNewIncognitoTab({WebUri? url}) {
    var browserModel = Provider.of<BrowserModel>(context, listen: false);
    if (browserModel.webViewTabs.length >= 15) {
     // ToastMessage.showToast(context, 'Max Tab Limit Reached', Colors.red);
      return;
    } else {
      var settings = browserModel.getSettings();

      url ??= settings.homePageEnabled && settings.customUrlHomePage.isNotEmpty
          ? WebUri(settings.customUrlHomePage)
          : WebUri(settings.searchEngine.url);

      browserModel.addTab(WebViewTab(
        key: GlobalKey(),
        webViewModel: WebViewModel(url: url, isIncognitoMode: true),
      ));
    }
  }

  void showFavorites() {
    showDialog(
        context: context,
        builder: (context) {
          var browserModel = Provider.of<BrowserModel>(context, listen: true);

          return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              content: SizedBox(
                  width: double.maxFinite,
                  child: ListView(
                    children: browserModel.favorites.map((favorite) {
                      var url = favorite.url;
                      var faviconUrl = favorite.favicon != null
                          ? favorite.favicon!.url
                          : WebUri("${url?.origin ?? ""}/favicon.ico");

                      return ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            // CachedNetworkImage(
                            //   placeholder: (context, url) =>
                            //       CircularProgressIndicator(),
                            //   imageUrl: faviconUrl,
                            //   height: 30,
                            // )
                            CustomImage(
                              url: faviconUrl,
                              maxWidth: 30.0,
                              height: 30.0,
                            )
                          ],
                        ),
                        title: Text(
                            favorite.title ?? favorite.url?.toString() ?? "",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        subtitle: Text(favorite.url?.toString() ?? "",
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        isThreeLine: true,
                        onTap: () {
                          setState(() {
                            addNewTab(url: favorite.url);
                            Navigator.pop(context);
                          });
                        },
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            IconButton(
                              icon: const Icon(Icons.close, size: 20.0),
                              onPressed: () {
                                setState(() {
                                  browserModel.removeFavorite(favorite);
                                  if (browserModel.favorites.isEmpty) {
                                    Navigator.pop(context);
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  )));
        });
  }

  void showHistory() {
    showDialog(
        context: context,
        builder: (context) {
          var webViewModel = Provider.of<WebViewModel>(context, listen: true);

          return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              content: FutureBuilder(
                future:
                    webViewModel.webViewController?.getCopyBackForwardList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }

                  WebHistory history = snapshot.data as WebHistory;
                  return SizedBox(
                      width: double.maxFinite,
                      child: ListView(
                        children: history.list?.reversed.map((historyItem) {
                              var url = historyItem.url;

                              return ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    // CachedNetworkImage(
                                    //   placeholder: (context, url) =>
                                    //       CircularProgressIndicator(),
                                    //   imageUrl: (url?.origin ?? "") + "/favicon.ico",
                                    //   height: 30,
                                    // )
                                    CustomImage(
                                        url: WebUri(
                                            "${url?.origin ?? ""}/favicon.ico"),
                                        maxWidth: 30.0,
                                        height: 30.0)
                                  ],
                                ),
                                title: Text(historyItem.title ?? url.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                subtitle: Text(url?.toString() ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                                isThreeLine: true,
                                onTap: () {
                                  webViewModel.webViewController
                                      ?.goTo(historyItem: historyItem);
                                  Navigator.pop(context);
                                },
                              );
                            }).toList() ??
                            <Widget>[],
                      ));
                },
              ));
        });
  }
}
