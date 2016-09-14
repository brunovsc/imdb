//
//  Library.h
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "HTTPService.h"
#import "Movie.h"

@interface Library : HTTPService

- (NSURLSessionDataTask *)getMovieWithName:(NSString *)name success:(void (^)(Movie *response))success failure:(void (^)(NSError *error))failure;

+ (void)addMovie:(Movie *)movie;

@end
