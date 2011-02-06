#import <UIKit/UIKit.h>
#import "ShopperDelegate.h"

@interface ShopperTableViewController : UITableViewController {
	id<ShopperDelegate>  delegate;
}
@property(nonatomic,assign) id<ShopperDelegate> delegate;
@end
