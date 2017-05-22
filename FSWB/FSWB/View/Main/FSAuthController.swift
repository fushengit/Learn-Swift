//
//  FSAuthController.swift
//  FSWB
//
//  Created by 123 on 17/5/22.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit
import SVProgressHUD



class FSAuthController: UIViewController {

    lazy var webView:UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"navigationbar_back_highlighted")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(closeAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充", style: .plain, target: self, action: #selector(automicFixin))
        navigationItem.title = "授权登录"
        navigationController?.navigationBar.tintColor = UIColor.orange
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.orange]
        

        guard let url = URL(string: "https://api.weibo.com/oauth2/authorize?client_id=\(WBclient_id)&redirect_uri=\(WBredirect_uri)")
        else {
            return
        }
        webView.loadRequest(URLRequest(url: url))
        webView.delegate = self
        webView.scrollView.isScrollEnabled = false
    }
    
    override func loadView() {
        view = webView
    }
    
    @objc func closeAction(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func automicFixin(){
        //FIXME: 这里填自己的账号密码哇！！！
        let userName = "12345678"
        let password = "123456"
        
        let js = "document.getElementById(\"userId\").value = \(userName);"+"document.getElementById(\"passwd\").value = \(password)"
        webView.stringByEvaluatingJavaScript(from: js)
    }
}

extension FSAuthController:UIWebViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        print("即将请求页面absoluteString \(request.url?.absoluteString ?? "")")
        print("即将请求页面query \(request.url?.query ?? "")")

        //这里判断是否前缀包含“www.myzhenzhen.com”
        if request.url?.absoluteString.hasPrefix(WBredirect_uri) == false{
            //加载的还是新浪的web页，让继续加载
            return true
        }
        //不含授权码
        if request.url?.query?.hasPrefix("code=") == false {
            closeAction()
            return false
        }
        //这里表示已经拿到了授权码
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        FSNetWorkManager.shared.requestOauthToken(code: code) { (isSucc) in
            if isSucc{
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotifycationLoginSucc), object: nil)
                self.closeAction()
            }else{
                SVProgressHUD.showInfo(withStatus: "网络请求失败")
            }
        }
        return false
    }
}
