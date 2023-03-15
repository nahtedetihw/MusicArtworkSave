#import <AudioToolbox/AudioServices.h>
#import <UIKit/UIKit.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

UIImage *artworkImage;

@interface _TtC16MusicApplication25ArtworkComponentImageView : UIImageView
@end

@interface MusicArtworkComponentImageView : UIImageView
@end

@interface _TtC16MusicApplication21NowPlayingContentView : UIView
@end

@interface MusicNowPlayingControlsViewController : UIViewController
- (void)saveImage:(UIButton *)sender;
@end

%group iOS16
%hook MusicArtworkComponentImageView
- (void)setImage:(UIImage *)image {
    %orig;
    if ([NSStringFromClass([self.superview class]) isEqualToString:@"MusicApplication.NowPlayingContentView"]) {
        self.userInteractionEnabled = YES;
        self.superview.userInteractionEnabled = YES;
        artworkImage = image;
    }
}
%end

%hook MusicNowPlayingControlsViewController
- (void)viewDidLoad {
    %orig;
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton addTarget:self action:@selector(saveImage:)
              forControlEvents:UIControlEventTouchUpInside];
    saveButton.frame = CGRectMake(0, 0, 30, 30);
    saveButton.tintColor = [UIColor whiteColor];
    saveButton.layer.masksToBounds = YES;
    saveButton.layer.cornerRadius = saveButton.frame.size.width/2;
    saveButton.userInteractionEnabled = YES;
    saveButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    UIImage *oldImage = [UIImage systemImageNamed:@"photo.circle"];
    UIImage *newImage = [UIImage systemImageNamed:@"checkmark.circle"];
    [saveButton setImage:oldImage forState:UIControlStateNormal];
    [saveButton setImage:newImage forState:UIControlStateHighlighted];
    [saveButton setImage:newImage forState:UIControlStateSelected];
    [self.view addSubview:saveButton];
    saveButton.translatesAutoresizingMaskIntoConstraints = false;
    [saveButton.widthAnchor constraintEqualToConstant:30].active = true;
    [saveButton.heightAnchor constraintEqualToConstant:30].active = true;
    [saveButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-25].active = true;
    [saveButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:40].active = true;
}

%new
- (void)saveImage:(UIButton *)sender {
    AudioServicesPlaySystemSound(1519);
    sender.selected = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.selected = NO;
    });
    if (artworkImage != nil) UIImageWriteToSavedPhotosAlbum(artworkImage, nil, nil, nil);
}
%end
%end

%group iOS13to15
%hook _TtC16MusicApplication25ArtworkComponentImageView
- (void)setImage:(UIImage *)image {
    %orig;
    if ([NSStringFromClass([self.superview class]) isEqualToString:@"MusicApplication.NowPlayingContentView"]) {
        self.userInteractionEnabled = YES;
        self.superview.userInteractionEnabled = YES;
        artworkImage = image;
    }
}
%end

%hook MusicNowPlayingControlsViewController
- (void)viewDidLoad {
    %orig;
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton addTarget:self action:@selector(saveImage:)
              forControlEvents:UIControlEventTouchUpInside];
    saveButton.frame = CGRectMake(0, 0, 30, 30);
    saveButton.tintColor = [UIColor whiteColor];
    saveButton.layer.masksToBounds = YES;
    saveButton.layer.cornerRadius = saveButton.frame.size.width/2;
    saveButton.userInteractionEnabled = YES;
    saveButton.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.1];
    UIImage *oldImage = [UIImage systemImageNamed:@"photo.circle"];
    UIImage *newImage = [UIImage systemImageNamed:@"checkmark.circle"];
    [saveButton setImage:oldImage forState:UIControlStateNormal];
    [saveButton setImage:newImage forState:UIControlStateHighlighted];
    [saveButton setImage:newImage forState:UIControlStateSelected];
    [self.view addSubview:saveButton];
    saveButton.translatesAutoresizingMaskIntoConstraints = false;
    [saveButton.widthAnchor constraintEqualToConstant:30].active = true;
    [saveButton.heightAnchor constraintEqualToConstant:30].active = true;
    [saveButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-25].active = true;
    [saveButton.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:40].active = true;
}

%new
- (void)saveImage:(UIButton *)sender {
    AudioServicesPlaySystemSound(1519);
    sender.selected = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.selected = NO;
    });
    if (artworkImage != nil) UIImageWriteToSavedPhotosAlbum(artworkImage, nil, nil, nil);
}
%end
%end

%ctor {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"13.0") && SYSTEM_VERSION_LESS_THAN(@"16.0")) {
        %init(iOS13to15);
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"16.0")) {
        %init(iOS16);
    }
}
