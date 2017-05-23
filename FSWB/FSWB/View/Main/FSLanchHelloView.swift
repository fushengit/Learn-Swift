//
//  FSLanchHelloView.swift
//  FSWB
//
//  Created by 123 on 17/5/23.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit
import SDWebImage

class FSLanchHelloView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var iconImageViewBottom: NSLayoutConstraint!
    
    override func awakeFromNib() {
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = 50;
        showLabel.alpha = 0
        guard let urlStr = FSNetWorkManager.shared.authModel.avatar_large,
            let url = URL.init(string: urlStr) ,
            let image = UIImage(named: "avatar_default") else {
            return
        }
        iconImageView.sd_setImage(with: url, placeholderImage: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func hellowView() -> FSLanchHelloView {
        let view = Bundle.main.loadNibNamed("FSLanchHelloView", owner: nil, options: nil)?.first as? FSLanchHelloView
        view?.frame = UIScreen.main.bounds
        return view!
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.layoutIfNeeded()
        iconImageViewBottom.constant = UIScreen.main.bounds.height - 200
        UIView.animate(withDuration: 3,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: { 
                        self.layoutIfNeeded()
        }) { (_) in
            UIView.animate(withDuration: 1, animations: { 
                self.showLabel.alpha = 1
            }, completion: { (_) in
                self.removeFromSuperview()
            })
        }
    }
}
