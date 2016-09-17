//
//  MovieRealm.m
//  movies
//
//  Created by Bruno Vieira on 9/15/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "MovieRealm.h"

@implementation MovieRealm

- (MovieRealm *)initWithInfoArray:(NSArray *)info{
    
    if(self = [super init]){
        
        self.key = [info objectAtIndex:0];
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

- (id)copyWithZone:(NSZone *)zone{
    MovieRealm *new = [[MovieRealm alloc] init];
    
    new.key = self.key;
    new.title = self.title;
    new.year = self.year;
    new.released = self.released;
    new.runtime = self.runtime;
    new.genre = self.genre;
    new.director = self.director;
    new.writer = self.writer;
    new.actors = self.actors;
    new.plot = self.plot;
    new.language = self.language;
    new.country = self.country;
    new.awards = self.awards;
    new.poster = self.poster;
    new.metascore = self.metascore;
    new.imdbRating = self.imdbRating;
    new.imdbVotes = self.imdbVotes;
    new.imdbID = self.imdbID;
    new.type = self.type;
    new.response = self.response;
    
    return new;
    
}

- (MovieRealm *)initWithMovieModel:(MovieModel *)MM{
    
    if(self = [super init]){
        NSString *keyString = [[MM.title lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
        self.key = keyString;
        self.title = MM.title;
        self.year = MM.year;
        self.released = MM.released;
        self.runtime = MM.runtime;
        self.genre = [MM.genre stringByReplacingOccurrencesOfString:@", " withString:@"\n"];
        self.director = MM.director;
        self.writer = [MM.writer stringByReplacingOccurrencesOfString:@", " withString:@"\n"];
        self.actors = [MM.actors stringByReplacingOccurrencesOfString:@", " withString:@"\n"];
        self.plot = MM.plot;
        self.language = MM.language;
        self.country = MM.country;
        self.awards = MM.awards;
        self.poster = MM.poster;
        self.metascore = MM.metascore;
        self.imdbRating = MM.imdbRating;
        self.imdbVotes = MM.imdbVotes;
        self.imdbID = MM.imdbID;
        self.type = MM.type;
        self.response = MM.response;
    }
    return self;
}

@end