//
//  bLendingApp.swift
//  bLending
//
//  Created by Sanghyeon Lee on 2022/02/13.
//

import SwiftUI

// Firebase
import UIKit
import Firebase

// Kakao
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct bLendingApp: App {
    // Kakao SDK initializing
    init() {
        KakaoSDK.initSDK(appKey: "67b64dcd767f89e879e09e7cc8806b58")
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            // onOpenURl()을 사용해 커스텀 URL 스킴 처리
            ContentView().onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}

// Firebase initializing
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
