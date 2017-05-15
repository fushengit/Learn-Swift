//
//  FSBaseNavigationController.swift
//  FSWB
//
//  Created by 123 on 17/5/12.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

class FSBaseNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.isEnabled = true
        navigationBar.isHidden = true
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true
            if let newVC = viewController as? FSBaseViewController
            {
                let leftItem = UIBarButtonItem(image: UIImage(named: "navigationbar_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(popToPraent))
                newVC.myBarItem.leftBarButtonItem = leftItem
            }
        }
        super.pushViewController(viewController, animated: animated)
    }

    func popToPraent() {
        popViewController(animated: true)
    }
}
