
typedef void (^AlertActionBlock)(UIAlertView *alertView, NSUInteger buttonIndex);
typedef void (^AlertBlock)(UIAlertView *alertView);

@class AlertViewBlockDelegate;
typedef void (^AlertDelegateBlock)(AlertViewBlockDelegate *delegate);

@interface AlertViewBlockDelegate : NSObject<UIAlertViewDelegate>
{
  AlertActionBlock buttonClicked;
  AlertActionBlock dismissed;
  AlertActionBlock willDismiss;
  AlertBlock cancelled;
  AlertBlock presented;
  AlertBlock willPresent;
}

@property(copy) AlertActionBlock buttonClicked;
@property(copy) AlertActionBlock dismissed;
@property(copy) AlertActionBlock willDismiss;
@property(copy) AlertBlock cancelled;
@property(copy) AlertBlock presented;
@property(copy) AlertBlock willPresent;


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
