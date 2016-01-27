//
//  UIImageViewEdit.m
//  TheBackgrounder
//
//  Created by maqinjun on 15/10/21.
//  Copyright © 2015年 Gustavo Ambrozio. All rights reserved.
//

#import "UIImageViewEdit.h"
//#import "UIImageView+WebCache.h"

@interface UIImageViewEdit ()
@property (nonatomic, strong) UITextField *textfield;
@property (nonatomic, strong) UIButton *deleteButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

static const CGFloat textfieldH = 50.f;
static const CGFloat textfieldToImageInterver = 5.f;

@implementation UIImageViewEdit{
    UIImage *imagePlaceholder;
}

@synthesize image,
imageDesc,
editable,
maxWords,
placeholder,
imageUrl;

- (void)setEditable:(BOOL)edit{
    _textfield.enabled = edit;
    _deleteButton.hidden = edit;
}

//- (void)setImagePlaceholder:(UIImage *)imgPlaceholder{
//    imagePlaceholder = imgPlaceholder;
//    if (!_imageView.image) {
//        _imageView.image = imgPlaceholder;
//    }
//}

- (void)setImageUrl:(NSString *)imgUrl{
    imageUrl = imgUrl;
    //加载图片
    __weak typeof (self) weakSelf = self;
    
//    [_imageView sd_setImageWithURL:[NSURL URLWithString:imgUrl]
//                  placeholderImage:[UIImage imageNamed:@"placeholder_imageBroswer_small"]
//                           options:SDWebImageRetryFailed
//                         completed:^(UIImage *img, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                             if (img) {
//                                 weakSelf.imageView.image = img;
//                             }
//                         }];
}

- (void)setPlaceholder:(NSString *)holder{
    placeholder = holder;
    _textfield.placeholder = holder;
}

- (void)setImageDesc:(NSString *)desc{
    imageDesc = desc;
    _textfield.text = desc;
}

- (void)setImage:(UIImage *)img{
    image = img;
    
    _imageView.image = img;
    //显示图片
//    CGSize imageSize = img.size;
    
//    [self mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(CGSizeMake(self.frame.size.width, imageSize.height + textfieldH + textfieldToImageInterver));
//    }];
    
    [self setNeedsDisplay];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self sizeToFit];
        
        maxWords = 20;
        placeholder = @"请描述图片";
        imagePlaceholder = [UIImage imageNamed:@"placeholder_big.png"];
        
        _imageView = [[UIImageView alloc] initWithImage:imagePlaceholder];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 5.f;
        
        _textfield = [[UITextField alloc] init];
        _textfield.placeholder = placeholder;
        _textfield.delegate = self;
        
        UIImage *deleteImage = [UIImage imageNamed:@"delete_icon"];
        _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_deleteButton setImage:deleteImage forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(handleDelete:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_imageView];
        [self addSubview:_textfield];
        [self addSubview:_deleteButton];
        
//        __weak typeof (self) weakSelf = self;
//        
//        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(weakSelf.mas_top);
//            make.left.equalTo(weakSelf.mas_left);
//            make.right.equalTo(weakSelf.mas_right);
//            make.bottom.equalTo(_textfield.mas_top);
//        }];
//        
//        [_textfield mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_imageView.mas_bottom).offset(@(textfieldToImageInterver));
//            make.bottom.equalTo(weakSelf.mas_bottom);
//            make.left.equalTo(weakSelf.mas_left);
//            make.right.equalTo(weakSelf.mas_right);
//            make.height.equalTo(@(textfieldH));
//        }];
//        
//        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(weakSelf.mas_top);
//            make.right.equalTo(weakSelf.mas_right);
//            make.size.equalTo(deleteImage.size);
//        }];
    }
    return self;
}


//
//- (void)layoutSubviews{
//    
//}
//
//
//// Only override drawRect: if you perform custom drawing.
//// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    
//}


@end
