//
//  alertview_with_blocksViewController.m
//  alertview_with_blocks
//
//  Created by dewindj on 4/6/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "DemoController.h"

@implementation DemoController
@synthesize label, button;

- (void)dealloc {
  self.label = nil;
  self.button = nil;
	[super dealloc];
}

@end
