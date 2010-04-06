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
  
  [UIAlertView show:@"Hello" message:@"A Message" button:@"Okay" whenDismissed:^(UIAlertView *view, NSUInteger buttonIndex) {
    viewController.label.text = @"Hello!";
  }];
  
  
	return YES;
}

-(void)buttonClicked:(id)sender {
  UIAlertView *alert = [UIAlertView build:^(AlertViewBlockDelegate *delegate){
    delegate.cancelledBlock = ^(UIAlertView *alertView) {
    	viewController.label.text = @"Cancelled!";  
    };
    
    delegate.dismissedBlock = ^(UIAlertView *alertView, NSUInteger buttonIndex) {
      if (buttonIndex > 0) {
        viewController.label.text = @"Dismissed!";        
      }
    };    
  }];
  
  alert.title = @"Demo";
  alert.message = @"Hello Everyody!";
  alert.cancelButtonIndex = 0;
  [alert addButtonWithTitle:@"Cancel"];
  [alert addButtonWithTitle:@"Confirm"];
  [alert show];
  
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
