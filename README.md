# SDSAdMobView

convenient wrapped class for showing AdMob View in SwiftUI

note: "google ad set up"/ATTrackingManager should be initialized separately

## AdBanner / AdBannerView

```
struct SomeView: View {
  @StateObject var adBanner = AdBanner(adUnitId: "your-ad-id", size: .automatic) // note: id will be used only in release code. test-id will be used in debug

  var body: some View {
    VStack {
      Text("Hello world!")
      adBanner.adBannerView
    }
  }
}
```


## AdInterstitial / AdInterstitialView

```
struct SomeView: View {
  @StateObject var adInterstitial = AdInterstitial(adUnitId: "Your-Ad-ID") // note: used only in release code. test-id will be used in debug
  var body: some View {
    Button(action: { 
      adInterstitial.showInterstitial()
    }, label: { Text("Show Interstitial") })
    .background {
      adInterstitial.adInterstitialView
    }
  }
}
```
