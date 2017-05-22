//
//  FSNetWorkManager.swift
//  FSWB
//
//  Created by 123 on 17/5/19.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit
import AFNetworking

enum RequstType {
    case GET
    case POST
}

class FSNetWorkManager: AFHTTPSessionManager {
    //创建一个单利
    static let shared:FSNetWorkManager = {
        let manager = FSNetWorkManager()
        manager.responseSerializer.acceptableContentTypes?.insert("text/plain")
        return manager
    }()
    
    lazy var authModel = FSWBAuthModel()
    
    //网络请求封装方法
    func asyncRquest(requstType:RequstType = .GET, URLString:String ,param:[String:String]? ,requestComplete:@escaping (_ isSucc:Bool,_ task:URLSessionDataTask?,_ json:Any?,_ error:Error?)->()) {
        let success = {(task:URLSessionDataTask,json:Any?) -> () in
            requestComplete(true, task, json, nil)
        }
        let failure = { (task:URLSessionDataTask?,error:Error) -> () in
            if (task?.response as? HTTPURLResponse)?.statusCode == 403 {
                print("token无效，需要重新授权登录")
                //FIXME: 未登录，通知界面做登录处理

                
            }
            requestComplete(false, task, nil, error)
            print(error)
        }
        if requstType == .GET {
            get(URLString, parameters: param, progress: nil, success: { (task, json) in
                success(task, json)
            }) { (task, error) in
                failure(task, error)
            }
        }else{
            post(URLString, parameters: param, progress: nil, success: { (task, json) in
                success(task, json)
            }, failure: { (task, error) in
                failure(task, error)
            })
        }
    }
    
    //带token权限的网络请求方法
    func asyncTokenRquest(requstType:RequstType = .GET, URLString:String ,param:[String:String]? ,requestComplete:@escaping (_ isSucc:Bool,_ task:URLSessionDataTask?,_ json:Any?,_ error:Error?)->()){
        var param = param
        if param == nil {
            param = [String:String]()
        }
        if authModel.access_token == nil {
            //FIXME: 未登录，通知界面做登录处理
            
            
            requestComplete(false, nil, nil, nil)
            return
        }
        param!["access_token"] = authModel.access_token
        asyncRquest(requstType: requstType, URLString: URLString, param: param, requestComplete: requestComplete)
    }
}
