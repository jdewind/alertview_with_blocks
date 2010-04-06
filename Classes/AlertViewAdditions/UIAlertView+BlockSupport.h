
typedef void (^AlertActionBlock)(UIAlertView *alertView, NSUInteger buttonIndex);
typedef void (^AlertBlock)(UIAlertView *alertView);

@class AlertViewBlockDelegate;
typedef void (^AlertDelegateBlock)(AlertViewBlockDelegate *delegate);

@interface AlertViewBlockDelegate : NSObject<UIAlertViewDelegate>
{
  AlertActionBlock buttonClickedBlock;
  AlertActionBlock dismissedBlock;
  AlertActionBlock willDismissBlock;
  AlertBlock cancelledBlock;
  AlertBlock presentedBlock;
  AlertBlock willPresentBlock;
}

@property(copy) AlertActionBlock buttonClickedBlock;
@property(copy) AlertActionBlock dismissedBlock;
@property(copy) AlertActionBlock willDismissBlock;
@property(copy) AlertBlock cancelledBlock;
@property(copy) AlertBlock presentedBlock;
@property(copy) AlertBlock willPresentBlock;


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)alertViewCancel:(UIAlertView *)alertView;
- (void)didPresentAlertView:(UIAlertView *)alertView;
- (void)willPresentAlertView:(UIAlertView *)alertView;
@end


@interface UIAlertView(BlockSupport) 
+(id)build:(AlertDelegateBlock)delegateBlock;
+(void)show:(NSString *)title message:(NSString *)message button:(NSString *)button whenDismissed:(AlertActionBlock)block;
@end
