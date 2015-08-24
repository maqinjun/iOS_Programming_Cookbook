//
//  MultitaskingViewController.m
//  UITest
//
//  Created by maqj on 15/7/11.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "MultitaskingViewController.h"
#import "NewsItem.h"
#import "AppDelegate.h"

#import <AVFoundation/AVFoundation.h>

@interface MultitaskingViewController ()<AVAudioPlayerDelegate>

@property (nonatomic, unsafe_unretained) UIBackgroundTaskIdentifier backgroudTaskIdentifier;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *allNewsItems;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation MultitaskingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self multitasking];
    
    [self backgroudFetch];
    
    [self playAudioInTheBackground];
}

- (void)playAudioInTheBackground{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSError *error = nil;
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        
        [session setActive:YES error:&error];
        
        if ([session setCategory:AVAudioSessionCategoryPlayback error:&error]) {
            NSLog(@"Successfully set the audio session.");
        }else{
            NSLog(@"Failed set the audio session.");
        }
        
        NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp3"];
        NSData *data = [NSData dataWithContentsOfFile:audioPath];
        
        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
        
        if (self.audioPlayer != nil) {
            self.audioPlayer.delegate = self;
            if ([self.audioPlayer prepareToPlay] &&
                [self.audioPlayer play]) {
                NSLog(@"Successfully started paly...");
            }else{
                NSLog(@"Failed to play. ");
            }
        }
    });
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    NSLog(@"Finished play the song.");
    
    if ([player isEqual:self.audioPlayer]) {
        self.audioPlayer = nil;
    }
}

- (void)backgroudFetch{
    
    NSLog(@"%s UIApplicationBackgroundFetchIntervalMinimum %.02f",__FUNCTION__, UIApplicationBackgroundFetchIntervalMinimum);
    NSLog(@"%s UIApplicationBackgroundFetchIntervalNever %.02f",__FUNCTION__, UIApplicationBackgroundFetchIntervalNever);

    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    self.allNewsItems = appDelegate.allNewsItems;
    
    [appDelegate addObserver:self forKeyPath:@"allNewsItems" options:NSKeyValueObservingOptionNew context:NULL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleAppIsBroughtToForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"allNewsItems"]) {
        NSLog(@"%s ", __FUNCTION__);
    }
}

- (void)handleAppIsBroughtToForeground:(NSNotification*)noti{
    NSLog(@"%s %@",__FUNCTION__, _allNewsItems);
}

- (void)multitasking{
    
    if([self isMultitaskingSupported]){
        NSLog(@"Multitasking is supported.");
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                      target:self
                                                    selector:@selector(handleTimer:)
                                                    userInfo:nil
                                                     repeats:YES];
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
           
            int count = 1000;
            while (count > 0) {
                count--;
                
                NSLog(@"MultitaskingViewController %s In dispatch_async %d",__func__, count);
                [NSThread sleepForTimeInterval:1.0f];
            }
            
        });
        
        self.backgroudTaskIdentifier =
        [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^(void){
            [self endBackgroudTask];
        }];
        
    }else{
        NSLog(@"Multitasking is not supported.");
    }
}

- (void)handleTimer:(NSTimer*)paramTimer{
    NSTimeInterval backgroudTimeRemaining = [[UIApplication sharedApplication] backgroundTimeRemaining];
    
    if (backgroudTimeRemaining == DBL_MAX) {
        NSLog(@"Backgroud Time Remaining = Undeterminded.");
    }else{
        NSLog(@"Backgroud Time Remaining = %.02f", backgroudTimeRemaining);
    }
}

- (void)endBackgroudTask{
    __weak MultitaskingViewController *weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        MultitaskingViewController *strongSelf = weakSelf;
        if (strongSelf != nil) {
            [strongSelf.timer invalidate];
            [[UIApplication sharedApplication] endBackgroundTask:self.backgroudTaskIdentifier];
            strongSelf.backgroudTaskIdentifier = UIBackgroundTaskInvalid;
        }
    });
}

- (BOOL)isMultitaskingSupported{
    BOOL result = NO;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)]) {
        result = [[UIDevice currentDevice] isMultitaskingSupported];
    }
    
    return result;
}

- (void)dealloc{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate removeObserver:self forKeyPath:@"allNewsItems"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
