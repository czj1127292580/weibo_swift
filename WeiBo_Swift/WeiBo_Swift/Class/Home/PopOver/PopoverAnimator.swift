//
//  PopoverAnimator.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/21.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

// 定义常量保存通知的名称
let XMGPopoverAnimatorWillShow = "XMGPopoverAnimatorWillShow"
let XMGPopoverAnimatorWillDismiss = "XMGPopoverAnimatorWillDismiss"


class PopoverAnimator: NSObject ,UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning{
    
    // 记录当前是否展开
    var isPresent: Bool = false
    // 定义属性保存菜单的大小
    var presentFrame = CGRectZero
    
    
    // 实现代理方法,告诉系统谁来负责专场动画
    // UIPresentationController iOS8推出的专门用于负责转场动画的
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController?, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        let pc = PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting!)
        
        // 设置菜单的大小
        pc.presentFrame = presentFrame
        return pc
    }
    
    // MARK: - 只要实现了一下方法，那么系统自带的默认动画就没有了，所有东西都需要自己实现
    /**
     告诉系统谁来负责modal的展现动画
     
     - parameter presented:  被展现的视图
     - parameter presenting: 发起的视图
     - parameter source:     <#source description#>
     
     - returns: 谁来负责
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresent = true
        
        // 发送通知，通知控制器即将展开
        NSNotificationCenter.defaultCenter().postNotificationName(XMGPopoverAnimatorWillShow, object: self)
        return self
    }
    
    /**
     告诉系统谁来负责modal的消失动画
     
     - parameter dismissed: 被关闭的视图
     
     - returns: 谁来负责
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        
        // 发送通知，通知控制器即将消失
        NSNotificationCenter.defaultCenter().postNotificationName(XMGPopoverAnimatorWillDismiss, object: self)
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    /**返回动画时长
     
     - parameter transitionContext: 上下文，里面保存了动画需要的所有参数
     
     - returns: 动画时长
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    /**
     告诉系统如何动画，无论展现还是消失都会调用这个方法
     
     - parameter transitionContext: 上下文，里面保存了动画需要的所有参数
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // 拿到展现视图
        //        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        //
        //        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        // 展开
        if isPresent {
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
            
            // 压缩视图
            toView?.transform = CGAffineTransformMakeScale(1.0, 0.0)
            
            // 注意：一定要将视图添加到容器上
            transitionContext.containerView().addSubview(toView!)
            
            // 设置锚点
            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            // 执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                
                // 清空transform
                toView?.transform = CGAffineTransformIdentity
                
            }) { (_) in
                // 动画执行完毕，一定要告诉系统
                // 如果不写，可能会导致一些未知错误
                transitionContext.completeTransition(true)
            }
        } else {
            
            // 关闭
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                // 注意：由于CGfloat是不准确的，所以如果写0.0会没有动画
                // 压扁
                fromView?.transform = CGAffineTransformMakeScale(1.0, 0.00000001)
                
                }, completion: { (_) in
                    // 如果不写，可能会导致一些未知错误
                    transitionContext.completeTransition(true)
            })
        }
        
        
        
        
    }
}
