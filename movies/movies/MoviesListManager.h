//
//  MoviesListManager.h
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Movie.h"
#import "MovieDatabase.h"

@interface MoviesListManager : NSObject

@property (strong) NSMutableArray *moviesList;
@property (strong) NSMutableDictionary *searchHelper;

+ (id)sharedInstance;
- (NSMutableArray *)getMoviesList;
- (NSMutableDictionary *)getDictionary;
- (void)addMovie:(Movie *)movie;
- (void)removeMovie:(NSString *)movieTitle;
- (Movie *)movieInLibrary:(NSString *)movieTitle;


- (void)saveData;
- (void)loadData;


@end

