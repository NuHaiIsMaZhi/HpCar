
//
//  myButton.swift
//  TouchIdDemo
//
//  Created by hasegroup on 2019/3/1.
//  Copyright © 2019年 hasegroup. All rights reserved.
//

import Foundation

@objcMembers
public class RedButton:UIButton{
    
    public var block:((Int) -> ())?
    
    public func setPrint(){
        
        block?(1231)
    }
}
