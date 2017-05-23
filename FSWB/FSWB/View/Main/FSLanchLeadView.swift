//
//  FSLanchLeadView.swift
//  FSWB
//
//  Created by 123 on 17/5/23.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

class FSLanchLeadView: UIView {

    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var enterBtn: UIButton!
    
    @IBAction func enterAction() {
        removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    class func leadView() -> FSLanchLeadView {
        let view = Bundle.main.loadNibNamed("FSLanchLeadView", owner: nil, options: nil)?.first as? FSLanchLeadView
        view?.frame = UIScreen.main.bounds
        return view!
    }

    override func awakeFromNib() {
        let screamW = UIScreen.main.bounds.width
        let screamH = UIScreen.main.bounds.height
        for i in 0..<5 {
            let imageName = "new_feature_\(i+1)"
            let imageView = UIImageView(image: UIImage.init(named: imageName))
            imageView.frame = CGRect(x: CGFloat(i) * screamW, y: 0, width: screamW, height: screamH)
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: screamW * 5, height: screamH)
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        bringSubview(toFront: enterBtn)
        bringSubview(toFront: pageControl)
        enterBtn.isHidden = true
    }
}


extension FSLanchLeadView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let num = scrollView.contentOffset.x / UIScreen.main.bounds.width
        //最后一页显示进入按钮
        enterBtn.isHidden = num != 3
        if num == 4 {
            removeFromSuperview()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        enterBtn.isHidden = true
        let num = scrollView.contentOffset.x / UIScreen.main.bounds.width
        let iNum = Int(num + 0.5)
        pageControl.currentPage = iNum
        pageControl.isHidden = iNum == 4
    }
}


