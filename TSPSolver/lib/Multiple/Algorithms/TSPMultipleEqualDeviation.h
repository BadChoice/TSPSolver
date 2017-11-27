#import <Foundation/Foundation.h>

@protocol TSPPointContract;
@class TSPMultipleRoute;

@interface TSPMultipleEqualDeviation : NSObject
+ (TSPMultipleRoute*)solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start;
@end