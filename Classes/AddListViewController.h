#import <UIKit/UIKit.h>

@interface AddListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
	id delegate;
	UITextField * textField;
}
@property(nonatomic,retain) id delegate;

- (IBAction) add:(id)sender;
- (IBAction) cancel:(id)sender;

@end
