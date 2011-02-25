#import <UIKit/UIKit.h>

@class Place;
@interface PlaceItemsViewController : UITableViewController 
{
	Place * place;
	NSArray * items;
}
@property(nonatomic,retain) Place * place;
@property(nonatomic,retain) NSArray * items;

- (id) initWithPlace:(Place*)place andItems:(NSArray*)items;

@end
