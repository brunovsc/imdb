//
//  MovieModel.h
//  movies
//
//  Created by Bruno Vieira on 9/15/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

@interface MovieModel : MTLModel <MTLJSONSerializing>

@property (strong, nonatomic) NSString *title;//
@property (strong, nonatomic) NSString *year;//
@property (strong, nonatomic) NSString *released;
@property (strong, nonatomic) NSString *runtime;//
@property (strong, nonatomic) NSString *genre;//
@property (strong, nonatomic) NSString *director;//
@property (strong, nonatomic) NSString *writer;//
@property (strong, nonatomic) NSString *actors;//
@property (strong, nonatomic) NSString *plot;//
@property (strong, nonatomic) NSString *language;//
@property (strong, nonatomic) NSString *country;//
@property (strong, nonatomic) NSString *awards;//
@property (strong, nonatomic) NSString *poster;
@property (strong, nonatomic) NSString *metascore;
@property (strong, nonatomic) NSString *imdbRating;
@property (strong, nonatomic) NSString *imdbVotes;
@property (strong, nonatomic) NSString *imdbID;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *response;

@end