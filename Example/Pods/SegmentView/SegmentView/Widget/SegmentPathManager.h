

#import <UIKit/UIKit.h>
#import "SegmentCheckBoxManager.h"



@interface SegmentPathManager : NSObject


@property (nonatomic) CGFloat size;

@property (nonatomic) CGFloat lineWidth;


@property (nonatomic) CGFloat cornerRadius;


@property (nonatomic)STORYBOARDBoxType boxType;


- (UIBezierPath *)pathForBoxForDevice;


- (UIBezierPath *)pathForCheckMarkForDevice;


- (UIBezierPath *)pathForLongCheckMarkForDevice;


- (UIBezierPath *)pathForFlatCheckMarkForDevice;


@end
