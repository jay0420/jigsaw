//
//  JKUIImageExtension.swift
//  JKPinTu-Swift
//
//  Created by bingjie-macbookpro on 15/12/15.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

import Foundation
import UIKit



extension UIImage
{
    /*!
    切割图片
    
    - parameter image: 需要切割的图片
    - parameter rect:  位置
    - returns: 切割后的图
    */
    public class func clipImage(_ image:UIImage,withRect rect:CGRect) ->UIImage{
        let cgImage = image.cgImage?.cropping(to: rect)
        return UIImage(cgImage: cgImage!)
    }
    
    
    /*!
    根据颜色生成图片
    
    - parameter color: UIColor
    - parameter size:  CGSize
    
    - returns: UIImage
    */
    public class func imageFromColor(_ color:UIColor,size:CGSize) -> UIImage{
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!;
    }
    
}

