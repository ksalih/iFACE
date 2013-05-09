//
//  ChangeUserInfoViewController.m
//  FieldOps Mobile
//
//  Created by Jorge Carvallo on 3/28/13.
//  Copyright (c) 2013 Deloitte  . All rights reserved.
//

#import "ChangeUserInfoViewController.h"
#import "JYStringHelperFunctions.h" 

@interface ChangeUserInfoViewController ()

@end

@implementation ChangeUserInfoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.managedObjectContext = self.currentUser.managedObjectContext;
    
    self.fullName.text = self.currentUser.fullName;
    self.userName.text = self.currentUser.username;
    self.password.text = [JYStringHelperFunctions base64Decode:self.currentUser.password];
    self.verifyPassword.text = self.password.text;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Local Method
- (IBAction)doneButtonAction:(id)sender {
    
    if ([self.password.text isEqual:self.verifyPassword.text]){
        self.currentUser.username = self.userName.text;
        self.currentUser.password = [JYStringHelperFunctions base64Encode:self.password.text];
        self.currentUser.fullName = self.fullName.text;
        NSError *error;
        
        if (![self.managedObjectContext save:&error])
            NSLog(@"Error Saving record");
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self alertMessageWithJustOKButton:@"Please make sure both passowrds match" withTitle:@"Verify Password"];
    }
    
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) alertMessageWithJustOKButton:(NSString *) message withTitle:(NSString *) title{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Ok", nil)
                                              otherButtonTitles:nil];
    [alertView show];
    
}

@end
