#import "AlertWithBlocksDemo.h"

#pragma mark NonBlocks

@implementation ConfirmationAlert
+	(UIAlertView *)show:(NSString *)message delegate:(id<UIAlertViewDelegate>)theDelegate {
  UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Confirm" message:message delegate:theDelegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil] autorelease];
  [alertView show];
  return alertView;
}
@end

@implementation MyObject
- (void)showOneConfirmationAlert:(NSMutableDictionary *)externalState {
  externalStateForOneConfirmationAlert = [externalState retain];
  oneConfirmationAlert = [[ConfirmationAlert show:@"Are you sure about this?" delegate:self] retain];
}

- (void)showAnotherConfirmationAlert:(NSMutableDictionary *)externalState {
  externalStateForAnotherConfirmationAlert = [externalState retain];
  oneConfirmationAlert = [[ConfirmationAlert show:@"Again, are you sure?" delegate:self] retain];
  
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  if (alertView.cancelButtonIndex == buttonIndex) {
    if(alertView == oneConfirmationAlert) {
      //...
      NSLog([externalStateForOneConfirmationAlert objectForKey:@"Key"]);

    } else {
      //...
      NSLog([externalStateForOneConfirmationAlert objectForKey:@"DifferentKey"]);                      
    }
  } else {
    if(alertView == anotherConfirmationAlert) {
      //...
      NSLog([externalStateForAnotherConfirmationAlert objectForKey:@"AnotherKey"]);
    } else {
      //...
      NSLog([externalStateForAnotherConfirmationAlert objectForKey:@"YetAnotherKey"]);                      
    }    
  }
}
@end

#pragma mark Blocks

static NSMutableDictionary *blocks;
static BlockConfirmationAlert *delegate;

@implementation BlockConfirmationAlert
+	(void)show:(NSString *)message confirmed:(ConfirmationBlock)confirmBlock canceled:(ConfirmationBlock)canceledBlock {
  if(blocks == nil) {
    blocks = [[NSMutableDictionary dictionary] retain];
    delegate = [[BlockConfirmationAlert alloc] init];
  }  
  
  UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Confirm" message:message delegate:delegate cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil] autorelease];
  NSDictionary *blockDict = [NSDictionary dictionaryWithObjectsAndKeys:[[confirmBlock copy] autorelease], @"confirm", [[canceledBlock copy] autorelease], @"cancel", nil];  
  [blocks setObject:blockDict forKey:[NSNumber numberWithUnsignedInt:[alertView hash]]];  
  [alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
  NSNumber *key = [NSNumber numberWithUnsignedInt:[alertView hash]];
  NSDictionary *blockDict = [blocks objectForKey:key];
  
	if (alertView.cancelButtonIndex == buttonIndex) {
    ((ConfirmationBlock)[blockDict objectForKey:@"cancel"])(alertView);
  } else {
    ((ConfirmationBlock)[blockDict objectForKey:@"confirm"])(alertView);
  }
  
  [blocks removeObjectForKey:key];
}

@end

@implementation MyBlockObject

//...

+ (void)showOneConfirmationAlert:(NSMutableDictionary *)externalState {
  [BlockConfirmationAlert show:@"Are you sure about this?"   
   confirmed:^(UIAlertView *alertView) {
   	//...
   	NSLog([externalState objectForKey:@"Key"]);
   } 
   canceled:^(UIAlertView *alertView) {
    //...
    NSLog([externalState objectForKey:@"DifferentKey"]);                      
  }];  
}

+ (void)showAnotherConfirmationAlert:(NSMutableDictionary *)externalState {
  [BlockConfirmationAlert show:@"Again, are you sure?"   
   confirmed:^(UIAlertView *alertView) {
  	//...
  	NSLog([externalState objectForKey:@"AnotherKey"]);
   } 
   canceled:^(UIAlertView *alertView) {
    //...
    NSLog([externalState objectForKey:@"YetAnotherKey"]);                      
  }];  
}
@end

