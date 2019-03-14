//
//  LAContext+Convenient.swift
//  SwiftDemo
//
//  Created by hasegroup on 2019/2/27.
//  Copyright © 2019年 hasegroup. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

extension LAContext {
    
    public func startEvaluate(reasonString:String,reply:@escaping(Bool,LAError?) -> Swift.Void) {
        
        if #available(iOS 8.0,macOS 10.12.1, *){
            
            var  authError : NSError?
            
            if canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError){
                
                evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reasonString){success,evaluateError in
                    
                    if success{
                        
                        reply(true,nil)
                    }else{
                        //User did not authenticate successfully,look at error and take appropriate action
                        
                        reply(false,(evaluateError as! LAError))
                    }
                }
            }else{
                
                //Could not evaluate policy;look at authError and appropriate message to user
                reply(false,LAError(_nsError: authError!))
            }
        }else{
            
            //Fallback on earlier versions
            
            fatalError("earlier versions does not support this function")
        }
    }
}
