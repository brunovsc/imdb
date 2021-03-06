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
#import "MovieListSearchEmptyTableViewCell.h"

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *imdbLabel;

@property (strong, atomic) IBOutlet UITextField *movieNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) MovieRealm *movieFromSearchResult;
@property (strong, nonatomic) UIImage *imageFromSearchResult;

@property BOOL isEditing;

@property (strong, atomic) NSArray *movies;

@property (strong, atomic) NSMutableArray *searchResultArray;

-(IBAction)searchPressed:(id)sender;

@end

