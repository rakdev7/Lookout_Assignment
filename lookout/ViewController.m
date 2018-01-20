//
//  ViewController.m
//  lookout
//
//  Created by Rocky on 1/10/17.
//  Copyright © 2017 Rocky. All rights reserved.
//

#import "ViewController.h"
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //add shadow to buttons
    [self addShadowToButtons];
    
    
    //read data from local file
    [self readDataFromJson];
    
    //changing the color of image to red
    self.emailAlertImageView.image = [self.emailAlertImageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self.emailAlertImageView setTintColor:[UIColor colorWithRed:218.0/255.0 green:0.0/255.0 blue:27.0/255.0 alpha:100.0]];
    
    
  }

-(void)readDataFromJson {
    
    //read JSON file from local directory
    NSString * filePath =[[NSBundle mainBundle] pathForResource:@"email-alert" ofType:@"json"];
    //convert data to dictonary object
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSError * error;
    if(error)
    {
        NSLog(@"Error reading file: %@",error.localizedDescription);
    }
    
    NSArray *eventArray = jsonDict[@"events"];
    NSDictionary *eventDict = eventArray[0];
    NSDictionary *dataDict = [eventDict objectForKey:@"data"];
    
    //assigning data read from JSON file to labels
    self.userEmail.text = [dataDict objectForKey:@"email"];
    self.fromLabel.text = [NSString stringWithFormat:@"From: %@", [dataDict objectForKey:@"Source"]];
    NSString *dateString = [eventDict objectForKey:@"date"];
    
    //Using date formatter to display date in DD-MM-YYYY format to the user
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter dateFromString:dateString];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    NSString *showingDate = [formatter stringFromDate:date];
    
    self.dateLabel.text = [NSString stringWithFormat:@"Date of leak: %@",showingDate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)contactUsBtn:(id)sender {

    [self alertUtility:@"Contact us" body:@"Call our experts for help." button1:@"Cancel" button2:@"Call"];
    
}
- (IBAction)remindMeLaterBtn:(id)sender {
    
    [self alertUtility:@"Reminder scheduled" body:@"We’ll remind you about this alert tomorrow." button1:@"OK" button2:@"nil"];
    
}

- (IBAction)markAsResolvedBtn:(id)sender {

    [self alertUtility:@"Are you sure?" body:@"Marking an alert as resolved means you will no longer be alerted on this leak and the alert will be removed." button1:@"Cancel" button2:@"Yes"];
    
}

//Method to add shadows

-(void)addShadowToButtons {
    
    self.remindMeButtonOutlet.layer.shadowColor = [UIColor colorWithRed:12.0/255.0 green:133.0/255.0 blue:63.0/255.0 alpha:1].CGColor;
    self.remindMeButtonOutlet.layer.shadowOffset = CGSizeMake(0, 3.0);
    self.remindMeButtonOutlet.layer.shadowOpacity = 1.0;
    self.remindMeButtonOutlet.layer.shadowRadius = 0.0;
    
    self.markResolvedButtonOutlet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.markResolvedButtonOutlet.layer.shadowOffset = CGSizeMake(0, 3.0);
    self.markResolvedButtonOutlet.layer.shadowOpacity = 1.0;
    self.markResolvedButtonOutlet.layer.shadowRadius = 0.0;
    
}

// Alert utility to show the popup alert when a button is clicked

-(void)alertUtility:(NSString *)title body:(NSString *)body button1:(NSString*)btn1 button2:(NSString *)btn2{

    UIAlertController *alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:body
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *button1 = [UIAlertAction
                         actionWithTitle:btn1
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction *button2 = [UIAlertAction
                             actionWithTitle:btn2
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:button1];
    //check if both buttons are being used
    if (![btn2 isEqualToString:@"nil"]) {
        [alert addAction:button2];
    }
       [self presentViewController:alert animated:YES completion:nil];
    
}

@end
