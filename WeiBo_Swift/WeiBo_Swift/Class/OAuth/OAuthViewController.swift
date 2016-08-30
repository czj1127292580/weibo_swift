//
//  OAuthViewController.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/25.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit
import SVProgressHUD

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

            // 利用已经授权的RequestToken换取AccessToken
            loadAccessToken(code)
        
        } else {
            // 授权失败
            close()
            
        }
        
        return false
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        // 提示用户正在加载
//        SVProgressHUD.showInfoWithStatus("正在加载...", maskType: SVProgressHUDMaskType.Black)
        SVProgressHUD.showInfoWithStatus("正在加载...")
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.Black)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // 关闭提示
        SVProgressHUD.dismiss()
    }
    
    private func loadAccessToken(code: String) {
    
        // 定义路径h
        let path = "oauth2/access_token"
        
        // 封装参数
        let params = ["client_id":WB_App_key,
                      "client_secret":WB_App_Secret,
                      "grant_type":"authorization_code",
                      "code":code,
                      "redirect_uri":WB_redirect_uri]
        
        // 发送post请求
//        NetWorkTools.shareNetWorkTools().POST(path, parameters: params, success: { (_, JSON) in
//            print(JSON)
//            }) { (_, error) in
//                print(error)
//        }
        
        NetWorkTools.shareNetWorkTools().POST(path, parameters: params, progress: nil, success: { (_, JSON) in
            
            /**
             *  同一个用户对同一个应用程序授权多次access_token是一样的
             每个access_token都是有过期时间的：
             1、如果自己对自己的应用程序进行授权，有效时间是5年差一天
             2、如果是其他人对你的应用程序进行授权，有效期是3天
             */
//            "access_token" = "2.001s2jaDxavzpBbf04ba92e6Fk8irC";
//            "expires_in" = 157679999;
//            "remind_in" = 157679999;
//            uid = 3291155444;
            
//            print(JSON)
            
            let account = UserAccount(dict: JSON as! [String : AnyObject])
            
            // 获取用户信息
//            account.loadUserInfo()
            account.loadUserInfo({ (account, error) in
                if account != nil{
                    account?.saveAccount()

                    NSNotificationCenter.defaultCenter().postNotificationName(ZJSwitchRootViewControllerKey, object: false)
                    return
                }
                SVProgressHUD.showInfoWithStatus("网络不给力...", maskType: SVProgressHUDMaskType.Black)
            })
            
            // 由于加载数据是异步的，所以不能在这里保存用户信息
//            // 归档模型
//            account.saveAccount()
            
            }) { (_, error) in
                
                print(error)
        }
        
        
    }
}











