//
//  alertview_with_blocksAppDelegate.h
//  alertview_with_blocks
//
//  Created by dewindj on 4/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DemoController;

@interface AlertViewWithBlocksAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    DemoController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet DemoController *viewController;

@end

