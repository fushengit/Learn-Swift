//
//  String+Extention.swift
//  FSWB
//
//  Created by 123 on 17/5/23.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import Foundation

extension String{
    var documentsPath:String{
        let filePathStr = String(format: "%@/Documents/", NSHomeDirectory())
        return filePathStr + self
    }
    var cachesPath:String{
        let filePathStr = String(format: "%@/Caches/", NSHomeDirectory())
        return filePathStr + self
    }
}
