#import "CouponViewController.h"
#import "Coupon.h"

@implementation CouponViewController

- (id) init
{
	self=[super initWithStyle:UITableViewStylePlain];
	if(self)
	{
		self.navigationItem.leftBarButtonItem = self.editButtonItem;
		self.navigationItem.title=@"Coupons";
		self.title=@"Coupons";
		
		self.tabBarItem=[[[UITabBarItem alloc] initWithTitle:@"Coupons" image:nil tag:2] autorelease];
	}
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	[coupons release];
	coupons=[[delegate coupons] retain];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [coupons count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    Coupon * coupon=[coupons objectAtIndex:indexPath.row];
	
	cell.textLabel.text=coupon.title;
	cell.detailTextLabel.text=coupon.text;
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
		Coupon * coupon=[coupons objectAtIndex:indexPath.row];
		[coupon delete];
		[coupons release];
		coupons=[[delegate coupons] retain];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}

- (void)dealloc {
	[coupons release];
    [super dealloc];
}


@end

