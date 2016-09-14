//
//  HTTPService.m
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "HTTPService.h"

@implementation HTTPService

static NSString *const kBaseURL = @"http://www.omdbapi.com/?";

- (id)init{
    self = [super initWithBaseURL:[NSURL URLWithString:kBaseURL]];
    if(!self) return nil;
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return self;
}

+ (id)sharedHTTPService {
    static HTTPService *_sharedHTTPService = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHTTPService = [[self alloc] init];
    });
    
    return _sharedHTTPService;
}

@end
