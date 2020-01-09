//
//  RSChatConfigurator.swift
//  Pods-RattleSnake_Example
//
//  Created by Sara Al-Kindy on 2019-11-01.
//

import Foundation
import ChatSDK

open class RSChatConfigurator {
    
    public static var shared = RSChatConfigurator()
    
    var shouldOpenThreads = false
    
    public func initialize(application: UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?, rootPath: String, interfaceAdapter: RSInterfaceAdapter? = nil) {
        let config = BConfiguration.init();
        config.rootPath = rootPath
        config.allowUsersToCreatePublicChats = true
        config.clearDatabaseWhenDataVersionChanges = true
        config.clearDataWhenRootPathChanges = true
        config.databaseVersion = "2"
        config.prefersLargeTitles = false
        config.shouldOpenChatWhenPushNotificationClicked = true
        config.shouldOpenChatWhenPushNotificationClickedOnlyIfTabBarVisible = true
        config.locationMessagesEnabled = false
        config.showUserAvatarsOn1to1Threads = true
        config.onlySendPushToOfflineUsers = true
        config.showLocalNotifications = false
        
        BChatSDK.initialize(config, app: application, options: launchOptions)
        
        //Use default interface adapter if user did not set their own
        BChatSDK.shared()?.interfaceAdapter = interfaceAdapter ?? RSInterfaceAdapter()
        
        BChatSDK.moderation().on()
    }
    
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        BChatSDK.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        BChatSDK.application(application, didReceiveRemoteNotification: userInfo)
    }
    
    public func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return BChatSDK.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return BChatSDK.application(app, open: url, options: options)
    }
    
//    func isTextChatPushPayload(userInfo: [AnyHashable : Any]) -> Bool{
//        return userInfo.has("chat_sdk_push_body")
//    }
}
