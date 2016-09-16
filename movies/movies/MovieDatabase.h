//
//  MovieDatabase.h
//  movies
//
//  Created by Bruno Vieira on 9/13/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MoviesListManager.h"
#import <UIKit/UIImage.h>

@interface MovieDatabase : NSObject {
    NSString *databasePath;
    sqlite3 *database;
    sqlite3_stmt *statement;
}

+ (id)sharedInstance;
- (BOOL)createDB;
- (NSArray *)findAll;
/*
- (BOOL)saveMovie:(NSString*)key movie:(Movie*)m;
- (UIImage*)downloadImage:(NSString*)key url:(NSString*)urlString;
- (BOOL)saveImage:(UIImage*)image forKey:(NSString *)key;
*/
@end
