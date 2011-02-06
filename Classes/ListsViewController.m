#import "ListsViewController.h"
#import "ListViewController.h"
#import "List.h"
#import "AddListViewController.h"

@implementation ListsViewController

- (id) init
{
	self=[super initWithStyle:UITableViewStylePlain];
	if(self)
	{
		self.navigationItem.leftBarButtonItem = self.editButtonItem;
		self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)] autorelease];
		self.navigationItem.title=@"Lists";
		self.title=@"Lists";
		
		self.tabBarItem=[[[UITabBarItem alloc] initWithTitle:@"Lists" image:nil tag:1] autorelease];
	}
	return self;
}

- (void) add:(id)sender
{
	AddListViewController * addListView=[[AddListViewController alloc] initWithNibName:@"AddListView" bundle:nil];
	
	addListView.delegate=self;
	[self presentModalViewController:addListView animated:YES];
	
	[addListView release];
}

- (void) addListWithName:(NSString*)name
{
	[delegate addList:name];
	[self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
	[lists release];
	lists=[[delegate lists] retain];
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [lists count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    List * list=[lists objectAtIndex:indexPath.row];
	
	cell.textLabel.text=list.name;
	cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
	cell.detailTextLabel.text=[NSString stringWithFormat:@"%d",[list.items count]];
	
    // Configure the cell...
    
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
		List * list=[lists objectAtIndex:indexPath.row];
		[list delete];
		[delegate reOrderLists];
		[lists release];
		lists=[[delegate lists] retain];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath 
{
	[delegate moveListFromIndex:fromIndexPath.row toIndex:toIndexPath.row];
	[lists release];
	lists=[[delegate lists] retain];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	List * list=[lists objectAtIndex:indexPath.row];
	
	ListViewController * listView=[[ListViewController alloc] initWithList:list];
	
	[self.navigationController pushViewController:listView animated:YES];
	
	[listView release];
}

- (void)dealloc 
{
	[lists release];
    [super dealloc];
}

@end

