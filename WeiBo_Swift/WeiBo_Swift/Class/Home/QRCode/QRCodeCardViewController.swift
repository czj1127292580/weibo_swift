//
//  QRCodeCardViewController.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 16/8/24.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

class QRCodeCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "我的名片"
        view.addSubview(iconView)
        iconView.xmg_AlignInner(type: XMG_AlignType.Center, referView: view, size: CGSizeMake(200, 200))
        
        let qrcodeImage = createQRCodeImage()
        
        iconView.image = qrcodeImage
        
    }
    
    private func createQRCodeImage() -> UIImage?{
        
        // 1.创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        
        
        // 2、还原滤镜默认属性
        filter?.setDefaults()
        
        // 3、设置需要生成的二维码数据
        filter?.setValue("岑志军".dataUsingEncoding(NSUTF8StringEncoding), forKey: "inputMessage")
        
        // 4、从滤镜中取出生成好的图片
        let ciImage = filter?.outputImage
        
        // 这个方法生层的图片比较模糊
//        return UIImage(CIImage: ciImage!)
        let bgImage = createNonInterpolatedUIImageFormCIImage(ciImage!, size: 300)
        
        // 5、创建一个头像
        let icon = UIImage(named: "czj.jpg")
        
        
        // 6、合成图片（将二维码和头像进行合并）
        let newImage = createImage(bgImage, iconImage: icon!)
        
        // 7、返回生成好的二维码
        return newImage
    }
    
    /**
    合成图片
     
     - parameter bgImage:   背景图片
     - parameter iconImage: 头像
     */
    private func createImage(bgImage: UIImage, iconImage: UIImage) -> UIImage {
    
        // 1、开启图片上下文
        UIGraphicsBeginImageContext(bgImage.size)
        
        // 2、绘制背景图片
        bgImage.drawInRect(CGRect(origin: CGPointZero, size: bgImage.size))
        
        // 3、绘制头像
        let width: CGFloat = 50

        let height: CGFloat = width
        let x = (bgImage.size.width - width) * 0.5
        let y = (bgImage.size.height - height) * 0.5
        iconImage.drawInRect(CGRect(x: x, y: y, width: width, height: height))
        
        // 4、取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // 5、关闭上下文
        UIGraphicsEndImageContext()
        
        // 6、返回合成好的图片
        return newImage!
        
    }
    
    /**
     根据CIImage生成指定大小的高清UIImage
     
     :param: image 指定CIImage
     :param: size    指定大小
     :returns: 生成好的图片
     */
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = CGRectIntegral(image.extent)
        let scale: CGFloat = min(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent))
        
        // 1.创建bitmap;
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)!
        
        CGContextSetInterpolationQuality(bitmapRef,  CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        // 2.保存bitmap到图片
        let scaledImage: CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        
        return UIImage(CGImage: scaledImage)
    }
    
    // MARK: - 懒加载
    private lazy var iconView: UIImageView = UIImageView()

}
