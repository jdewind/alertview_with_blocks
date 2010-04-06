#import "UIAlertView+BlockSupport.h"

@implementation AlertViewBlockDelegate
@synthesize buttonClickedBlock, dismissedBlock, willDismissBlock, cancelledBlock, presentedBlock, willPresentBlock;

-(id)init {
  if (self = [super init]) {
    buttonClickedBlock = nil;
    dismissedBlock = nil;
    willDismissBlock = nil;
    cancelledBlock = nil;
    presentedBlock = nil;
    willPresentBlock = nil;
    return self;
  }
  
  return nil;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if(buttonClickedBlock != nil) {
    buttonClickedBlock(alertView, buttonIndex);
  }

}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if(dismissedBlock != nil) {
    dismissedBlock(alertView, buttonIndex);
  }  
  [self release];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
  if(willDismissBlock != nil) {
    willDismissBlock(alertView, buttonIndex);
  }    
}

- (void)alertViewCancel:(UIAlertView *)alertView {
  if(cancelledBlock != nil) {
    cancelledBlock(alertView);
  }      
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
  if(presentedBlock != nil) {
    presentedBlock(alertView);
  }          
}

- (void)willPresentAlertView:(UIAlertView *)alertView {
  if(willPresentBlock != nil) {
    willPresentBlock(alertView);
  }        
}

-(void)dealloc {
  buttonClickedBlock	!= nil ? [buttonClickedBlock release] : nil;
  willDismissBlock 		!= nil ? [willDismissBlock release] 	: nil;
  cancelledBlock 			!= nil ? [cancelledBlock release] 		: nil;
  presentedBlock 			!= nil ? [presentedBlock release] 		: nil;
  willPresentBlock 		!= nil ? [willPresentBlock release] 	: nil;
  dismissedBlock 			!= nil ? [dismissedBlock release] 	: nil;
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
    delegate.dismissedBlock = block;
  }];
  
  alertView.title = title;
  alertView.message = message;
	[alertView addButtonWithTitle:button];
  [alertView show];
}
@end
