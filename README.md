#Ios软盘和输入框自适应  

效果演示：
![image](https://github.com/crazycodeboy/KeyboardObserver/blob/master/res/%E8%BD%AF%E7%9B%98%E9%94%AE%E7%9B%98%E8%87%AA%E9%80%82%E5%BA%94.gif =203x380)
 
###特点：
1.当软盘弹出时自动控制输入框的显示位置以防止被软盘遮住  
2.当触控输入框以外的位置时或按软盘的回车键时，软盘隐藏，界面恢复   
3.支持对整个页面所有的输入框添加监听和移除监听    
4.支持对指定输入框的添加监听和移除监听    
5.使用简单，只需一行代码便可完成监听配置  

###使用说明： 
1.将KeyboardObserver.m和KeyboardObserver.h导入项目中   
2.导入头文件#import "KeyboardObserver.h"  
3.调用相应方法为输入框绑定监听
###相关方法说明：
 
`-(void)addGlobalKeyboardObserver`  
为界面中所有的输入框添加键盘观察器，回车键监听，触控其他区域监听, 建议在 'viewDidAppear' 方法中应用。  
`-(void)removeGlobalKeyboardObserver`  
为界面中所有的输入框移除键盘观察器，回车键监听，触控其他区域监听，建议在 'viewDidDisappear' 方法中应用。  
`- (void)addKeyboardObserver`	  
为指定输入框添加键盘观察器,回车键监听，触控其他区域监听，建议在 'viewDidAppear' 方法中应用。   
`- (void)removeKeyboardObserver`  
为指定输入框移除键盘观察器，回车键监听，触控其他区域监听，建议在 'viewDidDisappear' 方法中应用。   
`- (void)addSimpleKeyboardObserver`    
 为指定输入框廷加键盘观察器，触控其他区域监听，建议在 'viewDidDisappear' 方法中应用。   
`- (void)removeKeyboardObserver`    
 为指定输入框移除键盘观察器，触控其他区域监听，建议在 'viewDidDisappear' 方法中应用。对应的移除监听方法请调用。   