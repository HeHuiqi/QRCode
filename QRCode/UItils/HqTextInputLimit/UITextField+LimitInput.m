//
//  UITextField+LimitInput.m
//  OC-Use
//
//  Created by macpro on 2017/5/10.
//  Copyright © 2017年 macpro. All rights reserved.
//

#import "UITextField+LimitInput.h"
#import <objc/runtime.h>
#import <objc/message.h>

/**
 已经别交换过得类集合
 */
static NSMutableSet *swizzledClasses() {
    static dispatch_once_t onceToken;
    static NSMutableSet *swizzledClasses = nil;
    dispatch_once(&onceToken, ^{
        swizzledClasses = [[NSMutableSet alloc] init];
    });
    
    return swizzledClasses;
}
// key 要初始化
void * kMaxLengthkey = "MaxLengthkey";

@implementation UITextField (LimitInput)


- (void)setMaxLength:(NSUInteger)maxLength{
    
    NSLog(@"===maxLength %@",@(maxLength));
    objc_setAssociatedObject(self, kMaxLengthkey, @(maxLength).copy, OBJC_ASSOCIATION_ASSIGN);
    [self limitInput];
    
}
- (NSUInteger)maxLength{
    NSNumber *number = (NSNumber *)objc_getAssociatedObject(self, kMaxLengthkey);
    NSLog(@"number == %@",number);
    return [number integerValue];
}
- (void)limitInput{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self];
    [self swizzleDeallocIfNeeded];
}
-(void)loginTextFieldDidChange:(NSNotification *)obj{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    UITextInputMode *inputMode = textField.textInputMode;
  
    NSString *lang = [inputMode primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];       //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > self.maxLength) {
                textField.text = [toBeString substringToIndex:self.maxLength];
            }
        }       // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
            
        }
    }else{
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > self.maxLength) {
            textField.text = [toBeString substringToIndex:self.maxLength];
        }
    }
}
/**
 Runtime交换dealloc方法，用于释放监听数据
 */
- (void)swizzleDeallocIfNeeded{
    @synchronized (swizzledClasses()) {
        
        Class classToSwizzle = object_getClass(self);
        
        NSString *className = NSStringFromClass(classToSwizzle);
        if ([swizzledClasses() containsObject:className]) return;
        
        SEL deallocSelector = sel_registerName("dealloc");
        
        __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
        
        id newDealloc = ^(__unsafe_unretained id self) {
            
            //在这里移除监听器
            //            NSLog(@"-------在这里移除监听器--className = %@",className);
            [self removeObservers];
            
            if (originalDealloc == NULL) {
                struct objc_super superInfo = {
                    .receiver = self,
                    .super_class = class_getSuperclass(classToSwizzle)
                };
                
                void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                msgSend(&superInfo, deallocSelector);
            } else {
                originalDealloc(self, deallocSelector);
            }
        };
        
        IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
        
        if (!class_addMethod(classToSwizzle, deallocSelector, newDeallocIMP, "v@:")) {
            // The class already contains a method implementation.
            Method deallocMethod = class_getInstanceMethod(classToSwizzle, deallocSelector);
            
            // We need to store original implementation before setting new implementation
            // in case method is called at the time of setting.
            originalDealloc = (__typeof__(originalDealloc))method_getImplementation(deallocMethod);
            
            // We need to store original implementation again, in case it just changed.
            originalDealloc = (__typeof__(originalDealloc))method_setImplementation(deallocMethod, newDeallocIMP);
        }
        
        [swizzledClasses() addObject:className];
    }
}
/**
 移除监听属性及监听器
 */
- (void)removeObservers{
    NSLog(@"delloc======");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
