#import "AlertViewWithBlocksAppDelegate.h"
#import "DemoController.h"
#import "AlertWithBlocksDemo.h"

@implementation AlertViewWithBlocksAppDelegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {        
  [window addSubview:viewController.view];
  [window makeKeyAndVisible];
	
  [BlockConfirmationAlert show:@"Demo" confirmed:^(UIAlertView *alertView) {
  	NSLog(@"Confirmed");  
  } 
  canceled: ^(UIAlertView *alertView) {
    NSLog(@"Cancelled");
  }];
  
	return YES;
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
