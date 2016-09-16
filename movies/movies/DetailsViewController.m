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
    [_movieRatingInfoLabel setText:movie.imdbRating];
    
    [_moviePlotInfoLabel setText:movie.plot];
    [_movieWriterInfoLabel setText:movie.writer];
    [_movieDirectorInfoLabel setText:movie.director];
    [_movieActorsInfoLabel setText:movie.actors];
    [_movieAwardsInfoLabel setText:movie.awards];
    
    [_moviePosterImageView setImage:_poster];
    [_moviePosterImageView setNeedsDisplay];
    [_moviePosterImageView setNeedsLayout];
    
    if(movie.isOnLibrary == YES){
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
        
        NSString * keyString = [[movie.title lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        movie.isOnLibrary = YES;
        movie.key = keyString;
        
        [_addToLibraryButton setTitle:@"Remove from Library" forState:UIControlStateNormal];
        [[MoviesListManager sharedInstance] addMovie:movie];
        [[MoviesListManager sharedInstance] addImage:_poster forKey:keyString];
        
        NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString * basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        
        
        NSString * keyPNG = [NSString stringWithFormat:@"%@.png",keyString];
        //UIImage * imageToSave = [UIImage imageNamed:keyPNG];
        NSData * binaryImageData = UIImagePNGRepresentation(_poster);
        
        [binaryImageData writeToFile:[basePath stringByAppendingPathComponent:keyPNG] atomically:YES];
        
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
