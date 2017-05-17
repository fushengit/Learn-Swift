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
    var mainTableView:UITableView?
    
    //重写set方法实现自定义的问题
    override var title: String?{
        didSet{
            myBarItem.title = title
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUI()
    }
    //MARK: 子类继承网络数据请求方法
    @objc func loadData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            print("请求网络数据")
            if #available(iOS 10.0, *) {
                self.mainTableView?.refreshControl?.endRefreshing()
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

//MARK: UI设置方法
extension FSBaseViewController:UITableViewDelegate,UITableViewDataSource{
    fileprivate func setUI() {
        view.backgroundColor = UIColor.white
        //导航栏设置
        setNavBar()
        //tableview设置
        setTableView()
    }
    
    //MARK: 子类可继承设置navgationbar
    //自定义导航栏（pop滑动时防止重合）
    func setNavBar() {
        //注意这里必须要设置大小，否则将不会显示
        let myNavBar = UINavigationBar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        myNavBar.items = [myBarItem]
        view.addSubview(myNavBar)
        myBarItem.title = title
        //设置bar 的背景颜色
        myNavBar.barTintColor = UIColor.white
        //设置title的背景颜色
        myNavBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
        //设置item的颜色
        myNavBar.tintColor = UIColor.darkGray
    }
    
    //MARK: 子类可继承封装的tabview
    func setTableView() {
        mainTableView = UITableView(frame: view.bounds)
        mainTableView?.dataSource = self
        mainTableView?.delegate = self
        view.insertSubview(mainTableView!, at: 0)
        //取消自动偏移
        automaticallyAdjustsScrollViewInsets = false
        //tableview偏移
        mainTableView?.contentInset = UIEdgeInsetsMake(64, 0, 64, 0)
        let refreshControl = UIRefreshControl()
        if #available(iOS 10.0, *) {
            mainTableView?.refreshControl = refreshControl
        } else {
            // Fallback on earlier versions
        }
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
}

//MARK: 子类可继承封装的UITableViewDelegate,UITableViewDataSource
extension FSBaseViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

