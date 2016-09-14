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
    [_movieTitleLabel setText:movie.title];
    [_movieYearLabel setText:movie.year];
    [_movieReleasedLabel setText:movie.released];
    [_movieRuntimeLabel setText:movie.runtime];
    [_movieGenreLabel setText:movie.genre];
    if(movie.isOnLibrary == NO){
        [_addToLibraryButton setTitle:@"Remove from Library" forState:UIControlStateNormal];
    }
    else{
        [_addToLibraryButton setTitle:@"Add to Library" forState:UIControlStateNormal];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addToLibrary:(id)sender {
    if(movie.isOnLibrary == NO){
        movie.isOnLibrary = YES;
        [_addToLibraryButton setTitle:@"Remove from Library" forState:UIControlStateNormal];
        [[MoviesListManager sharedInstance] addMovie:movie];
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
        movie.isOnLibrary = NO;
        [_addToLibraryButton setTitle:@"Add to Library" forState:UIControlStateNormal];
        [[MoviesListManager sharedInstance] removeMovie:movie.title];
        NSString *remMessage = [NSString stringWithFormat:@"%@ removed from your library. It will not be available offline", movie.title];
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
