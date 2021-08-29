//
//  AppDelegate.swift
//  Idus_b
//
//  Created by 강성수 on 2021/08/15.
//

import UIKit
import AlamofireNetworkActivityIndicator
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // StatusBar에 Alamofire 시도 중 Indicator 띄워주기 위한 옵션 설정
        NetworkActivityIndicatorManager.shared.isEnabled = true
        
        // 네이티브 앱 키를 사용해 iOS SDK를 초기화하는 과정(Kakao SDK를 초기화)
        KakaoSDKCommon.initSDK(appKey: "e8f0040c3b5ae27eb7d0e404ac07781d") // NATIVE_APP_KEY
        
        // 네이버 간편로그인 init
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        // 네이버앱으로 인증하는 방식 활성화
        instance?.isNaverAppOauthEnable = false
        
        // 사파리(웹 브라우저)로 인증하는 방식 활성화
        instance?.isInAppOauthEnable = true
        
        // 인증 화면을 아이폰의 세로모드에서만 적용
        instance?.isOnlyPortraitSupportedInIphone()

        // 애플리케이션을 등록할 때 입력한 URL Scheme
        instance?.serviceUrlScheme = kServiceAppUrlScheme
        // 애플리케이션 등록 후 발급받은 클라이언트 아이디
        instance?.consumerKey = kConsumerKey
        // 애플리케이션 등록 후 발급받은 클라이언트 시크릿
        instance?.consumerSecret = kConsumerSecret
        // 애플리케이션 이름
        instance?.appName = kServiceAppName
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        NaverThirdPartyLoginConnection.getSharedInstance()?.application(app, open: url, options: options)
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
        NaverThirdPartyLoginConnection.getSharedInstance()?.requestDeleteToken()
        UserDefaults.standard.removeObject(forKey: "accessToken")
        print("Naver User log out")
    }


}

