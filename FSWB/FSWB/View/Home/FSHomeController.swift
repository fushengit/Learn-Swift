//
//  FSHomeController.swift
//  FSWB
//
//  Created by 123 on 17/5/15.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

class FSHomeController: FSBaseViewController {

    lazy var statusesViewModel = FSStatusesViewModel()
    var isLoadMore = false //是否是加载更多事件

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func loadData() {
        statusesViewModel.loadData(isLoadMore: isLoadMore) { (isSucc, errorStr) in
            if isSucc{
                self.isLoadMore = false
                self.mainTableView?.reloadData()
                if #available(iOS 10.0, *) {
                    self.mainTableView?.refreshControl?.endRefreshing()
                } else {
                    // Fallback on earlier versions
                }
            }else{
                //FIXME: 这里需要弹hud提示信息
                print(errorStr ?? "")
            }
        }
    }
    
    //FIXME: 未实现真实跳转
    @objc fileprivate func friendAction() {
        print("跳转好友页面")
    }
    //FIXME: 未实现登录真实逻辑
    @objc fileprivate func loginAction() {
        print("登录事件")
    }
}



//MARK: UI设置
extension FSHomeController{
    override func setNavBar() {
        super.setNavBar()
    }
    override func setTableView() {
        super.setTableView()
        mainTableView?.showsVerticalScrollIndicator = false
        myNavBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.darkGray]
        myNavBar.tintColor = UIColor.darkGray
        myBarItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(friendAction))
    }
    override func setVisiterView() {
        super.setVisiterView()
        myNavBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.orange]
        myNavBar.tintColor = UIColor.orange
        myBarItem.leftBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginAction))
    }
}


//MARK: tableviewDataSource  tableviewDelegate
extension FSHomeController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusesViewModel.statusesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellId")
        }
        cell?.textLabel?.text = statusesViewModel.statusesList[indexPath.row].text
        return cell!
    }
    
    //无缝上拉加载更多
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let row = indexPath.row
        //这里判断到滑到最后一个
        if row == statusesViewModel.statusesList.count-1 {
            isLoadMore = true
            loadData()
        }
    }
}
