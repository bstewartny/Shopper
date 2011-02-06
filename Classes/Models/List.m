#import "List.h"
#import "Item.h"
#import "UUID.h"

@implementation List
@dynamic uid;
@dynamic name;
@dynamic order;
@dynamic items;

- (NSArray*) orderedItems
{
	NSMutableArray * tmp=[[NSMutableArray alloc] init];
	
	for(Item * item in self.items)
	{
		[tmp addObject:item];
	}
	
	[tmp sortUsingSelector:@selector(compareItem:)];
	
	return [tmp autorelease];
}

- (Item*) addItemWithName:(NSString*)name
{
	Item * item=[NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[self managedObjectContext]];
				 
	item.uid=[UUID GetUUID];
	item.name=name;
	item.list=self;
	int count=[self.items count];
	item.order=[NSNumber numberWithInt:count];
	
	NSLog(@"adding item with order: %d",count);
	[item save];
	
	return item;
}

- (void) reOrderItems
{
	int count=0;
	for(Item * item in [self orderedItems])
	{
		item.order=[NSNumber numberWithInt:count];
		count++;
	}
	[self save];
}

- (void) moveItemFromIndex:(int)fromIndex toIndex:(int)toIndex
{
	NSLog(@"moveItemFromIndex: %d to %d",fromIndex,toIndex);
	// get item at index
	NSArray * a=[self orderedItems];
	
	NSMutableArray * tmp=[NSMutableArray arrayWithArray:a];
	
	id item=[tmp objectAtIndex:fromIndex];
	
	[tmp removeObjectAtIndex:fromIndex];
	
	if(toIndex<fromIndex)
	{
		NSLog(@"insert object at index: %d",toIndex);
		[tmp insertObject:item atIndex:toIndex];
	}
	else 
	{
		NSLog(@"insert object at index: %d",(toIndex));
		[tmp insertObject:item atIndex:toIndex];
	}
	
	// now renumber from 0...
	int displayOrder=0;
	BOOL needsSaved=NO;
	
	for(Item * item in tmp)
	{
		 
		NSNumber * currentOrder=item.order;
		if([currentOrder intValue]!=displayOrder)
		{
			NSLog(@"Changing displayOrder form %d to %d",[currentOrder intValue],displayOrder);
			[item setOrder:[NSNumber numberWithInt:displayOrder]];
			needsSaved=YES;
		}
		 
		displayOrder++;
	}
	
	if(needsSaved)
	{
		[self save];
	}
}


@end
