//
//  MainOPTableViewController.m
//  UITest
//
//  Created by maqj on 15/6/20.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "MainOPTableViewController.h"
#import "UIScrollViewTest.h"
#import "StyledTextTest.h"
#import "UIPageViewControllerTest.h"
#import "GravityUIViewController.h"
#import "CollisionUIViewController.h"
#import "PushBehaviorUIViewController.h"
#import "MultipleDynamicViewController.h"
#import "DynamicSnapEffectViewController.h"
#import "AssigningCharacteristicViewController.h"
#import "MainOPTableViewCell.h"
//#import "TestTableViewCell.h"

#import "CoreDataViewController.h"

#import "CollectionViewController.h"

#import "KeychainItemWrapper.h"

#import <AssetsLibrary/AssetsLibrary.h>

#import <AVFoundation/AVFoundation.h>
//#import <objc/objc.h>
#import <objc/message.h>
#import <QuickLook/QuickLook.h>

@interface MainOPTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) MainOPTableViewCell *heightCell;

@end

enum{
    kControllerWViews = 0,
    kDynamicWInteractive,
    kAutoLayoutVisualFormatLanguage,
    kCollectionVies,
    kCoreLocationMaps,
    kGestureRecognizer,
    kAddressBook,
    kCameraAndThePhotoLibrary,
    kMultitasking,
    kCoreData,
    kGraphicsAndAnimations,
    kCoreMotion
};

enum{
    kUITextView = 0,
    kUIToolBar,
    kUIScrollView,
    kStyledText,
    kUIPageViewController
};

enum{
    kGravity = 0,
    kCollision,
    kPushBehavior,
    kMutipleDynamicToEachOther,
    kDynamicSanp,
    kAssigningCharacteristicsDynamicEffect
};

enum{
    kConstraint = 0,
    kVisualFormatLanguage,
    kStoryboard
};

enum{
    kCollection = 0,
};

enum{
    kMaps = 0,
};

enum{
    kSwipeGestureRecognizer = 0,
};

enum{
    kRequestAccessToTheAdressBook = 0,
};

enum{
    kDetectingProbingTheCamera = 0,
};

enum{
    kMultitaskingSupported = 0,
};

enum{
    kCoreDataCreateAndSaving = 0,
};

enum{
    kFontsTextColorsImages = 0,
    kDrawing,
    kShapes
};

enum{
    kAccelerometer = 0,
};

NSString *cellIdentifier = @"MainOPTalbeViewCell";

@implementation MainOPTableViewController
{
    NSMutableArray *dataSectionTitles;
    NSMutableArray *dataCell;
    BOOL cellClicked;

}
-(void)viewDidLoad{
    
    cellClicked = NO;

//    [self.tableView registerClass:[MainOPTableViewCell class] forCellReuseIdentifier:cellIdentifier];
//    [self.tableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
//    self.tableView.editing = YES;
    self.navigationItem.title = @"Index";
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    dataSectionTitles = [NSMutableArray arrayWithArray:@[@"Controllers and Views",
                                                         @"Dynamic and Interactive User Interface",
                                                         @"Auto Layout Visual Format Language",
                                                         @"Collection Views",
                                                         @"Core Location and Maps",
                                                         @"ImplementingGestureRecognizer",
                                                         @"AddressBook",
                                                         @"Camera and the photo library",
                                                         @"Multitasking",
                                                         @"CoreData",
                                                         @"Graphics and Animations",
                                                         @"Core Motion"]];
    
    dataCell = [NSMutableArray arrayWithArray:@[[NSMutableArray arrayWithArray:@[@"UITextView", @"UIToolBar", @"UIScrollView", @"Styled Texts", @"UIPageViewController"]] ,
                                                [NSMutableArray arrayWithArray:@[@"Adding Gravity to Your UI Components", @"Detecting and Reacting to Collisions Between UI Components", @"Animating with a Push", @"Multiple Dynamic Item to Each Other", @"Dynamic Snap Effect", @"Assigning Characteristics to Your Dynamic Effects"]],
                                                [NSMutableArray arrayWithArray:@[@"Constraint", @"Visual Format Language", @"Storyboard"]],
                                                [NSMutableArray arrayWithArray:@[@"Collection"]],
                                                [NSMutableArray arrayWithArray:@[@"Maps"]],
                                                [NSMutableArray arrayWithArray:@[@"SwipeGestureRecognizer"]],
                                                [NSMutableArray arrayWithArray:@[@"Request Address Book Access."]],
                                                [NSMutableArray arrayWithArray:@[@"Detecting and Probing teh camera"]],
                                                [NSMutableArray arrayWithArray:@[@"Multitasking Supported"]],
                                                [NSMutableArray arrayWithArray:@[@"Create And Saving"]],
                                                [NSMutableArray arrayWithArray:@[@"Fonts Text Colors Images",
                                                                                 @"Drawing", @"Shapes"]],
                                                [NSMutableArray arrayWithArray:@[@"Accelerometer"]]]];
    
    UIBarButtonItem *moveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:@selector(moveCell02Cell2:)];
    self.navigationItem.rightBarButtonItem = moveButton;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
    self.refreshControl.tintColor = [UIColor redColor];
    
    [self.refreshControl addTarget:self action:@selector(endRefresh:) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        int count = 1000;
//        while (count > 0) {
//            count--;
//            
//            NSLog(@"MainOPTableViewController %s In dispatch_async %d",__func__, count);
//            [NSThread sleepForTimeInterval:1.0f];
//        }
//        
//    });
    
    [self frameworkTest];
    
//    [self localSaveTest];
}

