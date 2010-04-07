#import <Foundation/Foundation.h>

@interface ConfirmationAlert : NSObject {
}
+	(UIAlertView *)show:(NSString *)message delegate:(id<UIAlertViewDelegate>)theDelegate;
@end


#pragma mark NonBlock


@interface MyObject : NSObject<UIAlertViewDelegate>
{
  UIAlertView *oneConfirmationAlert;
  UIAlertView *anotherConfirmationAlert;
  NSMutableDictionary *externalStateForOneConfirmationAlert;
  NSMutableDictionary *externalStateForAnotherConfirmationAlert;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)showOneConfirmationAlert:(NSMutableDictionary *)externalState;
- (void)showOneConfirmationAlert:(NSMutableDictionary *)externalState;
@end


#pragma mark Blocks

typedef void (^ConfirmationBlock)(UIAlertView *);

@interface BlockConfirmationAlert : NSObject<UIAlertViewDelegate> {
}

+	(void)show:(NSString *)message confirmed:(ConfirmationBlock)confirmBlock canceled:(ConfirmationBlock)canceledBlock;
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;
@end

@interface MyBlockObject : NSObject
{
}

+ (void)showOneConfirmationAlert:(NSMutableDictionary *)externalState;
+ (void)showAnotherConfirmationAlert:(NSMutableDictionary *)externalState;
@end



