//
//  MySwiftVC.swift
//  TouchIdDemo
//
//  Created by hasegroup on 2019/2/28.
//  Copyright © 2019年 hasegroup. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication


class MySwiftVC: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myButton = UIButton.init(frame: CGRect(x: 150, y: 100, width: 100, height: 100))
        myButton.backgroundColor = .red
        self.view.addSubview(myButton)
        myButton.setTitle("点我，用力！", for: UIControl.State.normal)
        myButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        myButton.setTitleColor(UIColor.yellow, for: UIControl.State.normal)
        myButton.addTarget(self, action: #selector(buttonAction), for: UIControl.Event.touchUpInside)
        
    }
    
    func oneDelegateFunc() {
        
    }
    
    public func open(){
        
    }
    
    @objc func buttonAction(){
        
        let manger = MFBiomeTricsManger.sharedInstance
        manger.mfVerification()
        
        
        let myLAContext = LAContext()
        
        var error: NSError?
        myLAContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        if #available(iOS 11.0, *){
            
            if #available(iOS 11.2, *){
                
                guard myLAContext.biometryType != .none else{
                    
                    //unsupport faceID and touchID
                    return
                }
            }else{
                
                guard myLAContext.biometryType != LABiometryType.LABiometryNone else{
                    
                    return
                }
            }
        }
        LAContext().startEvaluate(reasonString: "进行验证") { sucess, error in
            
            if sucess{
                
                print("User anthenticated scuessfully,take appropriate action")
            }else{
                
                switch error!.code{
                    
                case .appCancel:
                    print("appCancle")
                    break
                case .authenticationFailed:
                    print("authenticationFailed")
                    break
                case .userCancel:
                    print("userCancel")
                    break
                    
                case .userFallback:
                    print("userFallback")
                    break
                    
                case .systemCancel:
                    print("systemCancel")
                    break
                    
                case .passcodeNotSet:
                    print("passcodeNotSet")
                    break
                    
                case .touchIDNotAvailable:
                    print("touchIDNotAvailable")
                    break
                    
                case .touchIDNotEnrolled:
                    print("touchIDNotEnrolled")
                    break
                    
                case .touchIDLockout:
                    print("touchIDLockout")
                    break
                    
                case .invalidContext:
                    print("invalidContext")
                    break
                    
                case .notInteractive:
                    print("notInteractive")
                    break
                }
            }
        }
    }
}
