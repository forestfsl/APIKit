

#import "SegmentCheckBoxGroup.h"
#import "SegmentCheckBoxManager.h"

@interface SegmentCheckBoxGroup ()

@property (nonatomic, strong, nonnull) NSHashTable *checkBoxes;

@end

/** Defines private methods that we can call on the check box.
 */
@interface SegmentCheckBoxManager ()

@property (strong, nonatomic, nullable) SegmentCheckBoxGroup *group;

- (void)_setOn:(BOOL)on animated:(BOOL)animated notifyGroup:(BOOL)notifyGroup;

@end

@implementation SegmentCheckBoxGroup

- (instancetype)init {
    self = [super init];
    if (self) {
        _mustHaveSelection = NO;
        _checkBoxes = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    }
    return self;
}

+ (nonnull instancetype)groupForPlatformCheckBoxesboard:(nullable NSArray<SegmentCheckBoxManager *> *)checkBoxes {
    SegmentCheckBoxGroup *group = [[SegmentCheckBoxGroup alloc] init];
    for (SegmentCheckBoxManager *checkbox in checkBoxes) {
        [group addForDeviceCheckBoxToBoardGroup:checkbox];
    }
    
    return group;
}

- (void)addForDeviceCheckBoxToBoardGroup:(nonnull SegmentCheckBoxManager *)checkBox {
    if (checkBox.group) {
        [checkBox.group removeForPlatformBoxFromBoardGroup:checkBox];
    }
    
    [checkBox _setOn:NO animated:NO notifyGroup:NO];
    checkBox.group = self;

    [self.checkBoxes addObject:checkBox];
}

- (void)removeForPlatformBoxFromBoardGroup:(nonnull SegmentCheckBoxManager *)checkBox {
    if (![self.checkBoxes containsObject:checkBox]) {
        // Not in this group
        return;
    }
    
    checkBox.group = nil;
    [self.checkBoxes removeObject:checkBox];
}

#pragma mark Getters

- (SegmentCheckBoxManager *)selectedCheckBox {
    SegmentCheckBoxManager *selected = nil;
    for (SegmentCheckBoxManager *checkBox in self.checkBoxes) {
        if(checkBox.on){
            selected = checkBox;
            break;
        }
    }
    
    return selected;
}

#pragma mark Setters

- (void)setSelectedCheckBox:(SegmentCheckBoxManager *)selectedCheckBox {
    if (selectedCheckBox) {
        for (SegmentCheckBoxManager *checkBox in self.checkBoxes) {
            BOOL shouldBeOn = (checkBox == selectedCheckBox);
            if(checkBox.on != shouldBeOn){
                [checkBox _setOn:shouldBeOn animated:YES notifyGroup:NO];
            }
        }
    } else {
        // Selection is nil
        if(self.mustHaveSelection && [self.checkBoxes count] > 0){
            // We must have a selected checkbox, so re-call this method with the first checkbox
            self.selectedCheckBox = [self.checkBoxes anyObject];
        } else {
            for (SegmentCheckBoxManager *checkBox in self.checkBoxes) {
                BOOL shouldBeOn = NO;
                if(checkBox.on != shouldBeOn){
                    [checkBox _setOn:shouldBeOn animated:YES notifyGroup:NO];
                }
            }
        }
    }
}

- (void)setMustHaveSelection:(BOOL)mustHaveSelection {
    _mustHaveSelection = mustHaveSelection;
    
    // If it must have a selection and we currently don't, select the first box
    if (mustHaveSelection && !self.selectedCheckBox) {
        self.selectedCheckBox = [self.checkBoxes anyObject];
    }
}

#pragma mark Private methods called by SegmentCheckBoxManager

- (void)_checkBoxSelectionChanged:(SegmentCheckBoxManager *)checkBox {
    if ([checkBox on]) {
        // Change selected checkbox to this one
        self.selectedCheckBox = checkBox;
    } else if(checkBox == self.selectedCheckBox) {
        // Selected checkbox was this one, clear it
        self.selectedCheckBox = nil;
    }
}

@end
