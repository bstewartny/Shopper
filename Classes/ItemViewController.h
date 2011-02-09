#import <UIKit/UIKit.h>

@class Item;
@interface ItemViewController : UITableViewController<UITextFieldDelegate,UITextViewDelegate> {
	Item * item;
	UITextView * textView;
	UITextField * textField;
}
@property(nonatomic,retain) Item * item;

- (id) initWithItem:(Item*)item;

@end
