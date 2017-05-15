//
//  MainTabbarController.swift
//  FSWB
//
//  Created by 123 on 17/5/12.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

class FSMainTabbarController: UITabBarController {
    override func viewDidLoad() {
        //设置字控制器
        setUpChildControllers()
    }
}

extension FSMainTabbarController{
    func setUpChildControllers(){
        let array:[[String:String]] = [
            ["className":"FSHomeController","titleName":"首页","imageName":"tabbar_home"],
            ["className":"FSMessageController","titleName":"消息","imageName":"tabbar_message_center"],
            ["className":"FSDiscoverController","titleName":"发现","imageName":"tabbar_discover"],
            ["className":"FSProfileController","titleName":"我","imageName":"tabbar_profile"],
        ]
        var controllers:[FSBaseNavigationController] = [FSBaseNavigationController]()
        for dict in array {
            controllers.append(getController(dict: dict))
        }
        self.viewControllers = controllers
    }
    //MARK: 根据类名获取一个控制器
    private func getController(dict:[String:String]) -> FSBaseNavigationController {
        guard let className = dict["className"] ,
            let titleName = dict["titleName"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + className) as? FSBaseViewController.Type
        else {
            return FSBaseNavigationController()
        }
        let vc = cls.init()
        vc.title = titleName
        vc.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName :UIColor.darkGray], for: UIControlState.init(rawValue: 0))
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName :UIColor.orange], for: .highlighted)
        return FSBaseNavigationController.init(rootViewController: vc)
    }
}
