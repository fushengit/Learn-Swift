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
        //设置评论按钮
        setUpComposeBtn()
    }
    
    //FIXME: 未实现真实跳转
    //评论按钮点击事件
    @objc func composeAction(){
        print("我要发表")
    }
}

extension FSMainTabbarController{
    func setUpChildControllers(){
        let array:[[String:Any]] = [
            ["className":"FSHomeController","titleName":"首页","imageName":"tabbar_home",
             "visitorInfo":["imageName":"tabbar_home","titleText":"请登录，登录后首页更精彩！注册用户首页分享999大红包"]
            ],
            
            ["className":"FSMessageController","titleName":"消息","imageName":"tabbar_message_center",
             "visitorInfo":["imageName":"tabbar_message_center","titleText":"请登录，登录后消息更精彩！注册用户消息分享999大红包"]
            ],
            
            ["className":"","titleName":"","imageName":""],
            
            ["className":"FSDiscoverController","titleName":"发现","imageName":"tabbar_discover",
             "visitorInfo":["imageName":"tabbar_discover","titleText":"请登录，登录后发现更精彩！注册用户发现分享999大红包"]
            ],
            
            ["className":"FSProfileController","titleName":"我","imageName":"tabbar_profile",
             "visitorInfo":["imageName":"tabbar_profile","titleText":"请登录，登录后个人更精彩！注册用户跟人分享999大红包"]
            ],
        ]
        var controllers:[FSBaseNavigationController] = [FSBaseNavigationController]()
        for dict in array {
            controllers.append(getController(dict: dict))
        }
        self.viewControllers = controllers
    }
    
    func setUpComposeBtn() {
        let composeBtn = UIButton(type: .custom)
        tabBar.addSubview(composeBtn)
        let count = CGFloat(childViewControllers.count)
        let btnW = tabBar.bounds.width/count - 1
        composeBtn.frame = tabBar.bounds.insetBy(dx: btnW * 2, dy: 0)
        composeBtn.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"), for: .normal)
        composeBtn.setImage(UIImage.init(named: "tabbar_compose_icon_add"), for: .normal)
        composeBtn.addTarget(self, action: #selector(composeAction), for: .touchUpInside)
    }
    
    //MARK: 根据类名获取一个控制器
    private func getController(dict:[String:Any]) -> FSBaseNavigationController {
        guard let className = dict["className"] ,
            let titleName = dict["titleName"],
            let imageName = dict["imageName"],
            let classNameStr = className as? String,
            let titleNameStr = titleName as? String,
            let imageNameStr = imageName as? String,
            let cls = NSClassFromString(Bundle.main.nameSpace + "." + classNameStr) as? FSBaseViewController.Type
        else {
            return FSBaseNavigationController()
        }
        let vc = cls.init()
        vc.title = titleNameStr
        if let visitorinfo:[String:String] = dict["visitorInfo"] as? [String:String] {
            vc.visiterInfo = visitorinfo
        }
      vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName :UIColor.darkGray], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName :UIColor.orange], for: .selected)
        vc.tabBarItem.image = UIImage(named: imageNameStr)?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: imageNameStr + "_selected")?.withRenderingMode(.alwaysOriginal);
        return FSBaseNavigationController.init(rootViewController: vc)
    }
}