- (void)localSaveTest{
    UUIDTool * tool = [UUIDTool shareUUIDTool];
    
//    [tool reset];
    
//    
//    for (int i = 0; i < 100; i++) {
//        [tool saveDownloadAppsInfo:@{@"id":[NSString stringWithFormat:@"com.test.%d", i], @"version":[NSString stringWithFormat:@"%d.0", i]}];
//
//    }
//    
//    NSArray *apps1 = [tool getLocalAppsInfo];
//    
//    [tool deleteMissingAppInfo:@{@"id":[NSString stringWithFormat:@"com.test.%d", 0], @"version":[NSString stringWithFormat:@"%d.0", 0]}];
//    
//    NSArray *apps2 = [tool getLocalAppsInfo];
//    
//
//    [tool saveDownloadAppsInfo:@{@"id":@"com.test.2", @"version":@"2.0"}];
//    [tool saveDownloadAppsInfo:@{@"id":@"com.test.3", @"version":@"3.0"}];
    
//    NSArray *apps2 = [tool getLocalAppsInfo];
    
    AVAudioRecorder *d;


    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
                                                                   message:@"This is an alert."
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    UIAlertAction* action1 = [UIAlertAction actionWithTitle:@"OK1" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];

    
    [alert addAction:defaultAction];
    [alert addAction:action1];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)frameworkTest{
    /*
    NSBundle *b = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/FTServices.framework"];
    BOOL success = [b load];
    
    Class FTDeviceSupport = NSClassFromString(@"FTDeviceSupport");
    id si = [FTDeviceSupport valueForKey:@"sharedInstance"];
    
    NSLog(@"-- %@", [si valueForKey:@"deviceColor"]);
    
    
    NSBundle *bApplication = [NSBundle bundleWithPath:@"/System/Library/Frameworks/MobileCoreServices.framework/MobileCoreServices"];
    
    BOOL is = [bApplication load];
    
    Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
    
    id lsas = [LSApplicationWorkspace valueForKey:@"defaultWorkspace"];
    
    id allApps = [lsas valueForKey:@"allApplications"];
     */
    
//    const char* className = "LSApplicationWorkspace";
    
//    
    NSString *ipaPath = [[NSBundle mainBundle] pathForResource:@"PreSoraka_v1.0_Beta0825" ofType:@"ipa"];
//    NSArray *paths = [[NSBundle mainBundle] pathsForResourcesOfType:@"ipa" inDirectory:@"."];
    
    NSBundle *bApplication = [NSBundle bundleWithPath:@"/System/Library/Frameworks/MobileCoreServices.framework/MobileCoreServices"];
    
    BOOL is = [bApplication load];
    
    Class LSApplicationWorkspace = NSClassFromString(@"LSApplicationWorkspace");
    
    id lsas = [LSApplicationWorkspace valueForKey:@"defaultWorkspace"];

    
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    
    NSObject *workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];

    NSDictionary *options = @{(NSString*)kCFBundleIdentifierKey:@"com.msxt.PreSoraka"};
    //- (BOOL)installApplication:(id)arg1 withOptions:(id)arg2 error:(id*)arg3 usingBlock:(id /* block */)arg4;
    QLPreviewController *ql;

    NSError *error = nil;
    BOOL isOk = NO;
//    (void(*)(objc_msgSend)(id, SEL, id, ...) = objc_msgSend();
    //id objc_msgSend(id self, SEL op, ...)
    void(^block)(id sender) = ^void(id sender){
        NSLog(@"%@", sender);
    };
    
//    isOk = ((id(*)(id, SEL, id, id, id*, id))objc_msgSend)(lsas, @selector(installApplication:withOptions:error:usingBlock:), [NSURL URLWithString:ipaPath], options, &error, block);
    
