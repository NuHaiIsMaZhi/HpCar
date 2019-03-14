//
//  wodeSwift.swift
//  TouchIdDemo
//
//  Created by hasegroup on 2019/2/28.
//  Copyright © 2019年 hasegroup. All rights reserved.
//

import Foundation

import UIKit
import Foundation

@objc(EditTextFieldDelegate)
public protocol EditTextFieldDelegate:NSObjectProtocol {
    func editTextField(_ str: String) -> Void
}

@objcMembers
public class SecondViewController: UIViewController {
    public var block:((Int) -> ())?
    
    
    public var editorDelegate:EditTextFieldDelegate?
    typealias editorBlock = (_ t:String) -> ()
    var myEidtorBlock:editorBlock?
    
    var textField:UITextField?
    var addButton:UIButton?
    var pushButton:UIButton?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        textField = UITextField.init(frame: CGRect.init(x: 50, y: 60, width: 200, height: 50))
        textField?.placeholder = "输入返回首页的内容"
        self.view.addSubview(textField!)
        
        addButton = UIButton.init(type: .custom)
        addButton?.setTitleColor(UIColor.black, for: .normal)
        addButton?.setTitle("pop", for: .normal)
        addButton?.frame = CGRect.init(x: 50, y: 150, width: 200, height: 50)
        addButton?.layer.borderColor = UIColor.black.cgColor
        addButton?.layer.borderWidth = 1.0
        addButton?.addTarget(self, action: #selector(popAction), for: .touchUpInside)
        self.view.addSubview(addButton!)
        
        
        
        pushButton = UIButton.init(type: .custom)
        pushButton?.setTitleColor(UIColor.black, for: .normal)
        pushButton?.setTitle("push", for: .normal)
        pushButton?.frame = CGRect.init(x: 50, y: 250, width: 200, height: 50)
        pushButton?.layer.borderColor = UIColor.black.cgColor
        pushButton?.layer.borderWidth = 1.0
        pushButton?.addTarget(self, action: #selector(pushAction), for: .touchUpInside)
        self.view.addSubview(pushButton!)
        
    }
    
    @objc func popAction() -> Void {
        
        if editorDelegate != nil {
            editorDelegate?.editTextField((textField?.text)!)
        }
        
        if ((self.myEidtorBlock) != nil){
            self.myEidtorBlock!((textField?.text!)!)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func pushAction() -> Void {
    }
}
