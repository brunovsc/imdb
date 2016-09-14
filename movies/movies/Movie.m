//
//  Movie.m
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "Movie.h"

@implementation Movie

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

+ (NSValueTransformer *)moviesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:Movie.class];
}

- (Movie *)initWithInfoArray:(NSArray *)info{
    
    if(self = [super init]){
        
        self.title = [info objectAtIndex:1];
        self.year = [info objectAtIndex:2];
        self.released = [info objectAtIndex:3];
        self.runtime = [info objectAtIndex:4];
        self.genre = [info objectAtIndex:5];
        self.director = [info objectAtIndex:6];
        self.writer = [info objectAtIndex:7];
        self.actors = [info objectAtIndex:8];
        self.plot = [info objectAtIndex:9];
        self.language = [info objectAtIndex:10];
        self.country = [info objectAtIndex:11];
        self.awards = [info objectAtIndex:12];
        self.poster = [info objectAtIndex:13];
        self.metascore = [info objectAtIndex:14];
        self.imdbRating = [info objectAtIndex:15];
        self.imdbVotes = [info objectAtIndex:16];
        self.imdbID = [info objectAtIndex:17];
        self.type = [info objectAtIndex:18];
        self.response = [info objectAtIndex:19];
    }
    
    return self;
}

@end

