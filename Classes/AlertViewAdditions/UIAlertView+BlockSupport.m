#import "UIAlertView+BlockSupport.h"

@implementation AlertViewBlockDelegate
@synthesize buttonClicked, dismissed, willDismiss, cancelled, presented, willPresent;

-(id)init {
  if (self = [super init]) {
    buttonClicked = nil;
    dismissed = nil;
    willDismiss = nil;
    cancelled = nil;
    presented = nil;
    willPresent = nil;
    return self;
  }
  
  return nil;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if(buttonClicked != nil) {
    buttonClicked(alertView, buttonIndex);
  }

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if(dismissed != nil) {
    dismissed(alertView, buttonIndex);
  }  
//  [self release];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
  if(willDismiss != nil) {
    willDismiss(alertView, buttonIndex);
  }    
}

- (void)alertViewCancel:(UIAlertView *)alertView {
  if(cancelled != nil) {
    cancelled(alertView);
  }      
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
  if(presented != nil) {
    presented(alertView);
  }          
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
  if(willPresent != nil) {
    willPresent(alertView);
  }        
}

-(void)dealloc {
  buttonClicked		!= nil ? [buttonClicked release]	: nil;
  willDismiss 		!= nil ? [willDismiss release] 		: nil;
  cancelled 			!= nil ? [cancelled release] 			: nil;
  presented 			!= nil ? [presented release] 			: nil;
  willPresent 		!= nil ? [willPresent release] 		: nil;
  dismissed 			!= nil ? [dismissed release] 			: nil;
	[super dealloc];  
}
@end


@implementation UIAlertView(BlockSupport)
+(id)build:(AlertDelegateBlock)delegateBlock {
  AlertViewBlockDelegate *delegate = [[[AlertViewBlockDelegate alloc] init] autorelease];
  UIAlertView *alertView = [[[UIAlertView alloc] init] autorelease];
  alertView.delegate = [delegate retain];
  delegateBlock(delegate);  
  return alertView;
}

+(void)show:(NSString *)title message:(NSString *)message button:(NSString *)button whenDismissed:(AlertActionBlock)block {
  UIAlertView *alertView = [self build:^(AlertViewBlockDelegate *delegate) {
    delegate.dismissed = block;
  }];
  
  alertView.title = title;
  alertView.message = message;
	[alertView addButtonWithTitle:button];
  [alertView show];
}
@end
