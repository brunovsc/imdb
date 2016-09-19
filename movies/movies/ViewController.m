//
//  ViewController.m
//  movies
//
//  Created by Bruno Vieira on 9/11/16.
//  Copyright © 2016 Bruno Vieira. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _movies = [[MoviesListManager sharedInstance] getMoviesList];
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)searchPressed:(id)sender{
    [_movieNameTextField resignFirstResponder];
    
    if(![self.movieNameTextField.text isEqualToString:@""]){
        [MBProgressHUDHelper showMBProgressInView:self.view withAnimationType:MBProgressHUDModeIndeterminate withTitle:@"Searching..."];
    
        MovieRealm *m = [[MoviesListManager sharedInstance] movieInLibrary:_movieNameTextField.text];
        if(m == nil){
        
            [[Library sharedHTTPService] getMovieWithName:self.movieNameTextField.text ?: @"" success:^(MovieRealm *response) {
        
                if(! [response.response isEqualToString:@"False"]){
                
                    self.movieFromSearchResult = response;
               
                    MovieRealm *m2 = [[MoviesListManager sharedInstance] movieInLibrary:response.title];
                    
                    if(m2 == nil){
                    
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
                    
                        [self performSegueWithIdentifier:@"ShowDetailsSegue" sender:response];
                    }
                    else{
                        [self movieAlreadyInLibrary:m2];
                    }
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
            [self movieAlreadyInLibrary:m];
        }
    }
    else {
        [self showErrorMessage:@"Empty string"];
        //[self restartSearchText];
    }

}

- (void)movieAlreadyInLibrary:(MovieRealm *)movie{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    NSString *message = [NSString stringWithFormat:@"Your search returned a movie that is already in your database"];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                        message:message
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *showMovieAction = [UIAlertAction actionWithTitle:@"Show Movie"
                                                              style:UIAlertActionStyleDestructive
                                                            handler:^(UIAlertAction *action) {
                                                                [self performSegueWithIdentifier:@"ShowDetailsSegue" sender:movie];
                                                                
                                                            }];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action){
                                                            [controller dismissViewControllerAnimated:YES completion:nil];
                                                        }];
    
    [controller addAction:showMovieAction];
    [controller addAction:alertAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)savePressed:(id)sender{
    [[MoviesListManager sharedInstance] saveAllData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //if(![_movieNameTextField.text isEqualToString:@"Search Movie or Serie"]){
        
        if(![_movieNameTextField.text isEqualToString:@""]){
            if([_searchResultArray count] > 0)
                return [_searchResultArray count];
            else
                return 1;
        }
        else
            return [_movies count];
    //}
    //else return [_movies count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([_searchResultArray count] > 0)
        [self performSegueWithIdentifier:@"ShowDetailsSegue" sender:[_searchResultArray objectAtIndex:indexPath.row]];
    else
        //if(([_movieNameTextField.text isEqualToString:@"Search Movie or Serie"]) || ([_movieNameTextField.text isEqualToString:@""]))
        if([_movieNameTextField.text isEqualToString:@""])
            [self performSegueWithIdentifier:@"ShowDetailsSegue" sender:[_movies objectAtIndex:indexPath.row]];
        else
            [self searchPressed:indexPath];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if( ([_movieNameTextField.text length] > 0) && ([_searchResultArray count] == 0)){// && (![_movieNameTextField.text isEqualToString:@"Search Movie or Serie"]) ){
        MovieListSearchEmptyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieListSearchEmptyTableViewCell"];
        return cell;
    }
    else{
            MovieListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieListCell"];
        
            MovieRealm *m;
            
            if([_searchResultArray count] > 0)
                m = [_searchResultArray objectAtIndex:indexPath.row];
            else
                m = [_movies objectAtIndex:indexPath.row];
            
            cell.titleLabel.text = m.title;
            cell.yearLabel.text = m.year;
            cell.posterImageView.image = [[MoviesListManager sharedInstance] imageForKey:m.key];
            [cell.starRatingView setValue:([m.imdbRating floatValue] / 2)];
            return cell;
    }
}

- (void)showErrorMessage:(NSString *)errorMessage{
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error!"
                                                                        message:errorMessage
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Dismiss"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {  }];
    [controller addAction:alertAction];
    [self presentViewController:controller animated:YES completion:nil];

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

- (IBAction)typingSearch:(id)sender{
    _searchResultArray = [[MoviesListManager sharedInstance] searchMoviesWithKey:_movieNameTextField.text];
    [_tableView reloadData];
}

- (IBAction)touchCancelSearch:(id)sender{
    [_searchResultArray removeAllObjects];
}

@end
