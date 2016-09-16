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
    _movieImages = [[NSMutableDictionary alloc] init];
    
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

- (MovieRealm *)movieInLibrary:(NSString *)movieTitle{
    MovieRealm *m;
    m = [_searchHelper objectForKey:[[movieTitle lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""]];
    return m;
}

- (void)addMovie:(MovieRealm*)movie{
    MovieRealm *m;
    //NSString *keyString = [[movie.title lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    m = [_searchHelper objectForKey:movie.key];
    if(m == nil){
        m.isOnLibrary = YES;
        [_moviesList addObject:movie];
        [_searchHelper setObject:movie forKey:movie.key];
    }

}

- (void)addImage:(UIImage*)image forKey:(NSString*)key{
    [_movieImages setObject:image forKey:key];
}

- (void)removeMovie:(NSString *)movieTitle{
    MovieRealm *m;
    NSString *keyString = [[movieTitle lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    m = [_searchHelper objectForKey:keyString];
    if(m){
        [_moviesList removeObject:m];
        [_searchHelper removeObjectForKey:keyString];
    }
}

- (UIImage*)imageForKey:(NSString*)key{
    return [_movieImages objectForKey:key];
}

- (void)saveData{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    for(NSString* key in _searchHelper){
        MovieRealm *m = [_searchHelper objectForKey:key];
        if(!m.onDatabase){
            //BOOL dataSaved = NO;
            
 
            //dispatch_async(dispatch_get_main_queue(), ^{
            //[MD saveData:key movie:m];
            //});
            
            [realm addObject:m];
            NSLog(@"%@ added to write list", key);/*
            if(dataSaved){
                m.onDatabase = YES;
                NSLog(@"%@ saved to database", key);
                
            }
            else{
                m.onDatabase = NO;
                NSLog(@"Failed to save %@ to database", key);
            }*/
        }
        else {
            NSLog(@"%@ already in the database", key);
        }
    }
    
    [realm commitWriteTransaction];
    NSLog(@"movie list commited");
}


- (void)loadData{
    
    //MovieDatabase *MD = [MovieDatabase sharedInstance];
    //NSArray *resultsSearch = [MD findAll];
    RLMResults<MovieRealm *> *moviesLoaded = [MovieRealm allObjects];
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    for(MovieRealm *rMovie in moviesLoaded){
        
        MovieRealm *m = [rMovie copy];
        //[m copy];
        m.isOnLibrary = YES;
        m.onDatabase = YES;
        [self addMovie:m];
        
        
        NSString * keyPNG = [NSString stringWithFormat:@"%@.png",m.key];
        UIImage *poster = [UIImage imageWithContentsOfFile:[basePath stringByAppendingPathComponent:keyPNG]];
        [self addImage:poster forKey:m.key];
        
        NSLog(@"%@ found in database", rMovie.title);
    }
    
    NSLog(@"Finished loading database");

}


@end
