//
//  FSVisiterView.swift
//  FSWB
//
//  Created by 123 on 17/5/17.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

class FSVisiterView: UIView {
    fileprivate let imageView = UIImageView()
    fileprivate let titleLabel = UILabel()
    var loginBtn = UIButton.init()
    var registBtn = UIButton.init()
    
    //MARK: visitorInfo 目前需要包含两个key：imageName，titleText
    var visitorInfo:[String:String]? {
        didSet{
            if let imageName = visitorInfo?["imageName"]
            {
                imageView.image = UIImage(named: imageName);
                
            }
            if let titleText = visitorInfo?["titleText"]
            {
                titleLabel.text = titleText
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: UI设置  核心动画&自动布局
extension FSVisiterView{
    func setUI(){
        addSubview(imageView)
        //核心动画
        let anmaintion = CABasicAnimation(keyPath: "transform.rotation")
        anmaintion.repeatCount = MAXFLOAT
        anmaintion.duration = 3
        anmaintion.fromValue = 0
        anmaintion.toValue = 2 * M_PI
        /* When true, the animation is removed from the render tree once its
         * active duration has passed. Defaults to YES. */
        anmaintion.isRemovedOnCompletion = false
        imageView.layer.add(anmaintion, forKey: nil)
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.darkGray
        titleLabel.numberOfLines = 0
        addSubview(titleLabel)
        
        
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.orange, for: .normal)
        loginBtn.layer.masksToBounds = true
        loginBtn.layer.borderWidth = 1;
        loginBtn.layer.borderColor = UIColor.orange.cgColor
        addSubview(loginBtn)
        
        registBtn.setTitle("注册", for: .normal)
        registBtn.setTitleColor(UIColor.orange, for: .normal)
        registBtn.layer.masksToBounds = true
        registBtn.layer.borderWidth = 1;
        registBtn.layer.borderColor = UIColor.orange.cgColor
        addSubview(registBtn)
        
        //开始自动布局前需要先关闭autoresizeing
        for view in subviews {
            /*
             When you elect to position the view using auto layout by adding your own constraints,
             you must set this property to NO. IB will do this for you.
             */
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //"view1.attr1 = view2.attr2 * multiplier + constant"
        //1>旋转动画
        addConstraint(NSLayoutConstraint(item: imageView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -100))
        //2>展示标题
        addConstraint(NSLayoutConstraint(item: titleLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: titleLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: imageView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 50))
        addConstraint(NSLayoutConstraint(item: titleLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 270))
        //3>登录按钮
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: titleLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 50))
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: titleLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        //3>注册按钮
        addConstraint(NSLayoutConstraint(item: registBtn,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: titleLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 50))
        addConstraint(NSLayoutConstraint(item: registBtn,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: titleLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registBtn,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        
    }
}
