#import <Foundation/Foundation.h>

@protocol TSPPointContract;
@class TSPMultipleRoute;


@interface TSPMultipleEqualAlgorithm : NSObject

+ (TSPMultipleRoute*)solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start;
@end