//
//  FSWBAuthModel.swift
//  FSWB
//
//  Created by 123 on 17/5/22.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

class FSWBAuthModel: NSObject {
    //令牌
    var access_token:String?
    //access_token的生命周期，单位是秒数。
    var expires_in:TimeInterval = 0{
        didSet{
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }
    //用户唯一标示
    var uid:String?
    //自定义属性，方便展示
    var expiresDate:Date?

    override var description: String{
        return yy_modelDescription()
    }
    
    //存储磁盘
    func saveToLocal() {
        guard var dict = self.yy_modelToJSONObject() as? [String:Any],
            let data = try? JSONSerialization.data(withJSONObject: dict, options: [])else {
            return
        }
        dict.removeValue(forKey: "expires_in")
        let authPath = String(format: "%@/Library/Caches/authPath.json", NSHomeDirectory())
        (data as NSData).write(toFile: authPath, atomically: true)
        print(authPath)
    }
    
    //重写构造函数方法从磁盘读取数据
    override init() {
        super.init()
        let authPath = String(format: "%@/Library/Caches/authPath.json", NSHomeDirectory())
        guard let data = NSData(contentsOfFile: authPath) as? Data,
            let jsonDict = try? JSONSerialization.jsonObject(with: data, options: [])
            else {
            return
        }
        self.yy_modelSet(withJSON: jsonDict)
        //过期时间与当前时间相比，如果不是降序排列，即：expriesdate<date.now 表明过期
        if expiresDate?.compare(Date()) != .orderedDescending {
            //token过期处理
            expiresDate = nil
            access_token = nil
            uid = nil
            try? FileManager.default.removeItem(atPath: authPath)
        }
        print(self)
    }
}
