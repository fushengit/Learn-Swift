//
//  Bundle+Extention.swift
//  FSWB
//
//  Created by 123 on 17/5/12.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import Foundation

extension Bundle{
    var nameSpace:String{
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    var versionString:String{
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}

