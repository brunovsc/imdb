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

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UILabel *imdbLabel;

@property (strong, atomic) NSArray *movies;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _movies = [[[MoviesListManager sharedInstance] getMoviesList] sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSString *first = ((MovieRealm*)a).title;
        NSString *second = ((MovieRealm*)b).title;
        return [first compare:second];
    }];
    
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)searchPressed:(id)sender{
    [_movieNameTextField resignFirstResponder];
    
    if(![self.movieNameTextField.text isEqualToString:@""]){
        [MBProgressHUDHelper showMBProgressInView:self.view withAnimationType:MBProgressHUDModeIndeterminate withTitle:@"Searching movie info..."];
    
        MovieRealm *m = [[MoviesListManager sharedInstance] movieInLibrary:self.movieNameTextField.text];
        if(m == nil){
        
            [[Library sharedHTTPService] getMovieWithName:self.movieNameTextField.text ?: @"" success:^(MovieRealm *response) {
        
                if(! [response.response isEqualToString:@"False"]){
                
                
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
                }
                else{
                    [self showErrorMessage:@"Movie not found"];
                }
        
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

- (IBAction)savePressed:(id)sender{
    [[MoviesListManager sharedInstance] saveAllData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_movies count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"ShowDetailsSegue" sender:[_movies objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieListCell"];
    
    MovieRealm *m;
    m = [_movies objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = m.title;
    cell.yearLabel.text = m.year;
    cell.posterImageView.image = [[MoviesListManager sharedInstance] imageForKey:m.key];
    return cell;
}

- (void)showErrorMessage:(NSString *)errorMessage{
    
    UIAlertView *alert = [[UIAlertView alloc]
                        initWithTitle:@"Error"
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
        if(detailsVC.movie.onDatabase){
            detailsVC.poster = [[MoviesListManager sharedInstance] imageForKey:detailsVC.movie.key];
        }
        else{
            detailsVC.poster = _imageFromSearchResult;
        }
    }
}


@end
