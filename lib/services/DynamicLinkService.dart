
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:paynote_app/app/locator.dart';
import 'package:paynote_app/app/router.gr.dart';
import 'package:stacked_services/stacked_services.dart';

class DynamicLinkService {
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleDynamicLinks() async {
    // Get the initial dynamic link if the app is opened with a dynamic link
    final PendingDynamicLinkData data =
    await FirebaseDynamicLinks.instance.getInitialLink();

    // handle link that has been retrieved
    _handleDeepLink(data);

    // Register a link callback to fire if the app is opened up from the background
    // using a dynamic link.
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          // handle link that has been retrieved
          _handleDeepLink(dynamicLink);
        }, onError: (OnLinkErrorException e) async {
      print('Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {

   // https://paynote.page.link/accounts?status=200&userId=3aa81eeff2164280a3c699e5236a1487
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');

      var isLoggedIn = deepLink.pathSegments.contains('accounts');
      if (isLoggedIn) {
        var userId = deepLink.queryParameters['userId'];
        if (userId != null) {
          _navigationService.clearStackAndShow(Routes.dashboardView);
        }
      }
    }
  }

  /*Future<String> createAccountLink(String title) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://paynote.page.link',
      link: Uri.parse('https://paynote.page.link?account=$title'),
      androidParameters: AndroidParameters(
        packageName: 'com.paynote.paynote_app',
      ),




      // Other things to add as an example. We don't need it now
     *//* iosParameters: IosParameters(
        bundleId: 'com.example.ios',
        minimumVersion: '1.0.1',
        appStoreId: '123456789',
      ),*//*
     *//* googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'example-promo',
        medium: 'social',
        source: 'orkut',
      ),
      itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
        providerToken: '123456',
        campaignToken: 'example-promo',
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'Example of a Dynamic Link',
        description: 'This link works whether app is installed or not!',
      ),*//*
    );

    final Uri dynamicUrl = await parameters.buildUrl();

    return dynamicUrl.toString();
  }*/
}