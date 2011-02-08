#import <UIKit/UIKit.h>

@class Place;
@interface PlaceViewController : UITableViewController 
{
	Place * place;

}
@property(nonatomic,retain) Place * place;
- (id) initWithPlace:(Place*)place;

@end
