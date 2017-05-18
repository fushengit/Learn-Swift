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
        var controllers:[FSBaseNavigationController] = [FSBaseNavigationController]()
        for dict in requestMainInfo() {
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

    //MARK: 返回从磁盘中获取的控制器数据 ，然后从服务器请求控制器数据json以便下次启动使用
    private func requestMainInfo() ->[[String:Any]] {
        let filePathStr = String(format: "%@/Library/Caches/resultMain.json", NSHomeDirectory())
        print(filePathStr)
        //读取磁盘中的配置
        var array:[[String:Any]]? = NSArray.init(contentsOfFile: filePathStr) as? [[String:Any]]
        //磁盘中如果没有，则读项目中默认的配置
        if array == nil {
            if let jsonPatch = Bundle.main.path(forResource: "main.json", ofType: nil) {
                array = NSArray(contentsOfFile: jsonPatch) as? [[String:Any]]
            }
        }
        //这里我们模拟网络请求 并把请求的数据写入磁盘
        URLSession.shared.dataTask(with: URL.init(string: "http://www.baidu.com")!) { (data, response, error) in
            if error == nil{
                //这里我们把项目里面默认的写进磁盘做测试
                if let dataPath = Bundle.main.path(forResource: "main.json", ofType: nil) {
                    let dataArray = NSArray(contentsOfFile: dataPath);
                    let result =  dataArray?.write(toFile: filePathStr, atomically: true)
                    print("操作结果：\(result)")
                }
            }
        }.resume()
        return array!
    }
}
