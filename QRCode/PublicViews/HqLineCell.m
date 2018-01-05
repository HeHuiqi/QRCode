//
//  HqLineCell.m
//  iRAIDLoop
//
//  Created by macpro on 16/8/11.
//  Copyright © 2016年 macpro. All rights reserved.
//

#import "HqLineCell.h"

@implementation HqLineCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (_isShowLine) {
        
        CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
        CGContextFillRect(context, rect);
    
        UIColor *lineClor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1];
        NSLog(@"llll == %d",_lineRightSpace);
        //下分割线
        CGContextSetStrokeColorWithColor(context, lineClor.CGColor);
        CGContextStrokeRect(context, CGRectMake(15, rect.size.height, rect.size.width-15-_lineRightSpace, LineHeight));
    }
    else{
        CGContextClearRect(context,  CGRectMake(15, rect.size.height, rect.size.width-15-_lineRightSpace, 1));
    }
}
- (void)setIsShowLine:(BOOL)isShowLine{
    _isShowLine = isShowLine;
    [self setNeedsDisplay];
}
- (void)setLineRightSpace:(BOOL)lineRightSpace{
    
    _lineRightSpace = lineRightSpace;
    
    [self setNeedsDisplay];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
