//
//  ViewController.m
//  HPGDriftButtonMaster
//
//  Created by 何普光 on 2021/5/7.
//

#import "ViewController.h"
#import "DTDriftButton.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DTDriftButton * btn = [[DTDriftButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    btn.driftDockDirection = DTDriftDockDirectionRightAndLeft;
    btn.titleStr = @"按钮";
    btn.rangeBoundary = CGRectMake(100, 100, 200, 500);
    [self.view addSubview:btn];
}


@end
