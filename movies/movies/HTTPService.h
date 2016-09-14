//
//  HTTPService.h
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface HTTPService : AFHTTPSessionManager

+ (id)sharedHTTPService;

@end
