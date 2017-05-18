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
        guard let jsonPatch =  Bundle.main.path(forResource: "main.json", ofType: nil),
            let array = NSArray(contentsOfFile: jsonPatch) as? [[String:Any]] else {
            return
        }
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
