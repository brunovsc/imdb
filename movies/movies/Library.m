//
//  Library.m
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "Library.h"
#import "HTTPService.h"
#import "Mantle.h"
#import "Movie.h"
#import "MoviesListManager.h"

static NSString *const kBaseURL = @"https://www.omdbapi.com/";

@implementation Library

- (NSURLSessionDataTask *)getMovieWithName:(NSString *)name success:(void (^)(Movie *response))success failure:(void (^)(NSError *error))failure{
    
    NSString *requestUrl = kBaseURL;
    NSDictionary *parameters = @{@"t": name ?: @""};
    
    return [self GET:requestUrl parameters:parameters
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 
                 NSLog(@"RequestURL: %@", task.currentRequest.URL);
                 
                 NSDictionary *responseDictionary = (NSDictionary *)responseObject;
                 
                 NSError *error;
                 Movie *movie = [MTLJSONAdapter modelOfClass:Movie.class
                                          fromJSONDictionary:responseDictionary error:&error];
                 
                 
                 movie.isOnLibrary = NO;
                          
                 success(movie);
                 
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 
                 failure(error);
                 
             }];
    
}

+ (void)addMovie:(Movie *)movie{
    [[MoviesListManager sharedInstance] addObject:movie];
}

@end
