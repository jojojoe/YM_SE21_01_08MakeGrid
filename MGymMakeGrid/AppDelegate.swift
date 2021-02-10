//
//  AppDelegate.swift
//  MGymMakeGrid
//
//  Created by JOJO on 2021/2/2.
//

import UIKit
import Adjust
import SwiftyStoreKit


// he /*
enum AdjustKey: String {
    case AdjustKeyAppToken = "kbotkgq6cxs0"
    case AdjustKeyAppLaunch = "mk7gk8"
    case AdjustKeyAppCoinsBuy = "pkedes"
}
// 核里面 AdjustConfig.json 也要填
// 测试 进 ID com.testbase.www
// he */

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var mainVC: MGymMainVC = MGymMainVC()

    func initMainVC() {
        let nav = UINavigationController.init(rootViewController: mainVC)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        #if DEBUG
        for fy in UIFont.familyNames {
            let fts = UIFont.fontNames(forFamilyName: fy)
            for ft in fts {
                debugPrint("***fontName = \(ft)")
            }
        }
        #endif
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initMainVC()
        
        // he /*
        Adjust.appDidLaunch(ADJConfig(appToken: AdjustKey.AdjustKeyAppToken.rawValue, environment: ADJEnvironmentProduction))
        Adjust.trackEvent(ADJEvent(eventToken: AdjustKey.AdjustKeyAppLaunch.rawValue))
        NotificationCenter.default.post(name: .Pre,
                                        object: [
                                            HightLigtingHelper.default.debugBundleIdentifier = "com.testbase.www11",
                                            HightLigtingHelper.default.setProductUrl(string: "https://storyedit.icu/new/")])
        // he */
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

