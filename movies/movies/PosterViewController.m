//
//  PosterViewController.m
//  movies
//
//  Created by Bruno Vieira on 9/18/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "PosterViewController.h"

@interface PosterViewController ()

@end

@implementation PosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_moviePosterImageView setImage:_poster];
    [_moviePosterImageView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ReturnToDetails"]){
        DetailsViewController *detailsVC = segue.destinationViewController;
        detailsVC.movie = _movie;
        detailsVC.poster = _poster;
    }
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
