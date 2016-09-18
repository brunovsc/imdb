//
//  UIService.m
//  movies
//
//  Created by Bruno Vieira on 9/18/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "UIService.h"

@implementation UIService



- (void)showErrorMessage:(NSString *)errorMessage{
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                        message:errorMessage
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            NSLog(@"Dismiss button tapped!");
                                                        }];
    [controller addAction:alertAction];
  //  [self presentViewController:controller animated:YES completion:nil];
    
    
    //[MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