//    isOk = objc_msgSend(lsas, @selector(installApplication:withOptions:error:), [NSURL URLWithString:ipaPath], options, &error);
    
    isOk = [lsas performSelector:@selector(installApplication:withOptions:) withObject:[NSURL URLWithString:ipaPath] withObject:options];
//    semaphores;
    
//    IBOutletCollection(lsas);
    
}

-(void)endRefresh:(id)sender{
    NSLog(@"refreshing...");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });
}

-(void)moveCell02Cell2:(id)sender{
    [self.tableView moveRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] toIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
//    NSString *section0 = dataSectionTitles[0];
//    NSString *section1 = dataSectionTitles[1];
    [dataSectionTitles exchangeObjectAtIndex:0 withObjectAtIndex:1];
    [dataCell exchangeObjectAtIndex:0 withObjectAtIndex:1];
    
    [self.tableView moveSection:0 toSection:1];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray*)[dataCell objectAtIndex:section]).count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dataSectionTitles.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return dataSectionTitles[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_heightCell) {
        _heightCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    NSArray *sectionCellData = dataCell[indexPath.section];

    _heightCell.label.text = sectionCellData[indexPath.row];
//    _heightCell.label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 10;

    CGSize size = [_heightCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
//    NSLog(@"%s %f %@", __FUNCTION__, size.height+1, sectionCellData[indexPath.row]);
    
    return size.height + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainOPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSArray *sectionCellData = dataCell[indexPath.section];
    
    cell.accessoryType = UITableViewCellAccessoryDetailButton;
    cell.label.text = sectionCellData[indexPath.row];
//    cell.textLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 10;
    cell.accessibilityElementsHidden = YES;
    cell.accessibilityViewIsModal = YES;
    return cell;
}

-(void)reloadCurrentView:(BOOL)clicked{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    CGRect frameBar = self.navigationController.navigationBar.frame;
    CGRect frameTable = self.tableView.frame;
    
    if (clicked) {
        frameBar.origin.y -= frameBar.size.height+20;
        frameTable.origin.y -= frameBar.size.height;
        frameTable.size.height += frameBar.size.height;
    }else{
        frameBar.origin.y += frameBar.size.height+20;
        frameTable.origin.y += frameBar.size.height;
        frameTable.size.height -= frameBar.size.height;
    }
    
    self.tableView.frame = frameTable;
    self.navigationController.navigationBar.frame = frameBar;
    
    [UIView commitAnimations];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"accessoryButtonTappedForRowWithIndexPath:%ld", (long)indexPath.row);
    
    cellClicked = !cellClicked;
    
    [self reloadCurrentView:cellClicked];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld, %ld", (long)editingStyle, (long)indexPath.row);
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *cells = dataCell[indexPath.section];
        [cells removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
}

#pragma mark -- UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    
    NSLog(@"canPerformAction: %@", NSStringFromSelector(action));
    if (action == @selector(copy:)) {
        return YES;
    }
    
    return NO;
}

-(void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    NSLog(@"performAction: %@, withSender: %@", NSStringFromSelector(action), sender);
    if (action == @selector(copy:)) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:cell.textLabel.text];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(void)section1Next:(NSInteger)row withStoryboard:(UIStoryboard*)storyboard{
    UIViewController *vc = nil;
    
    switch (row) {
        case kUITextView:
        case kUIToolBar:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"UITextView_UIToolBar"];
            break;
        case kUIScrollView:
            vc = [[UIScrollViewTest alloc] init];
            break;
        case kStyledText:
            vc = [[StyledTextTest alloc] init];
            break;
        case kUIPageViewController:
        {
            //UIPageViewControllerTransitionStyleScroll
            //UIPageViewControllerSpineLocationMid
            
            NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin] forKey:UIPageViewControllerOptionSpineLocationKey];
            
            vc = [[UIPageViewControllerTest alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
            break;
        }
        default:
            break;
    }
    
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)setctionDynamicInterfaceNex:(NSInteger)row{
    
    UIViewController *vc = nil;
    switch (row) {
        case kGravity:
            vc = [[GravityUIViewController alloc] init];
            break;
        case kCollision:
            vc = [[CollisionUIViewController alloc] init];
            break;
        case kPushBehavior:
            vc = [[PushBehaviorUIViewController alloc] init];
            break;
        case kMutipleDynamicToEachOther:
            vc = [[MultipleDynamicViewController alloc] init];
            break;
        case kDynamicSanp:
            vc = [[DynamicSnapEffectViewController alloc] init];
            break;
        case kAssigningCharacteristicsDynamicEffect:
            vc = [[AssigningCharacteristicViewController alloc] init];
            break;
        default:
            break;
    }
    
    if (vc != nil) {
        [self.navigationController pushViewController:vc animated:YES];
    }

}

