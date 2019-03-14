//
//  MFBiomeTricsManger.swift
//  TouchIdDemo
//
//  Created by hasegroup on 2019/3/1.
//  Copyright © 2019年 hasegroup. All rights reserved.
//

import Foundation
import LocalAuthentication

let mfSingle = MFBiomeTricsManger()

@objcMembers
public class MFBiomeTricsManger : NSObject{
    
    public var sucessBlock:(() -> ())?
    public var appCancelBlock:(() -> ())?
    public var authenticationFailedBlock:(() -> ())?
    public var userCancelBlock:(() -> ())?
    public var userFallbackBlock:(() -> ())?
    public var systemCancelBlock:(() -> ())?
    public var passcodeNotSetBlock:(() -> ())?
    public var touchIDNotAvailableBlock:(() -> ())?
    public var touchIDNotEnrolledBlock:(() -> ())?
    public var touchIDLockoutBlock:(() -> ())?
    public var invalidContextBlock:(() -> ())?
    public var notInteractiveBlock:(() -> ())?
    public var unsupportBlock:(() -> ())?
    public var block:(() -> ())?
    public var startVerificationBlock:(() -> ())?
    
    public var myLAContext:LAContext?
    
    //单利模式
    class var sharedInstance : MFBiomeTricsManger {
        
        return mfSingle
    }
    
    public func mfVerification(){
        
        myLAContext = LAContext()            
        
        LAContext().startEvaluate(reasonString: "进行验证") { sucess, error in
            
            self.startVerificationBlock?()
            
            if sucess{
                self.sucessBlock?()
                print("User anthenticated scuessfully,take appropriate action")
            }else{
                switch error!.code{
                    
                case .appCancel:
                    print("appCancle")
                    self.appCancelBlock?()
                    break
                case .authenticationFailed:
                    print("authenticationFailed")
                    self.authenticationFailedBlock?()
                    break
                case .userCancel:
                    print("userCancel")
                    self.userCancelBlock?()
                    break
                case .userFallback:
                    print("userFallback")
                    self.userFallbackBlock?()
                    break
                    
                case .systemCancel:
                    print("systemCancel")
                    self.systemCancelBlock?()
                    break
                    
                case .passcodeNotSet:
                    print("passcodeNotSet")
                    self.passcodeNotSetBlock?()
                    break
                    
                case .touchIDNotAvailable:
                    print("touchIDNotAvailable")
                    self.touchIDNotAvailableBlock?()
                    break
                    
                case .touchIDNotEnrolled:
                    print("touchIDNotEnrolled")
                    self.touchIDNotEnrolledBlock?()
                    break
                    
                case .touchIDLockout:
                    print("touchIDLockout")
                    self.touchIDLockoutBlock?()
                    break
                    
                case .invalidContext:
                    print("invalidContext")
                    self.invalidContextBlock?()
                    break
                    
                case .notInteractive:
                    print("notInteractive")
                    self.notInteractiveBlock?()
                    break
                }
            }
        }
    }
}


//        var error: NSError?
//        myLAContext?.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
//        if #available(iOS 11.0, *){
//
//            if #available(iOS 11.2, *){
//
//                guard myLAContext?.biometryType != .none else{
//                    block?()
//                    //unsupport faceID and touchID
//                    self.unsupportBlock?()
//                    return
//                }
//            }else{
//
//                guard myLAContext?.biometryType != LABiometryType.LABiometryNone else{
//
//                    self.unsupportBlock?()
//                    return
//                }
//            }
//        }
