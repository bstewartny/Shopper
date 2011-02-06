#import "ListViewController.h"
#import "List.h"
#import "Item.h"
#import "AddItemViewController.h"
@implementation ListViewController
@synthesize list,items;

- (id) initWithList:(List*)theList
{
	self=[super initWithStyle:UITableViewStylePlain];
	if(self)
	{
		self.list=theList;
		//self.navigationItem.leftBarButtonItem = self.editButtonItem;
		self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)] autorelease];
		self.navigationItem.title=list.name;
		self.title=list.name;
	}
	return self;
}

- (void) addItemsWithNames:(NSArray*)names
{
	for(NSString * name in names)
	{
		if ([name length]>0) 
		{
			[list addItemWithName:name];
		}
	}
	[self.tableView reloadData];
}

- (void) add:(id)sender
{
	AddItemViewController * addItemView=[[AddItemViewController alloc] initWithNibName:@"AddListView" bundle:nil];
	
	addItemView.delegate=self;
	[self presentModalViewController:addItemView animated:YES];
	
	[addItemView release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    // Return the number of sections.
	[items release];
	items=[[list orderedItems] retain]; 
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
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	Item * item = [items objectAtIndex:indexPath.row];
    // Configure the cell...
	
	cell.textLabel.text=item.name;
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
	{
        // Delete the row from the data source.
		Item * item = [items objectAtIndex:indexPath.row];
		[item delete];
		[list reOrderItems];
		[items release];
		items=[[list orderedItems] retain]; 
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath 
{
	[list moveItemFromIndex:fromIndexPath.row toIndex:toIndexPath.row];
	[items release];
	items=[[list orderedItems] retain];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	Item * item = [items objectAtIndex:indexPath.row];
	
}

- (void)dealloc 
{
	[list release];
	[items release];
    [super dealloc];
}

@end

