//
//  CameraPhotoViewController.m
//  UITest
//
//  Created by maqj on 15/7/9.
//  Copyright (c) 2015年 maqj. All rights reserved.
//

#import "CameraPhotoViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface CameraPhotoViewController ()<UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
UIActionSheetDelegate>

@end

@implementation CameraPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                              target:self
                                              action:@selector(takePicture:)];
    
    self.labels;
}

- (BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)cameraSupportMedia:(NSString*)mediaType
                sourceType:(UIImagePickerControllerSourceType)sourceType{
    __block BOOL result = NO;
    
    if ([mediaType length] == 0) {
        NSLog(@"Media type is empty.");
        return NO;
    }
    
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        NSString *thisMediaType = (NSString*)obj;
        if ([thisMediaType isEqualToString:mediaType]) {
            result = YES;
            *stop = YES;
        }
    }];
    
    return result;
}

- (BOOL)doesCameraSupportTakingPhotos{
    return [self cameraSupportMedia:(__bridge NSString*)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%s %ld", __FUNCTION__, (long)buttonIndex);
    
    switch (buttonIndex) {
        case 0:
            [self takePictureFromSource];
            break;
            
        case 1:
        {
            [self takePictureFromCamera];
            break;
        }
        default:
            break;
    }
}

- (BOOL)isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)canUserPickPhotosFromPhotoLibrary{
    return [self cameraSupportMedia:(__bridge NSString*)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)canUserPickVideoFromPhotoLibrary{
    return [self cameraSupportMedia:(__bridge NSString*)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)takePictureFromSource{
    
    if ([self isPhotoLibraryAvailable]) {
        
        NSMutableArray *mediaTypes = [NSMutableArray array];
        
        if ([self canUserPickPhotosFromPhotoLibrary]) {
            [mediaTypes addObject:(__bridge NSString*)kUTTypeImage];
        }
        
        if ([self canUserPickVideoFromPhotoLibrary]) {
            [mediaTypes addObject:(__bridge NSString*)kUTTypeMovie];
        }
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        controller.delegate = self;
        controller.mediaTypes = mediaTypes;
        
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)takePictureFromCamera{
    if ([self isCameraAvailable]&&
        [self doesCameraSupportTakingPhotos]) {
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        controller.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        NSString *requiredMediaTypeImage = (__bridge NSString*)kUTTypeImage;
        NSString *requiredMediTypeVideo = (__bridge NSString*)kUTTypeMovie;
        controller.mediaTypes = [NSArray arrayWithObjects:requiredMediaTypeImage, requiredMediTypeVideo, nil];
        controller.allowsEditing = YES;
        controller.delegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        NSLog(@"Camera is not available.");
    }

}

- (void)takePicture:(id)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Source"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:@"Choose"
                                                    otherButtonTitles:@"Taking Picture", nil];
    
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:YES];
}

- (void)imageWasSavedSuccessfully:(UIImage*)image
         didFinishSavingWithError:(NSError*)error
                      contextInfo:(void*)contextInfo{
    if (error == nil) {
        NSLog(@"Image saved successfully.");
    }else{
        NSLog(@"%@", error);
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%s Successfully.", __FUNCTION__);
    
    NSLog(@"%@", info);
    
    if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    NSString *mediType = info[UIImagePickerControllerMediaType];
    
    if ([mediType isEqualToString:(__bridge NSString*)kUTTypeImage]) {
        
        UIImage *theImage = nil;
        
        if ([picker isEditing]) {
            theImage = info[UIImagePickerControllerEditedImage];
        }else{
            theImage = info[UIImagePickerControllerOriginalImage];
        }
        
        // UISaveVideoAtPathToSavedPhotosAlbum(NSString *videoPath, id completionTarget, SEL completionSelector, void *contextInfo)
        UIImageWriteToSavedPhotosAlbum(theImage, self, @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:), NULL);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"%s canceled", __FUNCTION__);
    [self dismissViewControllerAnimated:YES completion:nil];
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
