//
//  ViewController.h
//  TouchIdDemo
//
//  Created by hasegroup on 2019/2/28.
//  Copyright © 2019年 hasegroup. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RefreshHintLabelBlock)(NSString *hintString);

@interface ViewController : UIViewController

@property (nonatomic,copy)void(^mublocl)(NSInteger kkk);
@property (nonatomic, copy) RefreshHintLabelBlock hintBlock;

@end

