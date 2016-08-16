//
//  VisitorView.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/16.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class VisitorView: UIView {

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
        return btn
    }()
    
    /// 注册按钮
    private lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        return btn
    }()
    
    private lazy var maskBGView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return iv
    }()
    
    
}
