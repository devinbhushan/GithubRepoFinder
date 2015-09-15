//
//  RepoResultsViewController.m
//  GithubDemo
//
//  Created by Nicholas Aiwazian on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import "RepoResultsViewController.h"
#import "MBProgressHUD.h"
#import "GithubRepo.h"
#import "GithubRepoSearchSettings.h"
#import "RepoCell.h"

@interface RepoResultsViewController () <UITableViewDataSource,
                                         UITableViewDelegate>

@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) GithubRepoSearchSettings *searchSettings;
@property(weak, nonatomic) IBOutlet UITableView *repoTableView;
@property(weak, nonatomic) IBOutlet RepoCell *repoCell;
@property(nonatomic, strong) NSArray *repos;
@end

@implementation RepoResultsViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.repoTableView.delegate = self;
  self.repoTableView.dataSource = self;

  self.searchSettings = [[GithubRepoSearchSettings alloc] init];
  self.searchBar = [[UISearchBar alloc] init];
  self.searchBar.delegate = self;
  [self.searchBar sizeToFit];
  self.navigationItem.titleView = self.searchBar;
  [self doSearch];
}

- (void)doSearch {
  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  [GithubRepo
           fetchRepos:self.searchSettings
      successCallback:^(NSArray *repos) {
        for (GithubRepo *repo in repos) {
          NSLog(@"%@",
                [NSString
                    stringWithFormat:@"Name:%@\n\tStars:%ld\n\tForks:%ld,Owner:"
                                     @"%@\n\tAvatar:%@\n\tDescription:%@\n\t",
                                     repo.name, repo.stars, repo.forks,
                                     repo.ownerHandle, repo.ownerAvatarURL,
                                     repo.repoDescription]);
          _repos = repos;
          [self.repoTableView reloadData];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
      }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 10;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  RepoCell *cell =
      [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.repoCell"];

  GithubRepo *repo = self.repos[indexPath.section];

  cell.repoName.text = repo.name;
  cell.forkLabel.text = [NSString stringWithFormat:@"%d", (int)repo.forks];
  cell.starLabel.text = [NSString stringWithFormat:@"%d", (int)repo.stars];

  return cell;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
  [self.searchBar setShowsCancelButton:YES animated:YES];
  return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
  [self.searchBar setShowsCancelButton:NO animated:YES];
  return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
  searchBar.text = @"";
  [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  self.searchSettings.searchString = searchBar.text;
  [searchBar resignFirstResponder];
  [self doSearch];
}

- (void)tableView:(UITableView *)tableView
    didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
