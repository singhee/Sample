#import "ViewController.h"

#define VIEW_COUNT 10
#define IMG_HEIGHT 320

@interface ViewController () <UIScrollViewDelegate>
@property (strong, nonatomic)UIScrollView *scrollView;
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGSize viewSize = self.view.frame.size;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, (viewSize.height - IMG_HEIGHT)/2, viewSize.width, IMG_HEIGHT)];
    _scrollView.delegate = self;
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _scrollView.contentSize = CGSizeMake(viewSize.width*VIEW_COUNT, IMG_HEIGHT);
    _scrollView.pagingEnabled = YES;
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    self.view.backgroundColor = [UIColor blackColor];
    [self setDismissButton];
    [self.view addSubview:_scrollView];
    
    
    NSArray *colorList = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor]];
    for (NSInteger index = 0; index<VIEW_COUNT; index++) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(index*viewSize.width, 0, viewSize.width, IMG_HEIGHT)];
        view.backgroundColor = [colorList objectAtIndex:index%colorList.count];
        [_scrollView addSubview:view];
    }
}

- (void)setDismissButton {
    UIButton *backButton = [UIButton buttonWithType: UIButtonTypeSystem];
    backButton.frame = CGRectMake(10, 10, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"left-arrow.png"] forState:UIControlStateNormal];
    [backButton setTitle:@"X" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)backAction {
    NSLog(@"ImageViewer Closed!!!!!");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat viewWidth = self.view.frame.size.width;
    NSInteger currentOffset = scrollView.contentOffset.x;
    NSInteger index = currentOffset / viewWidth;
    
    currentOffset = scrollView.contentOffset.x/viewWidth * 10;
    if (currentOffset%10 <5) {
        index = currentOffset / 10;
    } else{
        index = currentOffset / 10 + 1;
    }
}
@end
