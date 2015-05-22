//
//  ViewController.swift
//  judgeAppIsUpdate
//
//  Created by xly on 15-5-21.
//  Copyright (c) 2015年 Lily. All rights reserved.
//

import UIKit

class ViewController: UIViewController,HttpProtocol,UIAlertViewDelegate{

    var ehttp = HttpRequest()
    
    var trackViewUrl:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ehttp.delegate = self
        
        var params = ["id":"955723864"]
        ehttp.onPost("http://itunes.apple.com/lookup", params: params)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didRecieveResults(results:NSDictionary){
        
        if results["results"] != nil{
            var infoArray = results["results"] as NSArray
            
            var releaseInfo:NSDictionary = infoArray.objectAtIndex(0) as NSDictionary
            
            var appStoreVersion:NSString = releaseInfo.objectForKey("version") as NSString
            
            var infoDic:NSDictionary = NSBundle.mainBundle().infoDictionary! as NSDictionary
            
            var currentVersion:NSString = infoDic.objectForKey("CFBundleShortVersionString") as NSString
            
            var curVerArr:NSArray = currentVersion.componentsSeparatedByString(".") as NSArray
            var appstoreVerArr:NSArray = appStoreVersion.componentsSeparatedByString(".") as NSArray
            
            var needUpdate:Bool = false
            
            //比较版本号
            var maxv:Int = max(curVerArr.count, appstoreVerArr.count) as Int
            
            var cver:Int = 0
            var aver:Int = 0
            
            for(var i:Int = 0;i < maxv;i++){
                if appstoreVerArr.count > i{
                    aver = Int(appstoreVerArr[i].intValue)
                }else{
                    aver = 0
                }
                
                if curVerArr.count > i{
                    cver = Int(curVerArr[i].intValue)
                }else{
                    cver = 0
                }
                
                if aver > cver{
                    needUpdate = true
                    break
                }else{
                    needUpdate = false
                }
            }
            
            //如果有可用的更新
            if needUpdate == true{
            
                //trackViewURL临时变量存储app下载地址，可以让app跳转到appstore
                trackViewUrl = releaseInfo.objectForKey("trackViewUrl") as String
            
                var alertView = UIAlertView(title: "版本升级", message: "发现有新版本，是否升级?", delegate: self, cancelButtonTitle: "暂不升级", otherButtonTitles: "马上升级")
                alertView.show()
            }
            
            
            
        }
        
        
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1{
            
            var application:UIApplication =  UIApplication.sharedApplication()
            application.openURL(NSURL(string: trackViewUrl)!)
        }
    }

}

