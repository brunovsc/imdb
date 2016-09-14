//
//  MBProgressHUDHelper.m
//  IMDBRequestExample
//
//  Created by Eduardo Sanches Bocato on 11/09/16.
//  Copyright © 2016 Eduardo Sanches Bocato. All rights reserved.
//

#import "MBProgressHUDHelper.h"

@implementation MBProgressHUDHelper

+ (MBProgressHUD *)showMBProgressInView:(UIView *)view
                      withAnimationType:(MBProgressHUDMode)mode
                              withTitle:(NSString *)title {
    if (!view) {
        return nil;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = mode;
    hud.dimBackground = YES;
    hud.labelText = title ?: @"";
    
    return hud;
}

@end