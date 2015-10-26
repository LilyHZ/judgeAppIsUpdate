//
//  PingFenViewController.swift
//  judgeAppIsUpdate
//
//  Created by xly on 15-7-16.
//  Copyright (c) 2015年 Lily. All rights reserved.
//

import UIKit
import StoreKit

class PingFenViewController: UIViewController,SKStoreProductViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        var trackViewUrl = "itms-apps://itunes.apple.com/app/id547203890"//ios7以上版本
//        var trackViewUrl = "itms-apps://http://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=547203890"
        var application:UIApplication =  UIApplication.sharedApplication()
        application.openURL(NSURL(string: trackViewUrl)!)
        
//        evaluate()
        // Do any additional setup after loading the view.
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func evaluate(){
        //初始控制器
        var storeProductViewController:SKStoreProductViewController = SKStoreProductViewController()
        
        //设置代理请求为当前控制器本身
        storeProductViewController.delegate = self
        
        //加载一个新的视图展示
        storeProductViewController.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier:"955723864"], completionBlock: { (result:Bool, error:NSError!) -> Void in
            //block回调
//            if let dd = error{
//                NSLog("error %@ with userInfo %@", error)
//            }else{
                //模态弹出AppStore
                self.presentViewController(storeProductViewController, animated: true, completion: nil)
//            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
