//
//  HomeTableViewController.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/15.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

let ZJHomeReuseIdentifier = "ZJHomeReuseIdentifier"

class HomeTableViewController: BaseTableViewController {

    // 保存微博数组
    var statuses = [Status]?(){
        didSet{
            // 当别人设置完数据，刷新表格
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 如果没有登录，就设置未登录界面的信息
        if !userLogin {
            visitorView?.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        // 初始化导航条
        setupNav()
        
        // 注册一个cell
        tableView.registerClass(StatusTableViewCell.self, forCellReuseIdentifier: ZJHomeReuseIdentifier)
        
//        tableView.rowHeight = 200
//        tableView.estimatedRowHeight = 200
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.rowHeight = 300
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        // 注册通知，监听菜单
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(change), name: XMGPopoverAnimatorWillShow, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(change), name: XMGPopoverAnimatorWillDismiss, object: nil)
        
        // 加载微博数据
        loadData()
    }

    /**
     获取微博数据
     */
    private func loadData(){
     
        Status.loadStatuses { (models, error) in
            
            if error != nil{
                return
            }
            self.statuses = models
        }
    }
    
    // 相当于OC只能给的dealloc
    deinit{
        // 移除通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    /**
     修改标题按钮的状态
     */
    func change() {
        // 修改标题按钮的状态
        let titleBtn = navigationItem.titleView as! TitleButton
        titleBtn.selected = !titleBtn.selected
        
    }
    
    private func setupNav() {
        
        navigationItem.leftBarButtonItem =  UIBarButtonItem.createBarButtonItem("navigationbar_friendattention", target: self, action: #selector(leftItemClick))
        
        navigationItem.rightBarButtonItem =  UIBarButtonItem.createBarButtonItem("navigationbar_pop", target: self, action: #selector(rightItemClick))
        
        // 初始化标题按钮
        let titleBtn = TitleButton()
        titleBtn.setTitle("岑志军 ", forState: UIControlState.Normal)
        titleBtn.addTarget(self, action: #selector(titleBtnClick), forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn;
        
        
    }
    
    func titleBtnClick(btn: TitleButton) {
//        btn.selected = !btn.selected
        
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        
        // 1、设置转场代理
        // 默认情况下modal会移除以前控制器的view，替换为当前弹出的view
        // 如果自定义转场，那么就不会移除以前控制器的view
        vc?.transitioningDelegate = popoverAnimator
        // 2、设置转场的样式
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(vc!, animated: true, completion: nil)
        
        
    }
    
    func leftItemClick() {
        print(#function)
    }

    func rightItemClick() {
//        print(#function)
        let sb = UIStoryboard(name: "QRCodeViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        presentViewController(vc!, animated: true, completion: nil)
        
        
    }

    // MARK: - 懒加载
    // 一定要定义一个属性来保存自定义转场对象，否则会报错
    private lazy var popoverAnimator:PopoverAnimator = {
    
        let pa = PopoverAnimator()
        pa.presentFrame = CGRectMake(100, 56, 200, 350)
        return pa
    }()
    
    /// 微博行高的缓存, 利用字典作为容器. key就是微博的id, 值就是对应微博的行高
    var rowCache: [Int: CGFloat] = [Int: CGFloat]()
    
    override func didReceiveMemoryWarning() {
        // 清空缓存
        rowCache.removeAll()
    }
}

extension HomeTableViewController{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ZJHomeReuseIdentifier, forIndexPath: indexPath) as! StatusTableViewCell
        let status = statuses![indexPath.row]
//        cell.textLabel?.text = status.text
        cell.status = status
        return cell
    }
    
    // 返回行高
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        // 1.取出对应行的模型
        let status = statuses![indexPath.row]
        
        // 2.判断缓存中有没有
        if let height = rowCache[status.id]
        {
            print("从缓存中获取")
            return height
        }
        
        // 3.拿到cell
        let cell = tableView.dequeueReusableCellWithIdentifier(ZJHomeReuseIdentifier) as! StatusTableViewCell
        // 注意点:不要使用以下方法获取, 在某些版本或者模拟器会有bug
        //        tableView.dequeueReusableCellWithIdentifier(<#T##identifier: String##String#>, forIndexPath: <#T##NSIndexPath#>)
        
        // 4.拿到对应行的行高
        let rowHeight = cell.rowHeight(status)
        
        // 5.缓存行高
        rowCache[status.id] = rowHeight
        print("重新计算")
        
        // 6.返回行高
        return rowHeight
    }
}
