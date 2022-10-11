//
//  AppDelegate.swift
//  Demo
//
//  Created by MBP2022_1 on 11/10/22.
//

import UIKit
import Covantex_SDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let settings = API.shared.getSettings()
        settings.mode = .Beta
        settings.mainServiceApiKey = "vcBetaSY3gFhfJLX"
        settings.mainServiceBaseUrl = "https://api-beta.covantex.com/v1"
        settings.isPrintRequestResponseNeeded = true
        API.shared.updateSettings(settings: settings)
        
        //API Session related:-------------------------
        //Get Set Session of APIs (apiKey, apiUrl, apiUserRole, authorization)
        let session = API.shared.getSession()
        session.apiKey = "vcBetaSY3gFhfJLX"
        session.apiUrl = "https://api-beta.covantex.com/v1"
        API.shared.updateSession(session: session)
        
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

