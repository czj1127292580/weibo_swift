//
//  NSDate+Category.swift
//  WeiBo_Swift
//
//  Created by 岑志军 on 2016/9/26.
//  Copyright © 2016年 cen. All rights reserved.
//

import UIKit

extension NSDate{
    class func dateWithStr(time: String) -> NSDate {
        // 1、将服务器返回给我们的时间字符串转换为NSDate
        // 创建formatter
        let formatter = NSDateFormatter()
        // 设置时间格式
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z yyyy"
        // 设置时间的区域
        formatter.locale = NSLocale(localeIdentifier: "en")
        // 转换字符串，转换好的时间去除时区的时间
        let createDate = formatter.dateFromString(time)
        
        
        return createDate!
    }
    
    /**
     刚刚
     X分钟前
     X小时前
     昨天 HH:mm
     */
    var descDate: String{
        let calendar = NSCalendar.currentCalendar()
        
        // 判断是否是今天
        if calendar.isDateInToday(self) {
            // 1、获取当前时间和系统时间之间的差距（秒数）
            let since = Int(NSDate().timeIntervalSinceDate(self))
            
            // 判断是否为刚刚
            if since < 60 {
                return "刚刚"
            }
            // 判断是否为多少分钟前
            if since < 60 * 60 {
                return "\(since/60)分钟前"
            }
            // 判断是多少小时前
            return "\(since / (60 * 60))小时前"
            
            
        }
        
        // 判断是否为昨天
        var formatterStr = "HH:mm"
        if calendar.isDateInYesterday(self) {
            
            formatterStr = "昨天:" + formatterStr
            
        } else {
            // 处理一年以内
            formatterStr = "MM-dd " + formatterStr
            
            // 处理更早时间
            let comps = calendar.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            
            if comps.year >= 1 {
                // 一年以前
                formatterStr = "yyyy-" + formatterStr
            }
        }
        
        // 按照指定的格式来将时间转换为字符串
        // 创建formatter
        let formatter = NSDateFormatter()
        // 设置时间格式
        formatter.dateFormat = formatterStr
        // 设置时间的区域
        formatter.locale = NSLocale(localeIdentifier: "en")
        // 格式化
        return formatter.stringFromDate(self)
    }
    
}
