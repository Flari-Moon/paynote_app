import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private UIVisualEffectView _blurView = null;

  public override void OnResignActivation(UIApplication uiApplication)
  {
      // First find the correct RootViewController
      var window = UIApplication.SharedApplication.KeyWindow;
      var vc = window.RootViewController;
      while (vc.PresentedViewController != null)
      {
          vc = vc.PresentedViewController;
      }
      // Add the blur effect
      using (var blurEffect = UIBlurEffect.FromStyle(UIBlurEffectStyle.Light))
      {
          _blurView = new UIVisualEffectView(blurEffect);
          _blurView.Frame = UIApplication.SharedApplication.KeyWindow.RootViewController.View.Bounds;
          vc.View.AddSubview(_blurView);
      }
      base.OnResignActivation(uiApplication);
  }

  public override void OnActivated(UIApplication uiApplication)
  {
      try
      {
          if (_blurView != null)
          {
              _blurView.RemoveFromSuperview();
              _blurView.Dispose();
              _blurView = null;
          }
      }
      catch { }
      base.OnActivated(uiApplication);
  }
}
