import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:paynote_app/Api/BResponse.dart';
import 'package:paynote_app/Api/User.dart';
import 'package:paynote_app/ui/theme/AppColors.dart';
import 'package:paynote_app/ui/widgets/global/OverLayWidget.dart';
import 'TinkAccountLinkViewModel.dart';
import 'package:stacked/stacked.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:paynote_app/utils/SharedPref.dart';
import 'package:paynote_app/models/OverlayLoadingScreens/OverlaysForLoading.dart';


class TinkAccountLinkView extends StatelessWidget {
  InAppWebViewController webView;
  double progress = 0;
  final User user;
  final String url;

  TinkAccountLinkView({this.user,this.url});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TinkAccountLinkViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            leading: BackButton(
                color: AppColors.brandBlue
            ),
            title: Text('Secured with paynote', style: TextStyle(color: AppColors.brandBlue),),
            centerTitle: true,
            elevation: 0,
            backgroundColor: AppColors.brandWhite,
          ),
          body: Container(
              child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: model.isBusy
                    ? OverLayWidget(title: 'Fetching...',
                    description: 'we are getting things ready for you..',)
                    : InAppWebView(
                        initialUrl: model.url,
                        initialHeaders: {},
                        initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: false,
                        )),
                        onWebViewCreated: (InAppWebViewController controller) {
                          webView = controller;
                        },
                        onLoadStart:
                            (InAppWebViewController controller, String url) {
                             /* if(url.contains('rabobank.nl')){
                                _launchURL(url);

                              }*/
                            },
                        onLoadStop: (InAppWebViewController controller,
                            String url) async {
                          print("CONSOLE MESSAGE: " + url);
                          //    // return https://paynote.de/api/tink/callback?code=bef5d3722c8e48f2bb9a2fac79c9a3f2&credentialsId=470603819a244ff8ac689306ec909b2e
                          if (url.contains('credentialsId=')) {
                            var html = await controller.evaluateJavascript(
                                source: "window.document.body.innerText;");
                            var j = jsonDecode(html);
                            BResponse bResponse = new BResponse();
                            bResponse = BResponse.fromJson(j);
                            print(html);
                            print(bResponse);
                            if (bResponse.status == 0) {
                              String deepL = bResponse.data.deeplink;
                              model.handleDeepLink(deepL);
                              print(deepL);
                            }

                            //<html><head></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">{"status":0,"message":"Got Detail Of Data Successfully","data":{"deeplink":"https://paynote.page.link/accounts?status=200&amp;userId=64bbe15783c04a37b0f95ab9e07f0f38"}}</pre></body></html>
                          }
                        },
                        onProgressChanged: (InAppWebViewController controller,
                            int progress) {},
                      ),

               /* child:model.isBusy? Container() :
                InAppWebView(
                        initialUrl: model.url,
                        initialHeaders: {},
                        initialOptions: InAppWebViewGroupOptions(
                            crossPlatform: InAppWebViewOptions(
                          debuggingEnabled: false,
                        )),
                        onWebViewCreated: (InAppWebViewController controller) async {
                          webView = controller;
                        },

                        onLoadStart:
                            (InAppWebViewController controller, String url) async {
                              print("CONSOLE MESSAGE: " + url);
                              if(url.contains('rabobank.nl')){
                                _launchURL(url);
                                controller.stopLoading();
                                controller.goBack();


                              }
                              //    // return https://paynote.de/api/tink/callback?code=bef5d3722c8e48f2bb9a2fac79c9a3f2&credentialsId=470603819a244ff8ac689306ec909b2e
                              if (url.contains('paynote.de/api/tink/callback')) {
                                var html = await controller.evaluateJavascript(
                                    source: "window.document.body.innerText;");
                                var j = jsonDecode(html);
                                BResponse bResponse = new BResponse();
                                bResponse = BResponse.fromJson(j);
                                print(html);
                                print(bResponse);
                                if (bResponse.status == 0) {
                                  String deepL = bResponse.data.deeplink;
                                  model.handleDeepLink(deepL);
                                }

                                //<html><head></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">{"status":0,"message":"Got Detail Of Data Successfully","data":{"deeplink":"https://paynote.page.link/accounts?status=200&amp;userId=64bbe15783c04a37b0f95ab9e07f0f38"}}</pre></body></html>
                              }
                            },
                        *//*onLoadStop: (InAppWebViewController controller,
                            String url) async {

                        },*//*
                        onProgressChanged: (InAppWebViewController controller,
                            int progress) {},
                      ),*/

              ),
            ),
            /*ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: new Icon(Icons.arrow_back),
                      onPressed: () {
                        if (webView != null) {
                          webView.goBack();
                        }
                      },
                    ),
                    IconButton(
                      icon: new Icon(Icons.arrow_forward),
                      onPressed: () {
                        if (webView != null) {
                          webView.goForward();
                        }
                      },
                    ),
                    IconButton(
                      icon: new Icon(Icons.refresh),
                      onPressed: () {
                        if (webView != null) {
                          webView.reload();
                        }
                      },
                    ),
                  ],
                ),*/
          ]),
        ),);
      },
      viewModelBuilder: () => TinkAccountLinkViewModel(user.id,context),
      onModelReady: (model) {
        model.getUserFromPref();
        //await model.addBank(user.id,context);
        //await model.addBank(user.id,context);
      },
    );
  }


  void _launchURL(String url)async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
