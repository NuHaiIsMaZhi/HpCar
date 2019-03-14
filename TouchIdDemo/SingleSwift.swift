//
//  SingleSwift.swift
//  TouchIdDemo
//
//  Created by hasegroup on 2019/3/1.
//  Copyright © 2019年 hasegroup. All rights reserved.
//

import Foundation
import LocalAuthentication

let single = SingleThree()

@objc
public protocol theDelegate:NSObjectProtocol {
    
    @objc func oneDelegateFunc()
}

@objcMembers
public class SingleThree : NSObject{
    
    var delegate:theDelegate?

    class var sharedInstance : SingleThree {
        return single
    }
    
    @objc func buttonAction(){
        
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
                self.delegate?.oneDelegateFunc()
                
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
