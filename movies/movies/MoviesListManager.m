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

- (void)addNewMovie:(MovieRealm*)movie{
    MovieRealm *m;
    m = [_searchHelper objectForKey:movie.key];
    if(m == nil){
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        
        [realm beginWriteTransaction];
        movie.onDatabase = YES;
        [realm addObject:movie];
        [realm commitWriteTransaction];
        
        [_moviesList addObject:movie];
        [_searchHelper setObject:movie forKey:movie.key];
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        
        NSString * keyPNG = [NSString stringWithFormat:@"%@.png",movie.key];
        
        
        UIImage *poster = [_movieImages objectForKey:movie.key];
        NSData * binaryImageData = UIImagePNGRepresentation(poster);
        
        [binaryImageData writeToFile:[basePath stringByAppendingPathComponent:keyPNG] atomically:YES];
    }
    else{
        NSLog(@"A movie with the key %@ is already in the database", movie.key);
    }

}

- (void)addMovieToList:(MovieRealm*)movie{
    [_moviesList addObject:movie];
    [_searchHelper setObject:movie forKey:movie.key];
}

- (void)addImage:(UIImage*)image forKey:(NSString*)key{
    [_movieImages setObject:image forKey:key];
}

- (void)removeMovie:(NSString *)movieTitle{
    RLMRealm *realm = [RLMRealm defaultRealm];
    MovieRealm *m;
    NSString *keyString = [[movieTitle lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    m = [_searchHelper objectForKey:keyString];
    if(m){
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        
        NSString * keyPNG = [NSString stringWithFormat:@"%@.png",m.key];
        
        [[NSFileManager defaultManager] removeItemAtPath:[basePath stringByAppendingPathComponent:keyPNG] error:nil];

        [realm beginWriteTransaction];
        [realm deleteObject:m];
        [realm commitWriteTransaction];
        [_moviesList removeObject:m];
        [_searchHelper removeObjectForKey:keyString];
        
    }
}

- (UIImage*)imageForKey:(NSString*)key{
    return [_movieImages objectForKey:key];
}

- (void)saveAllData{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    
    for(NSString* key in _searchHelper){
        MovieRealm *m = [_searchHelper objectForKey:key];
        if(!m.onDatabase){
            [realm addObject:m];
            NSLog(@"%@ added to write list", key);
        }
        else {
            NSLog(@"%@ already in the database", key);
        }
    }
    
    [realm commitWriteTransaction];
    NSLog(@"movie list commited");
}


- (void)loadData{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RLMResults<MovieRealm *> *moviesLoaded = [MovieRealm allObjects];
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    [realm beginWriteTransaction];
    
    for(MovieRealm *rMovie in moviesLoaded){
        
        rMovie.onDatabase = YES;
        [self addMovieToList:rMovie];
        
        NSString * keyPNG = [NSString stringWithFormat:@"%@.png",rMovie.key];
        UIImage *poster = [UIImage imageWithContentsOfFile:[basePath stringByAppendingPathComponent:keyPNG]];
        [self addImage:poster forKey:rMovie.key];
        
        NSLog(@"%@ found in database", rMovie.title);
    }
    
    [realm commitWriteTransaction];
    
    NSLog(@"Finished loading database");

}


@end