-(void)sectionAutoLayoutVisulFormatLanguage:(NSInteger)row{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = nil;
    switch (row) {
        case kConstraint:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"AutoLayoutViewController"];
            break;
        case kVisualFormatLanguage:
        {
            vc = [storyboard instantiateViewControllerWithIdentifier:@"VisualFormatLanguageViewController"];
//            [self presentViewController:vc animated:YES completion:nil];
//            return;
            break;
        }
        case kStoryboard:
        {
            UIStoryboard *testStoryboard = [UIStoryboard storyboardWithName:@"test" bundle:[NSBundle mainBundle]];
            vc = [testStoryboard instantiateViewControllerWithIdentifier:@"StoryboardTest"];
            break;
        }
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)sectionCollectionVies:(NSInteger)row{
    UIViewController *vc = nil;
    
    switch (row) {
        case kCollection:
            vc = [[CollectionViewController alloc] init];
            break;
            
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)sectionCoreLocationMaps:(NSInteger)row{
    UIViewController *vc = nil;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"maps" bundle:[NSBundle mainBundle]];
    
    switch (row) {
        case kMaps:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"MapsViewController"];
            break;
            
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)sectionGestureRecognizer:(NSInteger)row{
    UIViewController *vc = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GestureRecognizer" bundle:[NSBundle mainBundle]];
    switch (row) {
        case kSwipeGestureRecognizer:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"GestureRecognizerViewController"];
            break;
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)sectionAdressBook:(NSInteger)row{
    UIViewController *vc = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AdressBook" bundle:[NSBundle mainBundle]];
    switch (row) {
        case kRequestAccessToTheAdressBook:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"AdressBookViewController"];
            break;
            
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)sectionCameraAndThePhotoLibrary:(NSInteger)row{
    UIViewController *vc = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CameraPhoto" bundle:[NSBundle mainBundle]];
    switch (row) {
        case kDetectingProbingTheCamera:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"CameraPhotoViewController"];
            break;
            
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)sectionMultitasking:(NSInteger)row{
    UIViewController *vc = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Multitasking" bundle:[NSBundle mainBundle]];
    switch (row) {
        case kMultitaskingSupported:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"MultitaskingViewController"];
            break;
            
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)sectionCoreData:(NSInteger)row{
    UIViewController *vc = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CoreData" bundle:[NSBundle mainBundle]];
    switch (row) {
        case kCoreDataCreateAndSaving:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"CoreDataViewController"];
            break;
            
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)sectionGraphicsAndAnimations:(NSInteger)row{
    UIViewController *vc = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"GraphicsAnimations" bundle:[NSBundle mainBundle]];
    switch (row) {
        case kFontsTextColorsImages:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"FTCIViewController"];
            break;
        case kDrawing:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"DrawingViewController"];
            break;
            
        case kShapes:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"ShapesUIViewController"];
            break;
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)sectionCoreMotion:(NSInteger)row{
    UIViewController *vc = nil;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"CoreMotion" bundle:[NSBundle mainBundle]];
    switch (row) {
        case kAccelerometer:
            vc = [storyboard instantiateViewControllerWithIdentifier:@"CoreMotionViewController"];
            break;
            
        default:
            break;
    }
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (cellClicked) {
        cellClicked = !cellClicked;

        [self reloadCurrentView:cellClicked];
    }
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    switch (indexPath.section) {
        case kControllerWViews:
            [self section1Next:indexPath.row withStoryboard:storyBoard];
            break;
        case kDynamicWInteractive:
            [self setctionDynamicInterfaceNex:indexPath.row];
            break;
        case kAutoLayoutVisualFormatLanguage:
            [self sectionAutoLayoutVisulFormatLanguage:indexPath.row];
            break;
        case kCollectionVies:
            [self sectionCollectionVies:indexPath.row];
            break;
        case kCoreLocationMaps:
            [self sectionCoreLocationMaps:indexPath.row];
            break;
        case kGestureRecognizer:
            [self sectionGestureRecognizer:indexPath.row];
            break;
        case kAddressBook:
            [self sectionAdressBook:indexPath.row];
            break;
        case kCameraAndThePhotoLibrary:
            [self sectionCameraAndThePhotoLibrary:indexPath.row];
            break;
        case kMultitasking:
            [self sectionMultitasking:indexPath.row];
            break;
        case kCoreData:
            [self sectionCoreData:indexPath.row];
            break;
        case kGraphicsAndAnimations:
            [self sectionGraphicsAndAnimations:indexPath.row];
            break;
        case kCoreMotion:
            [self sectionCoreMotion:indexPath.row];
            break;
        default:
            break;
    }
    
    
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewCellEditingStyleInsert;
//}
@end
