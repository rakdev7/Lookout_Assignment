//
//  ViewController.h
//  lookout
//
//  Created by Rocky on 1/10/17.
//  Copyright © 2017 Rocky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *emailAlertImageView;
@property (weak, nonatomic) IBOutlet UIButton *remindMeButtonOutlet;
@property (weak, nonatomic) IBOutlet UIButton *markResolvedButtonOutlet;
- (IBAction)remindMeLaterBtn:(id)sender;
- (IBAction)markAsResolvedBtn:(id)sender;


@end

