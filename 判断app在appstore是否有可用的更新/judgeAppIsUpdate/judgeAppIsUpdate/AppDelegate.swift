//
//  AppDelegate.swift
//  judgeAppIsUpdate
//
//  Created by xly on 15-5-21.
//  Copyright (c) 2015年 Lily. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    /////////////////////////////////
    /**
    let NotificationCategoryIdent:NSString = "ACTIONABLE"
    let NotificationActionOneIdent:NSString = "ACTION_ONE"
    let NotificationActionTwoIdent:NSString = "ACTION_TWO"
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool{
    // Override point for customization after application launch.
    self.registerForNotification()
    return true
    }
    
    func registerForNotification(){
    var leftAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
    leftAction.activationMode = UIUserNotificationActivationMode.Foreground
    //这里需要注意的是你处理消息是在你对应的应用程序前台处理还是后台处理，如果是Foreground这样处理消息会跳进你对应的应用程序里面，Background则会在当前消息界面处理即苹果的主当前窗口。
    leftAction.title = "left"
    leftAction.identifier = NotificationActionOneIdent
    leftAction.destructive = false
    leftAction.authenticationRequired = false
    
    var rightAction:UIMutableUserNotificationAction = UIMutableUserNotificationAction()
    rightAction.activationMode = UIUserNotificationActivationMode.Foreground
    rightAction.title = "right"
    rightAction.identifier = NotificationActionTwoIdent
    rightAction.destructive = false
    rightAction.authenticationRequired = false
    
    //这个Category很重要很重要，这个是后面进行消息通信联系起来的
    var notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory();
    notificationCategory.identifier = NotificationCategoryIdent
    var actionArray:NSArray = [rightAction,leftAction]
    notificationCategory.setActions(actionArray, forContext: UIUserNotificationActionContext.Default)
    var categories:NSSet = NSSet(object:notificationCategory)
    let types:UIUserNotificationType = UIUserNotificationType.Alert | UIUserNotificationType.Badge | UIUserNotificationType.Sound
    var notificationSettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes:types,categories:categories)
    UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
    
    if identifier == NotificationActionOneIdent{
    
    NSNotificationCenter.defaultCenter().postNotificationName("ACTION_ONE",object: nil)
    
    }else if identifier == NotificationActionTwoIdent {
    
    NSNotificationCenter.defaultCenter().postNotificationName("ACTION_TWO",object: nil)
    }
    completionHandler()
    }
    **/
    ///////////////////////////////////
    
    /**
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //ios8 创建UIUserNotificationSettings，并设置消息的显示类类型
        if application.respondsToSelector(Selector("isRegisteredForRemoteNotifications")){
            
            var notiSettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge | UIUserNotificationType.Alert | UIUserNotificationType.Sound, categories: nil)
            application.registerUserNotificationSettings(notiSettings)
            
        }else{  //ios7
            application.registerForRemoteNotificationTypes(UIRemoteNotificationType.Badge | UIRemoteNotificationType.Sound)
            
        }
        return true
    }
    
    //远程推送通知 注册成功
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        println("deviceToken.description====>\(deviceToken.description)")
    }
    
    //8.0 之前   收到远程推送通知
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        println("8.0 之前userInfo ==>\(userInfo)")
        
        var notif = userInfo as NSDictionary
        
        var apsDic = notif.objectForKey("aps") as NSDictionary
        
        var alertDic = apsDic.objectForKey("alert") as String
        
        var alertView = UIAlertView(title: "系统本地通知", message: alertDic, delegate: nil, cancelButtonTitle: "返回")
        
        alertView.show()
    }
    
    //8.0 之后 收到远程推送通知
    //    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject], fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
    //        NSLog("userInfo == %", userInfo)
    //
    //        var notif = userInfo as NSDictionary
    //
    //        var apsDic = notif.objectForKey("aps") as NSDictionary
    //
    //        var alertDic = apsDic.objectForKey("alert") as String
    //
    //        var alertView = UIAlertView(title: "系统本地通知", message: alertDic, delegate: nil, cancelButtonTitle: "返回")
    //
    //        alertView.show()
    //    }
    
    // 注册通知 alert 、 sound 、 badge （ 8.0 之后，必须要添加下面这段代码，否则注册失败）
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        application.registerForRemoteNotifications()
    }
    
    //远程推送通知 注册失败
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println("Regist fail :\(error)")
    }
    
    // 收到本地通知
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        var alert = UIAlertView(title: "系统本地通知", message: notification.alertBody, delegate: nil, cancelButtonTitle: "返回")
        alert.show()
    }
    
    **/

}

