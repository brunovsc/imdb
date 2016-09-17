//
//  DetailsViewController.m
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

@synthesize movie;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_movieTitleInfoLabel setText:movie.title];
    [_movieYearInfoLabel setText:movie.year];
    [_movieRuntimeInfoLabel setText:movie.runtime];
    [_movieGenreInfoLabel setText:movie.genre];
    
    [_movieRatingInfoView setValue:([movie.imdbRating floatValue] / 2)];
    
    [_moviePlotInfoLabel setText:movie.plot];
    [_movieWriterInfoLabel setText:movie.writer];
    [_movieDirectorInfoLabel setText:movie.director];
    [_movieActorsInfoLabel setText:movie.actors];
    [_movieAwardsInfoLabel setText:movie.awards];
    [_movieCountryInfoLabel setText:movie.country];
    [_movieLanguageInfoLabel setText:movie.language];
    
    [_moviePosterImageView setImage:_poster];
    [_moviePosterImageView setNeedsDisplay];
    [_moviePosterImageView setNeedsLayout];
    /*
    HCSStarRatingView *starRatingView = [[HCSStarRatingView alloc] init];
    starRatingView.maximumValue = 5;
    starRatingView.minimumValue = 0;
    starRatingView.value = [movie.imdbRating floatValue] / 2;
    [starRatingView setUserInteractionEnabled:NO];
    starRatingView.tintColor = [UIColor yellowColor];
    starRatingView.accurateHalfStars = YES;
    [starRatingView addTarget:self action:@selector(didChangeValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:starRatingView];
     */
    
    if(movie.onDatabase == YES){
        [_addToLibraryButton setTitle:@"Delete" forState:UIControlStateNormal];
    }
    else{
        [_addToLibraryButton setTitle:@"Save" forState:UIControlStateNormal];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToLibrary:(id)sender {
    
    if(movie.onDatabase == NO){
        
        NSString * keyString = [[movie.title lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        movie.key = keyString;
        
        [_addToLibraryButton setTitle:@"Delete" forState:UIControlStateNormal];
        [[MoviesListManager sharedInstance] addImage:_poster forKey:keyString];
        [[MoviesListManager sharedInstance] addNewMovie:movie];
        
        NSString *addMessage = [NSString stringWithFormat:@"%@ added to your library. It will be available offline", movie.title];
        UIAlertView *messageAlert = [[UIAlertView alloc]
                                     initWithTitle:@"Done"
                                     message:addMessage
                                     delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
        
        // Display Alert Message
        [messageAlert show];
    }
    else{
        //movie.isOnLibrary = NO;
        NSString *movieTitle = movie.title;
        [_addToLibraryButton setTitle:@"Save" forState:UIControlStateNormal];
        [[MoviesListManager sharedInstance] removeMovie:movieTitle];
        NSString *remMessage = [NSString stringWithFormat:@"%@ removed from your library. It will not be available offline", movieTitle];
        UIAlertView *messageAlert = [[UIAlertView alloc]
                                     initWithTitle:@"Done"
                                     message:remMessage
                                     delegate:nil
                                     cancelButtonTitle:@"OK"
                                     otherButtonTitles:nil];
        
        // Display Alert Message
        [messageAlert show];
        
    }
    [_addToLibraryButton setNeedsLayout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
