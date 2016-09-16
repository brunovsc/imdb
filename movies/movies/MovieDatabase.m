//
//  MovieDatabase.m
//  movies
//
//  Created by Bruno Vieira on 9/13/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "MovieDatabase.h"

@implementation MovieDatabase

- (id)init{
    self = [super init];
    if(!self) return nil;
    
    database = nil;
    statement = nil;
    if([self createDB]){
        NSLog(@"Database opened/created");
    }
    else{
        NSLog(@"Database not opened/created");        
    }
    
    return self;
}

+ (id)sharedInstance {
    static MovieDatabase *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

- (BOOL) createDB{
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString:[docsDir stringByAppendingPathComponent: @"movie.db"]];
    BOOL isSuccess = YES;
    NSFileManager *filemgr = [NSFileManager defaultManager];
    if ([filemgr fileExistsAtPath: databasePath ] == NO)
    {
        const char *dbpath = [databasePath UTF8String];
        if (sqlite3_open(dbpath, &database) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt = "create table if not exists movieDetail (key text primary key, title text, year text, released text, runtime text, genre text, director text, writer text, actors text, plot text, language text, country text, awards text, poster text, metascore text, imdbRating text, imdbVotes text, imdbID text, type text, response text)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                isSuccess = NO;
                NSLog(@"Failed to create table");
            }
            sqlite3_close(database);
            return  isSuccess;
        }
        else {
            isSuccess = NO;
            NSLog(@"Failed to open/create database");
        }
    }
    return isSuccess;
}
/*
- (BOOL)saveMovie:(NSString*)key movie:(Movie*)m{
    if([self saveInfo:key movie:m]){
        NSLog(@"Save info OK");
    }
    UIImage *image = [self downloadImage:key url:m.poster];
    if([self saveImage:image forKey:key]){
        NSLog(@"Save image OK");
    }
    return YES;
}
 
- (UIImage*)downloadImage:(NSString*)key url:(NSString*)urlString{
    NSString *urlStringHttps = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSURL *imgURL = [NSURL URLWithString:urlStringHttps];
    NSData *data = [[NSData alloc] initWithContentsOfURL:imgURL];
    UIImage *image = [[UIImage alloc] initWithData:data];
    return image;
}

- (UIImage*)loadImageForKey:(NSString *)key{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",key]];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    
    return image;
}

- (BOOL)saveImage:(UIImage*)image forKey:(NSString *)key{
    
    if (image != nil){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", key]];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
        
        return YES;
    }
    return NO;
    
}
    

- (BOOL)saveInfo:(NSString*)key movie:(Movie*)m{
   // NSMutableDictionary *movies = [[MoviesListManager sharedInstance] getDictionary];
    
    sqlite3_stmt *stmt;
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK){
        
            
        NSString *insertSQL = [NSString stringWithFormat:@"insert into movieDetail (key, title, year, released, runtime, genre, director, writer, actors, plot, language, country, awards, poster, metascore, imdbRating, imdbVotes, imdbID, type, response) values (\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", key, m.title, m.year, m.released, m.runtime, m.genre, m.director, m.writer, m.actors, m.plot, m.language, m.country, m.awards, m.poster, m.metascore, m.imdbRating, m.imdbVotes, m.imdbID, m.type, m.response];
            
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(database, insert_stmt,-1, &stmt, NULL);
        NSLog(@"%d", sqlite3_step(stmt));
        NSLog(@"%d", sqlite3_prepare_v2(database, insert_stmt,-1, &stmt, NULL));
        
        if (sqlite3_step(stmt) == SQLITE_DONE){
            sqlite3_finalize(stmt);
            return YES;
        }
        else{
            NSLog(@"%d", sqlite3_step(stmt));
            return NO;
        }
        
    }
    return NO;
}
*/
- (NSArray*)findByKey:(NSString*)key{
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK){
        
        NSString *querySQL = [NSString stringWithFormat:@"select key, title, year, released, runtime, genre, director, writer, actors, plot, language, country, awards, poster, metascore, imdbRating, imdbVotes, imdbID, type, response from movieDetail where key=\"%@\"", key];
                
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *resultArray = [[NSMutableArray alloc]init];
        
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK){
            
            if (sqlite3_step(statement) == SQLITE_ROW){
                
                NSString *key = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                [resultArray addObject:key];
                
                NSString *title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                [resultArray addObject:title];
                
                NSString *year = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                [resultArray addObject:year];
                
                NSString *released = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                [resultArray addObject:released];
                
                NSString *runtime = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                [resultArray addObject:runtime];
                
                NSString *genre = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                [resultArray addObject:genre];
                
                NSString *director = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                [resultArray addObject:director];
                
                NSString *writer = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                [resultArray addObject:writer];
                
                NSString *actors = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                [resultArray addObject:actors];
                
                NSString *plot = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)];
                [resultArray addObject:plot];
                
                NSString *language = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)];
                [resultArray addObject:language];
                
                NSString *country = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 11)];
                [resultArray addObject:country];
                
                NSString *awards = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 12)];
                [resultArray addObject:awards];
                
                NSString *poster = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 13)];
                [resultArray addObject:poster];
            
                NSString *metascore = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 14)];
                [resultArray addObject:metascore];
                
                NSString *imdbRating = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 15)];
                [resultArray addObject:imdbRating];
                
                NSString *imdbVotes = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 16)];
                [resultArray addObject:imdbVotes];
                
                NSString *imdbID = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 17)];
                [resultArray addObject:imdbID];
                
                NSString *type = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 18)];
                [resultArray addObject:type];
                
                NSString *response = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 19)];
                [resultArray addObject:response];
                
                return resultArray;
            }
            else{
                NSLog(@"Not found");
                return nil;
            }
            //sqlite3_reset(statement);
        }
    }
    return nil;
}

