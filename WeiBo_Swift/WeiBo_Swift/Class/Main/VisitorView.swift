//
//  VisitorView.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/16.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

// swift中如何定义协议: 必须遵守NSObjectProtocol
protocol VisitorViewDelegate : NSObjectProtocol{
    // 登录回调
    func loginBtnWillClick()
    // 注册回调
    func regiserBtnWillClick()

}

class VisitorView: UIView {
    
    // 定义一个属性保存代理对象
    // 一定要加上weak， 避免循环引用
    weak var delegate: VisitorViewDelegate?
    
    /**
     设置未登陆界面
     
     - parameter isHome:    是都是首页
     - parameter imageName: 图片
     - parameter message:   文本
     */
    func setupVisitorInfo(isHome:Bool, imageName:String, message:String){
        // 如果不是首页，就隐藏转盘
        iconView.hidden = !isHome
        homeIcon.image = UIImage(named: imageName)
        messageLabel.text = message
        
        // 判断是否需要执行动画
        if isHome {
            startAnimation()
        }
    }
    
    func loginBtnClick(){
        delegate?.loginBtnWillClick()
    }
    
    func regiserBtnClick(){
        delegate?.regiserBtnWillClick()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView)
        addSubview(maskBGView)
        addSubview(homeIcon)
        addSubview(messageLabel)
        addSubview(loginButton)
        addSubview(registerButton)
        
        iconView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
        homeIcon.xmg_AlignInner(type: .Center, referView: self, size: nil)
        messageLabel.xmg_AlignVertical(type: XMG_AlignType.BottomCenter, referView: iconView, size: nil)
        
        // 那个控件的什么属性等于另外一个控件的什么属性 乘以多少加上多少
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224))
        
        registerButton.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: messageLabel, size: CGSize(width: 100, height: 30), offset: CGPoint(x: 0, y: 20))
        loginButton.xmg_AlignVertical(type: XMG_AlignType.BottomRight, referView: messageLabel, size: CGSize(width: 100, height: 30), offset: CGPoint(x: 0, y: 20))
        maskBGView.xmg_Fill(self)

        
        
    }
    
    // swift推荐我们自定义一个控件，要么用纯代码，要么用xib/storyboard
    required init?(coder aDecoder: NSCoder) {
        // 如果通过xib/storyboard创建该类，那么就会崩溃
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 内部控制方法
    private func startAnimation(){
        // 1、创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        // 2、设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 20
        anim.repeatCount = MAXFLOAT
        // 该属性默认为YES，代表动画只要执行完毕就移除
        anim.removedOnCompletion = false
        // 3、将动画添加到图层上
        iconView.layer.addAnimation(anim, forKey: nil)
        
    }
    
    // MARK: - 懒加载
    ///转盘
    private lazy var iconView: UIImageView = {
    
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return iv
    }()
    
    /// 图标
    private lazy var homeIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return iv
    }()
    
    /// 文本
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "分DVD分V地方V地方V的风格让"
        label.numberOfLines = 0
        label.textColor = UIColor.darkGrayColor()
        return label
    }()
    
    /// 登录按钮
    private lazy var loginButton: UIButton = {
    let btn = UIButton()
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(loginBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    /// 注册按钮
    private lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(regiserBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    private lazy var maskBGView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return iv
    }()
    
    
}
