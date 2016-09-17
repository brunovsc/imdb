//
//  MoviesListManager.h
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieRealm.h"
#import "MovieDatabase.h"
#import <Realm/Realm.h>
#import <UIKit/UIKit.h>

@interface MoviesListManager : NSObject

@property (strong) NSMutableArray *moviesList;
@property (strong) NSMutableDictionary *searchHelper;
@property (strong) NSMutableDictionary *movieImages;

+ (id)sharedInstance;
- (NSMutableArray *)getMoviesList;
- (NSMutableDictionary *)getDictionary;
- (void)addNewMovie:(MovieRealm*)movie;
- (void)addMovieToList:(MovieRealm *)movie;
- (void)removeMovie:(NSString *)movieTitle;
- (MovieRealm *)movieInLibrary:(NSString *)movieTitle;

- (void)addImage:(UIImage*)image forKey:(NSString*)key;
- (UIImage*)imageForKey:(NSString*)key;

- (void)saveAllData;
- (void)loadData;


@end

