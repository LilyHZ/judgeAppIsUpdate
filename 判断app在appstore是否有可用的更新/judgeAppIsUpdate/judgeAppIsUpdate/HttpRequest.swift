//
//  HttpController.swift
//  printmaster
//
//  Created by xly on 15-3-13.
//  Copyright (c) 2015年 Lily. All rights reserved.
//

import UIKit

//自定义http协议
protocol HttpProtocol{
    //定义一个方法接收一个字典
    func didRecieveResults(results:NSDictionary)
}

class HttpRequest: NSObject ,UIAlertViewDelegate{
    
    //定义一个可选代理
    var delegate:HttpProtocol?
    
    var useClosures = false
    var reachability = Reachability.reachabilityForInternetConnection()
    var alertView = UIAlertView(title: "提示", message: "网络异常，请检查是否有可用网络连接", delegate: nil, cancelButtonTitle: "确认")
    
    
    //定义一个方法获取网络数据，接收参数为网址 GET请求
    func onSearch(url:String){
        
        if (self.testNetConnection()){
            alertView.show()
            return
        }
        
        let requestUrl = url
        
        //定义一个NSURL
        var nsUrl:NSURL = NSURL(string: requestUrl)!
        
        //定义一个NSURLRequuest
        var request:NSURLRequest = NSURLRequest(URL: nsUrl)
        
        //异步获取数据
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            
            //由于我们获取的数据数据是json格式。所以我们可以将其转化为字典。
            var jsonResult:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
            println("jsonResult:\(jsonResult)")
            
            //将数据传回给代理
            self.delegate?.didRecieveResults(jsonResult)
        })
    }
    
    // 定义一个POST请求的方法 参数为 URL 参数名称 参数值 可以木有参数
    func onPostSearch(url:String,strKey:[String],strValue:[String]){
        
        if (self.testNetConnection()){
            alertView.show()
            return
        }
        
        let requestUrl = url
        
        var nsURL : NSURL!
        
        if(strKey.isEmpty && strValue.isEmpty && strKey.count == 0 && strValue.count == 0){
            nsURL = NSURL(string: requestUrl)
            println("参数：\(requestUrl)")
        }else{
            var param:String = String()
            
            for(var i=0;i<strKey.count;i++){
                
                if(i==0){
                    param = "?" + strKey[i] + "=" + strValue[i]
                }
                
                param = param + "&" + strKey[i] + "=" + strValue[i]
                
            }
            var str:String = requestUrl + param
            
            nsURL = NSURL(string: str)
            
        }
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: nsURL)
        request.HTTPMethod = "POST"
        
        //异步获取数据
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            
            //由于我们获取的数据数据是json格式。所以我们可以将其转化为字典。
            var jsonResult:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
            println("jsonResult:\(jsonResult)")
            
            //将数据传回给代理
            self.delegate?.didRecieveResults(jsonResult)
            
        })
        
    }
    
    //POST请求 转成二进制 必须要有参数
    func onPost(url:String,params: NSDictionary){
        
        if (self.testNetConnection()){
            alertView.show()
            return
        }
        
        var requestUrl =  url
        //       var requestUrl = "http://192.168.0.136:8080/printBoss" + url
        
        var nsURL:NSURL = NSURL(string: requestUrl)!
        
        var post = ""
        
        for(key, value) in params as NSDictionary{
            if(post == ""){
                post += "\(key)=\(value)"
            }else{
                post += "&\(key)=\(value)"
            }
        }
        
        
        var postdata:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        
        var postLenght = String(postdata.length)
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: nsURL)
        
        request.HTTPMethod = "POST"
        request.HTTPBody = postdata
        request.setValue(postLenght, forHTTPHeaderField: "Content-Lenght")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        //异步获取数据
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response:NSURLResponse!,data:NSData!,error:NSError!)->Void in
            
            //由于我们获取的数据数据是json格式。所以我们可以将其转化为字典。
            var jsonResult:NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
            
            println("jsonResult:\(jsonResult)")
            
            //将数据传回给代理
            self.delegate?.didRecieveResults(jsonResult)
            
        })
        
    }
    
    //判断是否连网， 有网返回 false 无网返回 true
    func testNetConnection()->Bool{
        if(useClosures == false){
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
        }
        
        reachability.startNotifier()
        
        if (!reachability.isReachable() && "No Connection" == reachability.currentReachabilityString){
            return true
        }
        
        return false
    }
    
    deinit {
        
        reachability.stopNotifier()
        
        if (!useClosures) {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: ReachabilityChangedNotification, object: nil)
        }
    }
    
    
    func reachabilityChanged(note: NSNotification) -> Bool{
        
        let reachability = note.object as! Reachability
        
        if (!reachability.isReachable() && "No Connection" == reachability.currentReachabilityString){
            return true
        }
        
        return false
    }
    
}