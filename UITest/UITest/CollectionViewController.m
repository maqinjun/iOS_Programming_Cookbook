//
//  CollectionViewController.m
//  UITest
//
//  Created by maqj on 15/6/29.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "CollectionViewController.h"
#import "HeaderFooterView.h"
#import "MyUICollectionViewLayout.h"

@interface CollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@end

static NSString *const kCellIdentifer = @"kCellIdentifer";
static NSString *const kSectionHeader = @"kSectionHeader";
static NSString *const kSectionFooter = @"kSectionFooter";

@implementation CollectionViewController
{
    NSMutableArray *dataSectionTitles;
    NSMutableArray *dataCollectionCells;
    
//    UICollectionViewFlowLayout *leftFlowLayout;
//    UICollectionViewFlowLayout *rightFlowLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSectionTitlesData];
    [self initCollectionCellsData];
    
    [self initCollectionView];
   
}

-(void)initCollectionView{
//    leftFlowLayout = [self layoutCreater:180.0f];
//    rightFlowLayout = [self layoutCreater:210.0f];
    MyUICollectionViewLayout *flowLayout = [[MyUICollectionViewLayout alloc] init];
    
    flowLayout.minimumLineSpacing  = 20.0f;
    flowLayout.minimumInteritemSpacing = 10.0f;
    flowLayout.itemSize = CGSizeMake(130.0f, 180.0f);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(10.0f, 20.0f, 10.0f, 20.0f);
    //    layout.estimatedItemSize = CGSizeMake(100.0f, 300.0f);
    flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 50.0f);
    flowLayout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 100.0f);

    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifer];
    
    [self.collectionView registerClass:[HeaderFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSectionHeader];
    [self.collectionView registerClass:[HeaderFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kSectionFooter];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //    self.collectionView.scrollEnabled = YES;
    
    [self.view addSubview:self.collectionView];
    
    UIPinchGestureRecognizer *gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    
    for(UIGestureRecognizer *recoginer
        in self.collectionView.gestureRecognizers){
        if ([recoginer isKindOfClass:[gesture class]]) {
            [recoginer requireGestureRecognizerToFail:gesture];
        }
    }
    
    [self.collectionView addGestureRecognizer:gesture];
}

-(void)handleGesture:(UIPinchGestureRecognizer*)gestureRecognizer{
    CGSize defaultSize = CGSizeMake(130.0f, 180.0f);
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)self.collectionView.collectionViewLayout;
    
    layout.itemSize = CGSizeMake(defaultSize.width * gestureRecognizer.scale, defaultSize.height * gestureRecognizer.scale);
    
    [layout invalidateLayout];
}

-(void)initSectionTitlesData{
    dataSectionTitles = [NSMutableArray arrayWithArray:@[@"Section0", @"Section1"]];
}

-(void)initCollectionCellsData{
    dataCollectionCells = [NSMutableArray arrayWithArray:@[[NSMutableArray arrayWithArray:@[@"0 cell0", @"0 cell1", @"0 cell2", @"0 cell3"]],
                                                           [NSMutableArray arrayWithArray:@[@"1 cell0", @"1 cell1", @"1 cell2", @"1 cell3", @"1 cell4", @"1 cell5", @"1 cell6", @"1 cell7", @"1 cell8", @"1 cell9"]]]];
}

-(UICollectionViewFlowLayout*)layoutCreater:(CGFloat)height{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing  = 20.0f;
    layout.minimumInteritemSpacing = 10.0f;
    layout.itemSize = CGSizeMake(130.0f, height);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(10.0f, 20.0f, 10.0f, 20.0f);
//    layout.estimatedItemSize = CGSizeMake(100.0f, 300.0f);
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 50.0f);
    layout.footerReferenceSize = CGSizeMake(self.view.frame.size.width, 100.0f);
    
    return layout;
}

#pragma mark -- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect lastFrame = cell.frame;
    if (cell) {
        [UIView animateWithDuration:0.5f animations:^{
            cell.alpha = 0.0f;
//            cell.frame = [UIScreen mainScreen].bounds;
        } completion:^(BOOL finished) {
            cell.alpha = 1.0f;
//            cell.frame = lastFrame;
        }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.2f animations:^{
        cell.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.2f animations:^{
        cell.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    }];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    if (action == @selector(copy:)) {
        UICollectionViewCell *cell = (UICollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        UILabel *label = (UILabel*)[cell viewWithTag:100];
        [[UIPasteboard generalPasteboard] setString:label.text];
    }
}

#pragma mark -- UICollectionViewDataSource

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifer = kSectionHeader;
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        identifer = kSectionFooter;
    }
    
    HeaderFooterView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifer forIndexPath:indexPath];
    
    UILabel *label = (UILabel*)[view viewWithTag:200];
    
    if (!label) {
        label = [[UILabel alloc] init];
        
        label.frame = CGRectMake(10.0f, 0.0f, self.view.frame.size.width, 50.0f);
//        label.backgroundColor = [UIColor grayColor];
        label.tag = 200;
        [view addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%@ %ld-%ld", identifer, indexPath.section, indexPath.row];

    return view;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray *items = dataCollectionCells[section];
    
    NSLog(@"numberOfItemsInSection: section = %ld, count = %ld",section, items.count);
    return items.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSLog(@"numberOfSectionsInCollectionView: count = %ld", dataCollectionCells.count);
    return dataSectionTitles.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"cellForItemAtIndexPath: section = %ld, row = %ld", indexPath.section, indexPath.row);
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifer forIndexPath:indexPath];
    
    NSMutableArray *cellsData = dataCollectionCells[indexPath.section];
    
    UILabel *label = (UILabel*)[cell viewWithTag:100];
    
    if (!label) {
        label = [[UILabel alloc] init];
        label.tag = 100;
        label.frame = CGRectMake(0.0f, 0.0f, cell.frame.size.width, cell.frame.size.height);
        [cell addSubview:label];
    }
    
    label.text = cellsData[indexPath.row];
    
    cell.backgroundColor = [UIColor redColor];
    
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)collectionView.collectionViewLayout;
    
//    if (indexPath.row%2 == 0) {
//        layout.itemSize = CGSizeMake(130.0f, 210.0f);
//    }else{
//        layout.itemSize = CGSizeMake(130.0f, 180.0f);
//    }
//    
//    [layout invalidateLayout];
    
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//    
//    CGSize size = flowLayout.itemSize;
//    
//    if (indexPath.item %2 == 0) {
//        size.height = 100.0f;
//    }
////    else{
////        size.height = 200.0f;
////    }
//    
//    return size;
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//
//    return flowLayout.sectionInset;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//    return flowLayout.minimumLineSpacing;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//    return flowLayout.minimumInteritemSpacing;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//    return flowLayout.headerReferenceSize;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
//    return flowLayout.footerReferenceSize;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