- (NSArray *)findAll{
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    const char *dbpath = [databasePath UTF8String];
    if (sqlite3_open(dbpath, &database) == SQLITE_OK){
        
        NSString *querySQL = [NSString stringWithFormat:@"select key, title, year, released, runtime, genre, director, writer, actors, plot, language, country, awards, poster, metascore, imdbRating, imdbVotes, imdbID, type, response from movieDetail"];
    
        const char *query_stmt = [querySQL UTF8String];
        NSMutableArray *rowResult = [[NSMutableArray alloc]init];
    
        if (sqlite3_prepare_v2(database, query_stmt, -1, &statement, NULL) == SQLITE_OK){
    
            while (sqlite3_step(statement) == SQLITE_ROW){
                
                rowResult = [[NSMutableArray alloc]init];
            
                NSString *key = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                [rowResult addObject:key];
                
                NSLog(@"%@", key);
                
                NSString *title = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                [rowResult addObject:title];
            
                NSString *year = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 2)];
                [rowResult addObject:year];
            
                NSString *released = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 3)];
                [rowResult addObject:released];
            
                NSString *runtime = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 4)];
                [rowResult addObject:runtime];
            
                NSString *genre = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 5)];
                [rowResult addObject:genre];
            
                NSString *director = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 6)];
                [rowResult addObject:director];
            
                NSString *writer = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 7)];
                [rowResult addObject:writer];
            
                NSString *actors = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 8)];
                [rowResult addObject:actors];
            
                NSString *plot = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 9)];
                [rowResult addObject:plot];
            
                NSString *language = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 10)];
                [rowResult addObject:language];
            
                NSString *country = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 11)];
                [rowResult addObject:country];
            
                NSString *awards = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 12)];
                [rowResult addObject:awards];
            
                NSString *poster = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 13)];
                [rowResult addObject:poster];
            
                NSString *metascore = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 14)];
                [rowResult addObject:metascore];
            
                NSString *imdbRating = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 15)];
                [rowResult addObject:imdbRating];
            
                NSString *imdbVotes = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 16)];
                [rowResult addObject:imdbVotes];
            
                NSString *imdbID = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 17)];
                [rowResult addObject:imdbID];
            
                NSString *type = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 18)];
                [rowResult addObject:type];
            
                NSString *response = [[NSString alloc]initWithUTF8String:(const char *) sqlite3_column_text(statement, 19)];
                [rowResult addObject:response];
                
                [results addObject:rowResult];
            }
        }
    }
    else{
        NSLog(@"Failed to open database");
    }
    return results;
}

@end
