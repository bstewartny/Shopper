#import "Item.h"

@implementation Item
@dynamic uid;
@dynamic name;
@dynamic order;
@dynamic list;

- (NSComparisonResult)compareItem:(Item*)i
{
	return [self.order compare:i.order];
}

@end
