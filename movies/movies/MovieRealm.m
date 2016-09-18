//
//  MovieRealm.m
//  movies
//
//  Created by Bruno Vieira on 9/15/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "MovieRealm.h"

@implementation MovieRealm

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