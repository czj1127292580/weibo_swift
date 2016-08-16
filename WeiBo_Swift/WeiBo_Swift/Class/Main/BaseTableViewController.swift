//
//  BaseTableViewController.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/16.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    // 定义一个变量保存用户是否登录
    var userLogin = false
    
    override func loadView() {
        
        userLogin ? super.loadView() : setupVisitorView()
    }
    
    private func setupVisitorView(){
        let customView = VisitorView()
        view = customView

    }

    
}
