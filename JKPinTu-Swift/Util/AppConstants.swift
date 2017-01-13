//
//  AppConstants.swift
//  PingTu-swift
//
//  Created by bingjie-macbookpro on 15/12/8.
//  Copyright © 2015年 Bingjie. All rights reserved.
//

import Foundation
import UIKit
import SwiftyBeaver

//let jk_log = SwiftyBeaver.self
let jacklog = SwiftyBeaver.self


let SCREEN_BOUNDS = UIScreen.main.bounds
let SCREEN_WIDTH  = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let STATUSBARHEIGHT  = CGFloat(20)
let TOPBARHEIGHT     = CGFloat(44)
let BOTTOMHEIGHT  = CGFloat(49)


/*!
生成随机数 x ,  start <= x < end

- parameter start: start
- parameter end:   end

- returns: arc4random
*/
func arc4randomInRange(_ start:Int ,to end:Int)->Int{
    let count = UInt32(end - start)
    return  Int(arc4random_uniform(count)) + start
}


public func JKLog(_ items: Any...){
    print(items)
}
