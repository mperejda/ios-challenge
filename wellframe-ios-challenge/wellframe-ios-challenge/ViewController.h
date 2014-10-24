#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) NSMutableData *responseData;
@property (retain, nonatomic) NSArray *images;
@property (retain, nonatomic) NSArray *names;
@property (retain, nonatomic) NSArray *messages;
@property (retain, nonatomic) NSArray *links;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

