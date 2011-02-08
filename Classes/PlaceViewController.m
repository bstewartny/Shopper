#import "PlaceViewController.h"
#import "Place.h"
#import "MapViewController.h"

@implementation PlaceViewController
@synthesize place;

- (id) initWithPlace:(Place*)thePlace
{
	self=[super initWithStyle:UITableViewStyleGrouped];
	if(self)
	{
		self.place=thePlace;
		self.navigationItem.rightBarButtonItem=[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)] autorelease];
		self.navigationItem.title=@"Place";
		self.title=@"Place";
	}
	return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    // Return the number of rows in the section.
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    switch (indexPath.section) 
	{
		
		case 0:
			// name
			cell.textLabel.text=place.name;
			cell.accessoryType=UITableViewCellAccessoryNone;
			break;
		case 1:
			// categories
			cell.textLabel.text=place.category;
			cell.accessoryType=UITableViewCellAccessoryNone;
			break;
		case 2:
			// location
			if([place.address length]>0)
			{
				cell.textLabel.text=place.address;
			}
			else 
			{
				cell.textLabel.text=@"Show on map";
			}

			cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 3:
			// coupons
			cell.textLabel.text=@"Coupons";
			cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 4:
			// items
			cell.textLabel.text=@"Items";
			cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
			break;
	}
	
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (section) 
	{
		case 0:
			return @"Name";
		case 1:
			// categories
			return @"Category";
		case 2:
			// location
			return @"Location";
		case 3:
			// coupons
			return @"Coupons";
		case 4:
			// items
			return @"Items";
			
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if(indexPath.section==2)
	{
		MapViewController * mapView=[[MapViewController alloc] initWithPlaces:[NSArray arrayWithObject:place] index:0];
	
		[self.navigationController pushViewController:mapView animated:YES];
	
		[mapView release];
	}
}


- (void)dealloc {
	[place release];
    [super dealloc];
}


@end

