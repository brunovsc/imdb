//
//  MBProgressHUDHelper.h
//  IMDBRequestExample
//
//  Created by Eduardo Sanches Bocato on 11/09/16.
//  Copyright © 2016 Eduardo Sanches Bocato. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface MBProgressHUDHelper : NSObject

+ (MBProgressHUD *)showMBProgressInView:(UIView *)view
                      withAnimationType:(MBProgressHUDMode)mode
                              withTitle:(NSString *)title;

@end
