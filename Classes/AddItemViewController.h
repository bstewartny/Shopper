#import <UIKit/UIKit.h>

@interface AddItemViewController : UIViewController<UITableViewDelegate,UITableViewDataSource> {
	id delegate;
	UITextView * textView;
}
@property(nonatomic,retain) id delegate;

@end
