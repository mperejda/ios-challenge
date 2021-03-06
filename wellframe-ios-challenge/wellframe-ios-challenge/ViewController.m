#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //get data on commits
    NSURL *nsURL = [NSURL URLWithString:@"https://api.github.com/repos/rails/rails/commits"];
    
    NSLog(@"URL set to: %@", nsURL);
    
    NSMutableURLRequest *nsMutableURLRequest = [[NSMutableURLRequest alloc] initWithURL:nsURL];
    
    // Set the request's content type to application/x-www-form-urlencoded
    [nsMutableURLRequest setValue:@"Content-Type: application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Set HTTP method to POST
    [nsMutableURLRequest setHTTPMethod:@"GET"];
    
    // Create NSURLConnection and start the request.
    NSURLConnection *nsUrlConnection=[[NSURLConnection alloc]initWithRequest:nsMutableURLRequest delegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// Checking the linkage between app and nsUrlConnection
- (void)connection:(NSURLConnection *)nsUrlConnection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
    
    NSLog(@"did recieve response: %@", _responseData);
}

//Get and parse data from github API
- (void)connection:(NSURLConnection *)nsUrlConnection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
    
    NSError* error;
    NSDictionary* githubData = [NSJSONSerialization
                          JSONObjectWithData:_responseData
                          options:kNilOptions
                          error:&error];
    
    NSLog(@"github Data Recieved");
    
    self.images = [[githubData valueForKey:@"author"] valueForKey:@"avatar_url"];
    self.names = [[[githubData valueForKey:@"commit"] valueForKey:@"author"] valueForKey:@"name"];
    self.messages = [[githubData valueForKey:@"commit"] valueForKey:@"message"];
    self.links = [githubData valueForKey:@"html_url"];
    
    
    NSLog(@"images: %@", _images);
    NSLog(@"names: %@", _names);
    NSLog(@"messages: %@", _messages);
    NSLog(@"links: %@", _links);

   [self.tableView reloadData];
    
    NSLog(@"table reloaded");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)nsUrlConnection {
    
    NSLog(@"Response Recieved");
}

- (void)connection:(NSURLConnection *)nsUrlConnection didFailWithError:(NSError *)error {
    NSLog(@"CONNECTION ERROR: %@", [error localizedDescription]);
}

//Table View Setup

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_names count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *simpleIdentifier = @"simpleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleIdentifier];
    }
    

    
 // implement caching and add images.
//    cell.imageView.image =  [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [_images objectAtIndex:indexPath.row]]]];
    
    cell.textLabel.text = [_names objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [_messages objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.links[indexPath.row]]];
    
}

@end
