#import "PlaceItemsViewController.h"
#import "Item.h"
#import "List.h"
#import "ItemCategory.h"

@implementation PlaceItemsViewController
@synthesize place,items;

- (id) initWithPlace:(Place*)place andItems:(NSArray*)items
{
	self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization.
		self.items=items;
		self.navigationItem.title=@"Items";
		self.place=place;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    return [items count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
	if (cell == nil) 
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    ItemCategory * item=[items objectAtIndex:indexPath.row];
	
	cell.textLabel.text=item.name;
	cell.detailTextLabel.text=[NSString stringWithFormat:@"%@: %@",item.category,item.subCategory];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{    
	NSArray * lists=[[[UIApplication sharedApplication] delegate] lists];
	
	UIActionSheet * actionSheet=[[UIActionSheet alloc] initWithTitle:@"Add to list" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:nil];
	
	for (id list in lists)
	{
		[actionSheet addButtonWithTitle:[list name]];
	}
	
	actionSheet.tag=indexPath.row;
	[actionSheet showFromTabBar:[self tabBarController].tabBar];
	
	[actionSheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==0) return;
	
	NSArray * lists=[[[UIApplication sharedApplication] delegate] lists];
	
	List * list=[lists objectAtIndex:buttonIndex-1];
	
	Item * item=[items objectAtIndex:actionSheet.tag];
	
	// add item to list...
	[list addItemWithName:item.name];
	[list save];
}

- (void)dealloc 
{
	[place release];
	[items release];
    [super dealloc];
}

@end

