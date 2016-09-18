//
//  PosterViewController.h
//  movies
//
//  Created by Bruno Vieira on 9/18/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "ViewController.h"

@interface PosterViewController : UIViewController

@property (strong, nonatomic) UIImage *poster;
@property IBOutlet UIImageView *moviePosterImageView;
@property IBOutlet UIButton *returnButton;
@property (strong, nonatomic) MovieRealm *movie;

@end
