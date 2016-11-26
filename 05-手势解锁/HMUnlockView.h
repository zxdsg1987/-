//
//  HMUnlockView.h
//  05-手势解锁
//
//  Created by JackMeng on 2016/11/10.
//  Copyright © 2016年 JackMeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMUnlockView;
@protocol HMUnlockViewDelegate <NSObject>

- (BOOL)unlockView:(HMUnlockView *)unlockView withPwd:(NSString *)
pwd;
@end

@interface HMUnlockView : UIView
@property (nonatomic,weak) id<HMUnlockViewDelegate> delegate;
@end
