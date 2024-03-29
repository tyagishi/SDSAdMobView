//
//  AdInterstitial.swift
//
//  Created by : Tomoaki Yagishita on 2023/12/01
//  © 2023  SmallDeskSoftware
//

#if os(iOS)
import Foundation
import SwiftUI
import GoogleMobileAds

public class AdInterstitial: NSObject, GADFullScreenContentDelegate, ObservableObject {
    var interstitialAd: GADInterstitialAd?
    let adViewRepresentable: AdViewControllerRepresentable = AdViewControllerRepresentable()
    
    var requestID: String {
        #if DEBUG
        return "ca-app-pub-3940256099942544/4411468910" // test-id
        #else
        return adUnitId
        #endif
    }
    
    public var adInterstitialView: some View {
        adViewRepresentable.frame(width: 0, height: 0)
    }

    let adUnitId: String

    public init(adUnitId: String) {
        self.adUnitId = adUnitId
        super.init()
        loadInterstitial()
    }

    // リワード広告の読み込み
    public func loadInterstitial() {
        GADInterstitialAd.load(withAdUnitID: requestID, request: GADRequest()) { (ad, error) in
            self.interstitialAd = ad
            self.interstitialAd?.fullScreenContentDelegate = self
        }
    }

    // インタースティシャル広告の表示
    public func showInterstitial() {
        guard let interstitialAd = interstitialAd else { return }
        interstitialAd.present(fromRootViewController: adViewRepresentable.vc)
    }
    // failed to show
    public func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {}

    // willShow
    public func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {}

    // didDismiss/ need to reset GADInterstitialAd
    public func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        GADInterstitialAd.load(withAdUnitID: requestID, request: GADRequest()) { (ad, error) in
            self.interstitialAd = ad
        }
    }
    
    public struct AdViewControllerRepresentable: UIViewControllerRepresentable {
        let vc = UIViewController()
        
        public func makeUIViewController(context: Context) -> some UIViewController {
            return vc
        }
        
        // No implementation needed. Nothing to be updated.
        public func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    }
}
#endif
