//
//  DetailsViewController.h
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HCSStarRatingView/HCSStarRatingView.h>
#import "Library.h"
#import "MoviesListManager.h"

@interface DetailsViewController : UIViewController

// Labels to section in the main view
@property IBOutlet UILabel *movieTitleLabel;
@property IBOutlet UILabel *movieReleasedLabel;
@property IBOutlet UILabel *movieRuntimeLabel;
@property IBOutlet UILabel *movieGenreLabel;
@property IBOutlet UILabel *movieRatingLabel;

// Fields with data of the movie in the main view
@property IBOutlet UIImageView *moviePosterImageView;
@property IBOutlet UILabel *movieTitleInfoLabel;
@property IBOutlet UILabel *movieReleasedInfoLabel;
@property IBOutlet UILabel *movieRuntimeInfoLabel;
@property IBOutlet UILabel *movieGenreInfoLabel;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *movieRatingInfoView;

// Labels to section in the More Info view
@property IBOutlet UILabel *moviePlotLabel;
@property IBOutlet UILabel *movieWriterLabel;
@property IBOutlet UILabel *movieDirectorLabel;
@property IBOutlet UILabel *movieActorsLabel;
@property IBOutlet UILabel *movieAwardsLabel;
@property IBOutlet UILabel *movieCountryLabel;
@property IBOutlet UILabel *movieLanguageLabel;

// Labels with data of the movie in the More Info view
@property IBOutlet UILabel *moviePlotInfoLabel;
@property IBOutlet UILabel *movieWriterInfoLabel;
@property IBOutlet UILabel *movieDirectorInfoLabel;
@property IBOutlet UILabel *movieActorsInfoLabel;
@property IBOutlet UILabel *movieAwardsInfoLabel;
@property IBOutlet UILabel *movieCountryInfoLabel;
@property IBOutlet UILabel *movieLanguageInfoLabel;

// Buttons
@property IBOutlet UIButton *back;
@property IBOutlet UIButton *libraryButton;

// Data coming from callee view
@property (strong, nonatomic) MovieRealm *movie;
@property (strong, nonatomic) UIImage *poster;

- (void)showMessage:(NSString *)message;

@end
