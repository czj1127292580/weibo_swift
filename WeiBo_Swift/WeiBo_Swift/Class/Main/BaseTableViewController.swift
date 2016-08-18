//
//  BaseTableViewController.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/16.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController, VisitorViewDelegate {

    // 定义一个变量保存用户是否登录
    var userLogin = true
    
    // 定义属性保存未登录界面
    var visitorView: VisitorView?
    
    
    override func loadView() {
        
        userLogin ? super.loadView() : setupVisitorView()
    }
    
    private func setupVisitorView(){
        // 1、初始化未登录界面
        let customView = VisitorView()
        customView.delegate = self
        view = customView
        visitorView = customView
        
        // 2、设置导航条未登录按钮
//        navigationController?.navigationBar.tintColor = UIColor.orangeColor()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(regiserBtnWillClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(loginBtnWillClick))

    }

    func loginBtnWillClick() {
        print(#function)

    }
    
    func regiserBtnWillClick() {
        print(#function)

    }
    
}
