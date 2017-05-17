//
//  FSHomeController.swift
//  FSWB
//
//  Created by 123 on 17/5/15.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

class FSHomeController: FSBaseViewController {

    lazy var datasArray:[String] = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<15 {
            datasArray.append(String.init(format: "第%d条数据", i))
        }
    }
    
    override func setNavBar() {
        super.setNavBar()
        myBarItem.leftBarButtonItem = UIBarButtonItem(title: "好友", style: .plain, target: self, action: #selector(friendAction))
    }
    
    override func setTableView() {
        super.setTableView()
        mainTableView?.showsVerticalScrollIndicator = false
    }
    
    override func loadData() {
        //开始请求数据
        super.loadData()
    }
    
    //FIXME: 未实现真实跳转
    @objc private func friendAction() {
        print("跳转好友页面")
    }
}


extension FSHomeController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cellId")
        }
        cell?.textLabel?.text = datasArray[indexPath.row]
        return cell!
    }
}
