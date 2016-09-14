//
//  TableViewCell.h
//  movies
//
//  Created by Bruno Vieira on 9/14/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;

@end
