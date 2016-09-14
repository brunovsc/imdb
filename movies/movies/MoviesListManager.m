//
//  MoviesListManager.m
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "MoviesListManager.h"

@implementation MoviesListManager

- (id)init{
    self = [super init];
    if(!self) return nil;
    
    _moviesList = [[NSMutableArray alloc] init];
    _searchHelper = [[NSMutableDictionary alloc] init];
    
    return self;
}

+ (id)sharedInstance {
    static MoviesListManager *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (NSMutableArray *)getMoviesList{
    return _moviesList;
}

- (NSMutableDictionary *)getDictionary{
    return _searchHelper;
}

- (Movie *)movieInLibrary:(NSString *)movieTitle{
    Movie *m;
    m = [_searchHelper objectForKey:[[movieTitle lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    return m;
}

- (void)addMovie:(Movie*)movie{
    Movie *m;
    NSString *keyString = [[movie.title lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    m = [_searchHelper objectForKey:keyString];
    if(m == nil){
        m.isOnLibrary = YES;
        [_moviesList addObject:movie];
        [_searchHelper setObject:movie forKey:keyString];
    }

}

- (void)removeMovie:(NSString *)movieTitle{
    Movie *m;
    NSString *keyString = [[movieTitle lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    m = [_searchHelper objectForKey:keyString];
    if(m){
        [_moviesList removeObject:m];
        [_searchHelper removeObjectForKey:keyString];
    }
}

- (void)saveData{
    
    MovieDatabase *MD = [MovieDatabase sharedInstance];
    
    for(NSString* key in _searchHelper){
        Movie *m = [_searchHelper objectForKey:key];
        if(!m.onDatabase){
            BOOL dataSaved = NO;
            
            /*
             dispatch_async(dispatch_get_main_queue(), ^{
             [MD saveData:key movie:m];
            });*/
            
            dataSaved = [MD saveMovie:key movie:m];
            if(dataSaved){
                m.onDatabase = YES;
                NSLog(@"%@ saved to database", key);
                
            }
            else{
                m.onDatabase = NO;
                NSLog(@"Failed to save %@ to database", key);
            }
        }
        else {
            NSLog(@"%@ already in the database", key);
        }
    }
}

- (void)loadData{
    
    MovieDatabase *MD = [MovieDatabase sharedInstance];
    NSArray *resultsSearch = [MD findAll];
    
    for(NSArray *rMovie in resultsSearch){
        Movie *m = [[Movie alloc] initWithInfoArray:rMovie];
        m.isOnLibrary = YES;
        m.onDatabase = YES;
        [self addMovie:m];
        NSLog(@"%@ loaded from database", m.title);
    }
    
    NSLog(@"Finished loading database");

}


@end
