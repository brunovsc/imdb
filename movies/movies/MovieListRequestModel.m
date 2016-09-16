//
//  MovieListRequestModel.m
//  movies
//
//  Created by Bruno Vieira on 9/15/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "MovieListRequestModel.h"

@implementation MovieListRequestModel

#pragma mark - Mantle JSONKeyPathsByPropertyKey

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title" : @"Title",
             @"year" : @"Year",
             @"released" : @"Released",
             @"runtime" : @"Runtime",
             @"genre" : @"Genre",
             @"director" : @"Director",
             @"writer" : @"Writer",
             @"actors" : @"Actors",
             @"plot" : @"Plot",
             @"language" : @"Language",
             @"country" : @"Country",
             @"awards" : @"Awards",
             @"poster" : @"Poster",
             @"metascore" : @"Metascore",
             @"imdbRating" : @"imdbRating",
             @"imdbVotes" : @"imdbVotes",
             @"imdbID" : @"imdbID",
             @"type" : @"Type",
             @"response" : @"Response",
             };
}

@end
