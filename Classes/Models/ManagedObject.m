#import "ManagedObject.h"

@implementation ManagedObject

- (void) save
{
	NSError * error=nil;
	if(![[self managedObjectContext] save:&error])
	{
		NSLog(@"Failed to save managed object: %@",[error userInfo]);
	}
}

- (void) delete
{
	[[self managedObjectContext] deleteObject:self];
	[self save];
}

@end
