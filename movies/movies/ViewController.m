//
//  ViewController.m
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *movieNameTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) MovieRealm *movieFromSearchResult;
@property (strong, nonatomic) UIImage *imageFromSearchResult;

@property (weak, nonatomic) IBOutlet UILabel *imdbLabel;

@property (strong, atomic) NSMutableArray *movies;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _movies = [[MoviesListManager sharedInstance] getMoviesList];
    
    UIFont *font = _imdbLabel.font;
    _imdbLabel.font = [font fontWithSize:24];
    
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*)downloadAndSaveImage:(NSString*)url{
    
    
    
    return nil;
}


-(IBAction)searchPressed:(id)sender{
    [_movieNameTextField resignFirstResponder];
    
    if(![self.movieNameTextField.text isEqualToString:@""]){
        [MBProgressHUDHelper showMBProgressInView:self.view withAnimationType:MBProgressHUDModeIndeterminate withTitle:@"Searching movie info..."];
    
        MovieRealm *m = [[MoviesListManager sharedInstance] movieInLibrary:self.movieNameTextField.text];
        if(m == nil){
        
            [[Library sharedHTTPService] getMovieWithName:self.movieNameTextField.text ?: @"" success:^(MovieRealm *response) {
        
                self.movieFromSearchResult = response;
               
                NSLog(@"%@", response.poster);
                NSString *urlStringHttps;
                if(![response.poster isEqualToString:@"N/A"]){
                    urlStringHttps = [response.poster stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
                }
                else{
                    urlStringHttps = @"https://cdn.amctheatres.com/Media/Default/Images/noposter.jpg";
                }
                
                NSURL *imgURL = [NSURL URLWithString:urlStringHttps];
                NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
                _imageFromSearchResult = [UIImage imageWithData:imgData];
                NSLog(@"Downloaded image");
                
                
                [self performSegueWithIdentifier:@"ShowDetailsSegue" sender:response];
        
            } failure:^(NSError *error) {
                NSString *errorMessage = [NSString stringWithFormat:@"Error!\n %@", error.description];
                [self showErrorMessage:errorMessage];
            }];
        }
        else {
            [self performSegueWithIdentifier:@"ShowDetailsSegue" sender:m];
        }
    }
    else {
        NSString *errorMessage = @"Empty string\n";
        [self showErrorMessage:errorMessage];
    }

}
/*
- (void)loadViewImageView:(UIImageView *)imageView fromUrlString:(NSString *)urlString{
    
    NSString *urlStringHttps = [urlString stringByReplacingOccurrencesOfString:@"http" withString:@"https"];
    NSURL *imgURL = [NSURL URLWithString:urlStringHttps];
    NSData *imgData = [NSData dataWithContentsOfURL:imgURL];
    imageView.image = [UIImage imageWithData:imgData];
    
    [imageView setNeedsLayout];
}*/

- (IBAction)savePressed:(id)sender{
    //NSLog(@"Save not yet implemented");
    [[MoviesListManager sharedInstance] saveData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_movies count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowDetailsSegue" sender:[_movies objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MovieListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieListCell"];
    
    MovieRealm *m = [_movies objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = m.title;
    cell.yearLabel.text = m.year;
    cell.posterImageView.image = [[MoviesListManager sharedInstance] imageForKey:m.key];
    return cell;
}

- (void)showErrorMessage:(NSString *)errorMessage{
    
    UIAlertView *alert = [[UIAlertView alloc]
                        initWithTitle:@"ERROR"
                        message:errorMessage
                        delegate:self
                        cancelButtonTitle:@"OK"
                        otherButtonTitles:nil];
    [alert show];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"ShowDetailsSegue"]){
        DetailsViewController *detailsVC = segue.destinationViewController;
        detailsVC.movie = sender;
        if(detailsVC.movie.isOnLibrary){
            detailsVC.poster = [[MoviesListManager sharedInstance] imageForKey:detailsVC.movie.key];
        }
        else{
            detailsVC.poster = _imageFromSearchResult;
        }
    }
}


@end
