//
//  ViewController.swift
//  Swift_15ProductName
//
//  Created by 123 on 17/5/12.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        test4()
    }
    
    // 读取info.plist 也不管用
    func test4() {
        let productName = Bundle.main.infoDictionary?["CFBundleName"] as? String
        let clsName = (productName ?? "") + ".DetailController"
        print(clsName)
        let cls = NSClassFromString(clsName) as? DetailController.Type;
        if let cls = cls {
            print(cls)
            let detailVC = cls.init()
            present(detailVC, animated: true, completion: nil)
        }else{
            print("类不存在")
        }
    }
    
}


class DetailController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}

