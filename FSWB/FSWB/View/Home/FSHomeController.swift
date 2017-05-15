//
//  FSHomeController.swift
//  FSWB
//
//  Created by 123 on 17/5/15.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

class FSHomeController: FSBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
    }
    
    func setNavBar() {
        myBarItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(friendAction))
        myBarItem.leftBarButtonItem?.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.darkGray], for: .normal)
    }
    
    //FIXME: 未实现真实跳转
    @objc private func friendAction() {
        print("跳转好友页面")
        navigationController?.pushViewController(FSDemoController(), animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
