//
//  KeyboardObserver.h
//
//  Ios软盘和输入框自适应<br>
//  当软盘弹出时自动控制输入框的显示位置以防止被软盘遮住<br>
//  当触控输入框以外的位置时或按软盘的回车键时，软盘隐藏，界面恢复
//  Created by JPH on 15/11/26.
//  Copyright © 2015年 jph. All rights reserved.
//  Email: crazycodeboy@gmail.com
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (KeyboardObserver)<UITextFieldDelegate>
/**
 *  为界面中所有的输入框添加键盘观察器，回车键监听，触控其他区域监听
 *  请在 'viewDidAppear' 方法中应用
 */
-(void)addGlobalKeyboardObserver;
/**
 *  为界面中所有的输入框移除键盘观察器，回车键监听，触控其他区域监听
 *  请在 'viewDidDisappear'' 方法中应用
 */
-(void)removeGlobalKeyboardObserver;
/**
 *  为指定输入框添加键盘观察器,回车键监听，触控其他区域监听
 *  请在 'viewDidAppear' 方法中应用
 */
- (void)addKeyboardObserver;

/**
 *  为指定输入框移除键盘观察器，回车键监听，触控其他区域监听
 *  请在 'viewDidDisappear'' 方法中应用
 */
- (void)removeKeyboardObserver;
/**
 * 为指定输入框添加键盘观察器，触控其他区域监听
 * 请在 'viewDidDisappear'' 方法中应用
 */
- (void)addSimpleKeyboardObserver;
@end


