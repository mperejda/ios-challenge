#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (copy, nonatomic) NSArray *tableData;
@property (retain, nonatomic) NSMutableData *responseData;
@property (retain, nonatomic) NSArray *images;
@property (retain, nonatomic) NSArray *imagesData;
@property (retain, nonatomic) NSArray *names;
@property (retain, nonatomic) NSArray *messages;
@property (retain, nonatomic) NSArray *links;
@property (assign) id delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

