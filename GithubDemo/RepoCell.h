//
//  RepoCell.h
//  GithubDemo
//
//  Created by Devin Bhushan on 9/15/15.
//  Copyright © 2015 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *repoName;
@property (weak, nonatomic) IBOutlet UIImageView *forkImage;
@property (weak, nonatomic) IBOutlet UILabel *forkLabel;
@property (weak, nonatomic) IBOutlet UIImageView *starImage;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@end
