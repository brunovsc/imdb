//
//  DetailsViewController.h
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import "Library.h"
#import "MoviesListManager.h"

@interface DetailsViewController : UIViewController


@property IBOutlet UILabel *movieTitleLabel;
@property IBOutlet UILabel *movieYearLabel;
@property IBOutlet UILabel *movieReleasedLabel;
@property IBOutlet UILabel *movieRuntimeLabel;
@property IBOutlet UILabel *movieGenreLabel;
@property IBOutlet UIButton *back;
@property IBOutlet UIButton *addToLibraryButton;
@property IBOutlet UIImageView *posterImageView;

@property (strong, nonatomic) Movie *movie;

@end
