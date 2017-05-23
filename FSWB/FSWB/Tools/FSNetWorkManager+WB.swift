//
//  FSNetWorkManager+WB.swift
//  FSWB
//
//  Created by 123 on 17/5/19.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import Foundation
import YYModel

//MARK: 业务逻辑封装代码
extension FSNetWorkManager{
    /// 获取当前登录用户及其所关注用户的最新微博
    ///
    /// - Parameters:
    ///   - since_id: 返回ID比since_id大的微博（即比since_id时间晚的微博)
    ///   - max_id: 返回ID小于或等于max_id的微博
    ///   - complete: 完成回调
    func statusesHomeTimeline(since_id:Int64, max_id:Int64, complete:@escaping (_ isSucc:Bool,_ list:[[String:Any]]?,_ errorCode:Int?) -> ()) -> (){
        let urlStr = "https://api.weibo.com/2/statuses/home_timeline.json"
        let param = ["since_id":"\(since_id)","max_id":"\(max_id)"]
        FSNetWorkManager.shared.asyncTokenRquest(URLString: urlStr, param: param) { (isSucc, task, json, error) in
            let result = (json as AnyObject)["statuses"] as? [[String:Any]]
            complete(isSucc, result, (task?.response as? HTTPURLResponse)?.statusCode)
        }
    }
    
    /// 获取授权过的Access Token
    ///
    /// - Parameters:
    ///   - code: 	调用authorize获得的code值
    ///   - complete: <#complete description#>
    func requestOauthToken(code:String,complete:@escaping (_ isSucc:Bool)->()) -> () {
        let urlStr = "https://api.weibo.com/oauth2/access_token"
        let param = ["client_id":WBclient_id,
                     "client_secret":WBclient_secret,
                     "grant_type":"authorization_code",
                     "code":code,
                     "redirect_uri":WBredirect_uri]
        FSNetWorkManager.shared.asyncRquest(requstType: .POST, URLString: urlStr, param: param) { (isSucc, task, json, error) in
            if isSucc{
                self.authModel.yy_modelSet(withJSON: json ?? [:])
                FSNetWorkManager.shared.requestUserInfo(complete: { (profileSucc) in
                    complete(profileSucc)
                })
            }else{
                complete(isSucc)
            }
        }
    }
    
    /// 获取用户信息
    ///
    /// - Parameter complete: <#complete description#>
    func requestUserInfo(complete:@escaping(_ isSucc:Bool)->()) -> () {
        let urlStr = "https://api.weibo.com/2/users/show.json"
        let param = ["uid":authModel.uid ?? ""]
        FSNetWorkManager.shared.asyncTokenRquest(URLString: urlStr, param: param) { (isSucc, task, json, error) in
            self.authModel.yy_modelSet(withJSON: json ?? [:])
            self.authModel.saveToLocal()
            print(self.authModel)
            complete(isSucc)
        }
    }
}
