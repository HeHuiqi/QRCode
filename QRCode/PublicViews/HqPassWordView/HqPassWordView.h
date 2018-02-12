//
//  HqPassWordView.h


#import <UIKit/UIKit.h>
@class HqPassWordView;

@protocol  HqPassWordViewDelegate<NSObject>

@optional
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(HqPassWordView *)passWord;

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(HqPassWordView *)passWord;

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(HqPassWordView *)passWord;


@end

IB_DESIGNABLE

@interface HqPassWordView : UIView<UIKeyInput>

@property (assign, nonatomic) IBInspectable NSUInteger passWordNum;//密码的位数
@property (assign, nonatomic) IBInspectable CGFloat squareWidth;//正方形的大小
@property (assign, nonatomic) IBInspectable CGFloat pointRadius;//黑点的半径
@property (strong, nonatomic) IBInspectable UIColor *pointColor;//黑点的颜色
@property (strong, nonatomic) IBInspectable UIColor *rectColor;//边框的颜色
@property (weak, nonatomic) IBOutlet id<HqPassWordViewDelegate> delegate;
@property (strong, nonatomic, readonly) NSMutableString *textStore;//保存密码的字符串
- (void)reInput;
@end
