//
//  FSBaseViewController.swift
//  FSWB
//
//  Created by 123 on 17/5/12.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

class FSBaseViewController: UIViewController {
    //MARK: 自定义的导航栏，后期操作导航栏全部使用这个
    lazy var myBarItem:UINavigationItem = UINavigationItem()
    //重写set方法实现自定义的问题
    override var title: String?{
        didSet{
            myBarItem.title = title
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: CGFloat(arc4random()%255)/255, green: CGFloat(arc4random()%255)/255, blue: CGFloat(arc4random()%255)/255, alpha: 1)
        setNavBar()
    }
    
    //自定义导航栏（pop滑动时防止重合）
    private func setNavBar() {
        //注意这里必须要设置大小，否则将不会显示
        let myNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        myNavBar.items = [myBarItem]
        view.addSubview(myNavBar)
        myBarItem.title = title
        //这里是设置导航栏标题的唯一方法
        myNavBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
    }
}


