//
//  BCBalloonTextView.h
//  BalloonChat
//
//  Created by Jeong YunWon on 2016. 3. 13..
//  Copyright © 2016년 youknowone.org. All rights reserved.
//

#import <Cocoa/Cocoa.h>


NS_ASSUME_NONNULL_BEGIN

@interface BCNinePartImageView: NSView

@property(nonatomic,strong) NSImage *image;
@property(nonatomic,assign) NSEdgeInsets capInsets;

@end


@protocol BCBalloonTextViewDelegate;

@interface BCBalloonTextView : NSControl

@property(nonatomic,weak) NSObject<BCBalloonTextViewDelegate> *delegate;

@property(nonatomic,strong) NSTextView *textView;
@property(nonatomic,assign) NSTextAlignment alignment;
@property(nonatomic,assign) NSEdgeInsets contentInsets;
@property(nonatomic,assign) NSSize contentSize;
@property(nonatomic,readonly) NSFont *font;

@property(nonatomic,strong) NSImageView *backgroundImageView;
@property(nullable,nonatomic,strong) NSImage *backgroundImage;
@property(nonatomic,assign) NSEdgeInsets backgroundCapInsets;

- (void)setBalloonImage:(NSImage *)image capInsets:(NSEdgeInsets)capInsets;

@property(nonatomic,assign) BOOL autoresizeToFit;

@property(nonatomic,copy) NSString *string;

@end

typedef NSAttributedString *_NSAttributedStringRef;
typedef _Nullable _NSAttributedStringRef (^BCBalloonTextViewReplacingBlock)(NSString *string);

@protocol BCBalloonTextViewDelegate <NSObject>

@optional
- (NSAttributedString *)textView:(BCBalloonTextView *)balloonTextView attributedStringForString:(NSString *)string;
//! @brief The keys of dictionary are patterns of NSRegularExpression. The values of them are BCBalloonTextViewReplacingBlock.
- (NSDictionary<NSString *, BCBalloonTextViewReplacingBlock> *)regularExpressionPatternsAndBlocksForReplacingInTextView:(BCBalloonTextView *)balloonTextView;

@end

NS_ASSUME_NONNULL_END
