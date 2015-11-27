//
//  KeyboardObserver.m
//  Created by JPH on 15/11/26.
//  Copyright © 2015年 jph. All rights reserved.
//  Email: crazycodeboy@gmail.com
//

#import "KeyboardObserver.h"
@implementation UIView (KeyboardHandler)
UIView *rootView;
NSMutableArray*inputTextFields;
#pragma mark - Public Methods
-(void)addKeyboardObserver{
     [self registerKeyboardNotifications];
    if (inputTextFields==nil) {
        inputTextFields=[[NSMutableArray alloc] init];
    }
    [inputTextFields addObject:self];
    [(id)self setDelegate:self];
}
-(void)removeKeyboardObserver{
    [inputTextFields removeObject:self];
    [self removeKeyboardNotifications];
}
-(void)addSimpleKeyboardObserver{
    [self registerKeyboardNotifications];
    if (inputTextFields==nil) {
        inputTextFields=[[NSMutableArray alloc] init];
    }
    [inputTextFields addObject:self];
}
-(void)addGlobalKeyboardObserver{
    if (inputTextFields==nil) {
        inputTextFields=[[NSMutableArray alloc] init];
    }
    [self addAllInputTextField:[self getRootView]];
}
/**
 *递归遍历界面中所有的UIView，找出所有的UITextField<br>
 * 并为UITextField注册键盘监听和委托
 **/
-(void)addAllInputTextField:(UIView*)rootView{
    for (UIView *subView in rootView.subviews) {
        if (subView.subviews!=nil) {
            [self addAllInputTextField:subView];
        }
        if ([subView isKindOfClass:[UITextField class]]){
            [self registerKeyboardNotifications];
            [(id)subView setDelegate:self];
            [inputTextFields addObject:subView];
        }
    }
}
-(void)removeGlobalKeyboardObserver{
    [inputTextFields removeAllObjects];
    [self removeKeyboardNotifications];
}
#pragma mark - Keyboad Notification Methods
- (void)registerKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:self];
}
- (void)keyboardWillShow:(NSNotification *)notification{
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    UITextField*firstResponderTextField=[self getFirstResponderTextField];
    CGFloat offset = (firstResponderTextField.frame.origin.y+firstResponderTextField.frame.size.height+20) - ([self getRootView].frame.size.height - kbHeight);
    
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            [self getRootView].frame = CGRectMake(0.0f, -offset, [self getRootView].frame.size.width, [self getRootView].frame.size.height);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notify{
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        [self getRootView].frame = CGRectMake(0, 0, [self getRootView].frame.size.width, [self getRootView].frame.size.height);
    }];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [[self getFirstResponderTextField] resignFirstResponder];
    return true;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self getFirstResponderTextField] resignFirstResponder];
}
/**
 * 获取获得焦点的输入框
 **/
-(UITextField*)getFirstResponderTextField{
    __block UITextField*firstResponderTextField=nil;
    [inputTextFields enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (((UITextField*)obj).isFirstResponder) {
            firstResponderTextField=obj;
            *stop=YES;
        }
    }];
    return firstResponderTextField;
}
/**
 * 获取当前界面的根View
 **/
-(UIView*)getRootView{
    if (rootView!=nil)return rootView;
    UIView*superView;
    UIView*targetView=self;
    while (true) {
        superView=targetView.superview;
        if (superView==nil) {
            superView=targetView;
            break;
        }else{
            targetView=superView;
        }
    }
    return rootView=superView;
}

@end
