//
//  alertview_with_blocksAppDelegate.m
//  alertview_with_blocks
//
//  Created by dewindj on 4/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AlertViewWithBlocksAppDelegate.h"
#import "DemoController.h"
#import "UIAlertView+BlockSupport.h"

@implementation AlertViewWithBlocksAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {        
  [window addSubview:viewController.view];
  [window makeKeyAndVisible];
	
  [viewController.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchDown];
  
  [UIAlertView show:@"Demo" message:@"This is a demo" button:@"Okay" whenDismissed:^(UIAlertView *view, NSUInteger buttonIndex) {
    viewController.label.text = @"Demo!";
  }];
  
  
	return YES;
}

-(void)buttonClicked:(id)sender {
  UITextField *textField = [[[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)] autorelease];
  textField.backgroundColor = [UIColor whiteColor];
  textField.placeholder = @"Text";
	
  UIAlertView *alert = [UIAlertView build:^(AlertViewBlockDelegate *delegate){
    delegate.presented = ^(UIAlertView *alertView) {
      [textField becomeFirstResponder];
    };
    
    delegate.dismissed = ^(UIAlertView *alertView, NSUInteger buttonIndex) {
      if (alertView.cancelButtonIndex != buttonIndex) {
        [textField resignFirstResponder];
        viewController.label.text = textField.text;
      }
    };    
  }];
  
  alert.title = @"Enter Text";
  alert.message = @"Padding";
  [alert addSubview:textField];
	
  alert.cancelButtonIndex = [alert addButtonWithTitle:@"Cancel"];
	[alert addButtonWithTitle:@"Done"];
  
  [alert setTransform:CGAffineTransformMakeTranslation(0.0, 80.0)];
  [alert show];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
