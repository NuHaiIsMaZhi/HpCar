//
//  SayHello.swift
//  oc2swift
//
//  Created by hahand on 2019/2/28.
//  Copyright © 2019 hahand. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

@objc
public protocol myDelegate:NSObjectProtocol {

    @objc func oneDelegateFunc()
}

@objcMembers
public class SpeakerObjc : NSObject {
   
    var delegate:myDelegate?
    
    func evssaluate(reasonString:String,reply:@escaping(Bool,LAError?) -> Swift.Void) {
        
        reply(true,nil)
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

