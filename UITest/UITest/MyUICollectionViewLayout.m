//
//  MyUICollectionViewLayout.m
//  UITest
//
//  Created by maqj on 15/7/20.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "MyUICollectionViewLayout.h"

@implementation MyUICollectionViewLayout

//- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath{
//    UICollectionViewLayoutAttributes *attribute = [super initialLayoutAttributesForAppearingItemAtIndexPath:itemIndexPath];
//    
//    return attribute;
//}
//
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UICollectionViewLayoutAttributes *attributes =  [super layoutAttributesForItemAtIndexPath:indexPath];
//    
//    CGRect frame = attributes.frame;
//    
//    if (indexPath.item % 2 == 0) {
//        frame.size.height = 100.0f;
//        frame.origin.y -= 50.0f;
//    }
//    
//    return attributes;
//}

- (void)prepareLayout{
    
}

- (CGSize)collectionViewContentSize{
    
    CGSize size = [super collectionViewContentSize];
    
    return size;
}

- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *attributes = [NSMutableArray arrayWithArray:arr];
    
    for (int i = 0; i < attributes.count; i++) {
        UICollectionViewLayoutAttributes *attribute = [attributes objectAtIndex:i];
        NSString *kind = attribute.representedElementKind;
        if (kind == nil &&
            i % 2 == 0) {
             CGRect frame = attribute.frame;

            frame.origin.y += frame.size.height/2;
            
            attribute.frame = frame;
        }
    }
    
    return attributes;
}

@end
