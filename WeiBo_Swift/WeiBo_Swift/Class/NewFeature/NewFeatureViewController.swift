//
//  NewFeatureViewController.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/28.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

private let reuseIdentifier = "reuseIdentifier"

class NewFeatureViewController: UICollectionViewController {

    private let pageCnt = 4
    private var layout: UICollectionViewFlowLayout = NewfeatureLayout()
    init(){
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return pageCnt
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewFeatureCell
    
        cell.imageIndex = indexPath.item
        
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let path = collectionView.indexPathsForVisibleItems().last!
        
        if path.item == (pageCnt - 1) {
            let cell = collectionView.cellForItemAtIndexPath(path) as! NewFeatureCell
            cell.startBtnAnimation()

        }
    }
}

// swift中一个文件是可以定义多个类的
private class NewFeatureCell: UICollectionViewCell{
    
    /// 保存图片的索引
    var imageIndex: Int?{
        didSet{
            iconView.image = UIImage(named: "new_feature_\(imageIndex! + 1)")
            
        }
    }
    
    private func startBtnAnimation(){
    
        startButton.hidden = false
        
        // 执行动画
        startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        startButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(1.2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
            
            // 清空形变
            self.startButton.transform = CGAffineTransformIdentity
            }, completion: { (_) in
                self.startButton.userInteractionEnabled = true
                
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 初始化UI
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func startBtnClick() {

        NSNotificationCenter.defaultCenter().postNotificationName(ZJSwitchRootViewControllerKey, object: true)
    }
    
    private func setUpUI() {
        // 1、添加子控件到contentView上
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        // 布局子控件位置
        iconView.xmg_Fill(contentView)
        startButton.xmg_AlignInner(type: XMG_AlignType.BottomCenter, referView: contentView, size: nil, offset: CGPoint(x: 0, y: -160))
    }
    
    // MARK: - 懒加载
    private lazy var iconView = UIImageView()
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "new_feature_button"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: .Highlighted)
        btn.hidden = true
        
        btn.addTarget(self, action: #selector(startBtnClick), forControlEvents: .TouchUpInside)
        return btn
    }()
    
}

private class NewfeatureLayout: UICollectionViewFlowLayout {
    
    // 准备布局
    override func prepareLayout() {
        
        // 设置layout布局
        itemSize = UIScreen.mainScreen().bounds.size
        minimumInteritemSpacing = 0;
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        // 设置collectionView的属性
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
        
    }
}
















