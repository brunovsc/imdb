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
    
    // Setting Movie data to the main fields
    [_movieTitleInfoLabel setText:movie.title];
    [_movieReleasedInfoLabel setText:movie.released];
    [_movieRuntimeInfoLabel setText:movie.runtime];
    [_movieGenreInfoLabel setText:movie.genre];
    
    // Setting the poster
    [_moviePosterImageView setImage:_poster];
    [_moviePosterImageView setNeedsDisplay];
    
    // Setting the value to the star rating view
    [_movieRatingInfoView setValue:([movie.imdbRating floatValue] / 2)];
    
    // Setting Movie data to the More Info fields
    [_moviePlotInfoLabel setText:movie.plot];
    [_movieWriterInfoLabel setText:movie.writer];
    [_movieDirectorInfoLabel setText:movie.director];
    [_movieActorsInfoLabel setText:movie.actors];
    [_movieAwardsInfoLabel setText:movie.awards];
    [_movieCountryInfoLabel setText:movie.country];
    [_movieLanguageInfoLabel setText:movie.language];
    
    // Changing the text in the button to "save" or "delete"
    if(movie.onDatabase == YES) [_libraryButton setTitle:@"Delete" forState:UIControlStateNormal];
    else [_libraryButton setTitle:@"Save" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)libraryButton:(id)sender{
    // Handles the button related to Library in the view
    if(movie.onDatabase == NO)
        [self addToLibrary];
    else
        [self removeFromLibrary];
}

- (void)addToLibrary{
    
    NSString * keyString = [[movie.title lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    movie.key = keyString;
    
    [[MoviesListManager sharedInstance] addImage:_poster forKey:keyString];
    [[MoviesListManager sharedInstance] addNewMovie:movie];
    
    NSString *addMessage = [NSString stringWithFormat:@"%@ was added to your library. It is now available offline", movie.title];
    [self showMessage:addMessage];
    
    [_libraryButton setTitle:@"Delete" forState:UIControlStateNormal];
    [_libraryButton setNeedsLayout];
}

- (void)removeFromLibrary{

    NSString *movieTitle = movie.title;
    
    if(movie.onDatabase){
        movie = [movie copy];
        movie.onDatabase = NO;
    }
    
    [[MoviesListManager sharedInstance] removeMovie:movieTitle];
    
    NSString *remMessage = [NSString stringWithFormat:@"%@ was removed from your library. It is not available offline", movieTitle];
    [self showMessage:remMessage];
    
    [_libraryButton setTitle:@"Save" forState:UIControlStateNormal];
    [_libraryButton setNeedsLayout];
}

- (void)showMessage:(NSString *)message{
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Done!"
                                                                        message:message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {}];
    [controller addAction:alertAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowPosterSegue"]){
        PosterViewController *posterVC = segue.destinationViewController;
        posterVC.poster = _poster;
        posterVC.movie = movie;
    }
}

@end
