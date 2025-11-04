//
//  AdBanner.swift
//  ClockClipSwiftUI
//
//  Created by Tomoaki Yagishita on 2020/03/11.
//  Copyright © 2020 SmallDeskSoftware. All rights reserved.
//

#if os(iOS)
import Foundation
import SwiftUI
//import FirebaseCore
import GoogleMobileAds

//// note: comes from GADAdSize.h
//public enum AdBannerSize {
//    /// iPhone and iPod Touch ad size. Typically 320x50.
//    case AdSizeBanner
//    /// Taller version of GADAdSizeBanner. Typically 320x100.
//    case AdSizeLargeBanner;
//    /// Medium Rectangle size for the iPad (especially in a UISplitView's left pane). Typically 300x250.
//    case AdSizeMediumRectangle;
//    /// Full Banner size for the iPad (especially in a UIPopoverController or in UIModalPresentationFormSheet). Typically 468x60.
//    case AdSizeFullBanner;
//    /// Leaderboard size for the iPad. Typically 728x90.
//    case AdSizeLeaderboard;
//    /// Skyscraper size for the iPad. Mediation only. AdMob/Google does not offer this size. Typically 120x600.
//    case AdSizeSkyscraper;
//    /// An ad size that spans the full width of its container, with a height dynamically determined by the ad.
//    case AdSizeFluid;
//    
//    // iPhone: AdSizeBanner, iPad: AdSizeFullBanner
//    case automatic
//    
//    static public var adequateSize: AdSize {
//        let check = AdSizeBanner
//        if UIDevice.current.userInterfaceIdiom == .phone { return AdSizeBanner.gadSize }
//        return AdSizeFullBanner.gadSize
//    }
//    
////    public var gadSize: AdSize {
////        switch self {
////        case .AdSizeBanner:          return AdSizeBanner.gadSize
////        case .AdSizeLargeBanner:     return AdSizeLargeBanner.gadSize
////        case .AdSizeMediumRectangle: return AdSizeMediumRectangle.gadSize
////        case .AdSizeFullBanner:      return AdSizeFullBanner.gadSize
////        case .AdSizeLeaderboard:     return AdSizeLeaderboard.gadSize
////        case .AdSizeSkyscraper:      return AdSizeSkyscraper.gadSize
////        case .AdSizeFluid:           return AdSizeFluid.gadSize
////        case .automatic:             return Self.adequateSize
////        }
////    }
////    
////    public var cgSize: CGSize {
////        switch self {
////        case .AdSizeBanner:          return GADAdSizeBanner.size
////        case .AdSizeLargeBanner:     return GADAdSizeLargeBanner.size
////        case .AdSizeMediumRectangle: return GADAdSizeMediumRectangle.size
////        case .AdSizeFullBanner:      return GADAdSizeFullBanner.size
////        case .AdSizeLeaderboard:     return GADAdSizeLeaderboard.size
////        case .AdSizeSkyscraper:      return GADAdSizeSkyscraper.size
////        case .AdSizeFluid:           return GADAdSizeFluid.size
////        case .automatic:             return Self.adequateSize.size
////        }
////    }
//}

public class AdBanner: NSObject, BannerViewDelegate, ObservableObject {
    var interstitialAd: InterstitialAd?
    private let adView: AdBannerView
    let adSize: AdSize
//    public let oldAdSize: AdBannerSize
    
    static public var adequateAdSize: AdSize {
        let check = AdSizeBanner
        if UIDevice.current.userInterfaceIdiom == .phone { return AdSizeBanner }
        return AdSizeFullBanner
    }

    public init(adUnitId: String, size: AdSize){ //}, oldSize: AdBannerSize) {
//        self.oldAdSize = oldSize
        self.adSize = size
        self.adView = AdBannerView(adUnitId: adUnitId, size: adSize)
    }
    
    public var adBannerView: some View {
        adView.frame(width: adSize.size.width, height: adSize.size.height, alignment: .center)
    }
    
    struct AdBannerView: UIViewControllerRepresentable {
        let adUnitId: String
        var adSize: AdSize
        
        private var isiPhone: Bool {
            UIDevice.current.userInterfaceIdiom == .phone
        }

        init(adUnitId: String, size: AdSize) {
            self.adUnitId = adUnitId
            self.adSize = size
        }
        
        func makeUIViewController(context: Context) -> UIViewController {
            let view = BannerView(adSize: self.adSize)
            
            let viewController = UIViewController()
            #if DEBUG
            view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
            #else
            view.adUnitID = adUnitId
            #endif
            view.rootViewController = viewController
            viewController.view.addSubview(view)
            viewController.view.frame.size = adSize.size
            view.load(Request())
            
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
}
#endif
