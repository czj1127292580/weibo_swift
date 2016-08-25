//
//  OAuthViewController.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/25.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    let WB_App_key = "1684485375"
    let WB_App_Secret = "62de959eb4a3d4c74c250220350bea47"
    let WB_redirect_uri = "http://www.baidu.com"
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化导航条
        navigationItem.title = "军哥的战斗机"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(close))
        
        // 1、获取未授权的RequestToken
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_App_key)&redirect_uri=\(WB_redirect_uri)"
        let url = NSURL(string: urlStr)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
        
    }
    
    func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - 懒加载
    private lazy var webView: UIWebView = {
        let wv = UIWebView()
        wv.delegate = self
        return wv
    }()
}

extension OAuthViewController: UIWebViewDelegate{
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        
        // 判断是否是授权回调页，如果不是继续加载
        let urlStr = request.URL!.absoluteString
        
        if !urlStr.hasPrefix(WB_redirect_uri) {
            
            return true
        }
        
        // 判断是否授权成功
        let codeStr = "code="
        if request.URL!.query!.hasPrefix(codeStr) {
            // 代表授权成功
            // 取出已经授权的RequestToken
           let code = request.URL!.query!.substringFromIndex(codeStr.endIndex)
            print(code)
        } else {
            // 授权失败
            close()
            
        }
        
        return false
    }
}











