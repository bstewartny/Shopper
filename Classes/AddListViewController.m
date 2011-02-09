#import "AddListViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation AddListViewController
@synthesize delegate;

- (IBAction) add:(id)sender
{
	if([textField.text length]>0)
	{
		[delegate addListWithName:textField.text];
		[self.parentViewController dismissModalViewControllerAnimated:YES];
	}
}

- (IBAction) cancel:(id)sender
{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 250,22)];
	textField.placeholder=@"List name";
	[textField becomeFirstResponder];
	[cell.contentView addSubview:textField];
	
    return cell;
}

- (void)dealloc {
	[textField release];
    [super dealloc];
}


@end
