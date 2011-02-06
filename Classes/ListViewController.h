#import <UIKit/UIKit.h>

@class List;
@interface ListViewController : UITableViewController {
	List * list;
	NSArray * items;
}
@property(nonatomic,retain) List * list;
@property(nonatomic,retain) NSArray * items;
- (id) initWithList:(List*)theList;

@end
