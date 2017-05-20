//
//  StatusesModel.swift
//  FSWB
//
//  Created by 123 on 17/5/19.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit
import YYModel

class FSStatusesModel: NSObject {
    var id:Int64 = 0;
    var text:String?
    
    override var description: String{
        return yy_modelDescription()
    }
}
