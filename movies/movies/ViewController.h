//
//  ViewController.h
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Library.h"
#import "MoviesListManager.h"
#import "DetailsViewController.h"
#import "MBProgressHUDHelper.h"
#import "MovieListTableViewCell.h"

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>


-(IBAction)searchPressed:(id)sender;

@end

