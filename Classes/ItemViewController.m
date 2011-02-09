#import "ItemViewController.h"
#import "Item.h"

@implementation ItemViewController
@synthesize item;

- (id) initWithItem:(Item*)theItem
{
	self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization.
		self.item=theItem;
		self.navigationItem.title=@"Item";
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (section) 
	{
		case 0:
			return @"Name";
		case 1:
			// coupons
			return @"Coupons";
		case 2:
			// items
			return @"Places";
		case 3:
			return @"Notes";
			
	}
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.section) 
	{
		case 0:
			return tableView.rowHeight+4;
		case 1:
			// coupons
			return tableView.rowHeight;
		case 2:
			// items
			return tableView.rowHeight;
		case 3:
			return 158;
			
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    switch (indexPath.section) {
		case 0:
			textField=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, 250,22)];
			textField.text=item.name;
			textField.delegate=self;
			[cell.contentView addSubview:textField];
			cell.accessoryType=UITableViewCellAccessoryNone;
			break;
		case 1:
			cell.textLabel.text=@"Coupons";
			cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 2:
			cell.textLabel.text=@"Places";
			cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
			break;
		case 3:
			textView=[[UITextView alloc] initWithFrame:CGRectMake(6, 10, 278,137)];
			textView.font=[UIFont systemFontOfSize:17];
			textView.text=item.notes;
			textView.delegate=self;
			[cell.contentView addSubview:textView];
			cell.accessoryType=UITableViewCellAccessoryNone;
			break;
			
	}
    return cell;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	if(textField.text.length>0)
	{
		self.item.name=textField.text;
		[self.item save];
	}
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
	self.item.notes=textView.text;
	[self.item save];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if(indexPath.section==1)
	{
		// coupons
		
	}
	if(indexPath.section==2)
	{
		// places
		
	}
}

- (void)dealloc 
{
	[textField release];
	[textView release];
	[item release];
    [super dealloc];
}


@end

