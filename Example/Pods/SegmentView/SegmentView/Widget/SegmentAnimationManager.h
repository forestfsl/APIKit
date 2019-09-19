

#import <UIKit/UIKit.h>

/** Animation object used by SegmentCheckBoxManager to generate animations.
 */
@interface SegmentAnimationManager : NSObject

/** The duration of the animation created by the SegmentAnimationManager object.
 */
@property (nonatomic) CGFloat animationDuration;

/** Designated initializer.
 * @param animationDuration The duration of the animations created with the SegmentAnimationManager object.
 * @return Returns the a fully initialized SegmentAnimationManager object.
 */
- (instancetype)initAnimationDuration:(CGFloat)animationDuration;

/** Returns a CABasicAnimation which the stroke.
 * @param reverse The direction of the animation. Set to YES if the animation should go from opacity 0 to 1, or NO for the opposite.
 * @return Returns the CABasicAnimation object.
 */
- (CABasicAnimation *)ForPlatformStrokeAnimationBoardReverse:(BOOL)reverse;

/** Returns a CABasicAnimation which animates the opacity.
 * @param reverse The direction of the animation. Set to YES if the animation should go from opacity 0 to 1, or NO for the opposite.
 * @return Returns the CABasicAnimation object.
 */
- (CABasicAnimation *)ForPlatformOpacityAnimationBoardReverse:(BOOL)reverse;

/** Returns a CABasicAnimation which animates between two paths.
 * @param fromPath The path to transform (morph) from.
 * @param toPath The path to transform (morph) to.
 * @return Returns the CABasicAnimation object.
 */
- (CABasicAnimation *)ForPlatformmorrphAnimationFromBoardPath:(UIBezierPath *)fromPath toPath:(UIBezierPath *)toPath ;

/** Animation engine to create a fill animation.
 * @param bounces The number of bounces for the animation.
 * @param amplitude How far does the animation bounce.
 * @param reverse Flag to track if the animation should fill or empty the layer.
 * @return Returns the CAKeyframeAnimation object.
 */
- (CAKeyframeAnimation *)ForPlatformFillAnimationBoardBounces:(NSUInteger)bounces amplitude:(CGFloat)amplitude reverse:(BOOL)reverse;

@end
