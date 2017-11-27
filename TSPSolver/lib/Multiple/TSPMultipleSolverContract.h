#import <Foundation/Foundation.h>

#import "TSPMultipleRoute.h";
#import "TSPPointContract.h";

@protocol TSPMultipleSolverContract <NSObject>
- (TSPMultipleRoute*)solve:(int)drivers locations:(NSArray<TSPPointContract> *)locations startingAt:(NSObject <TSPPointContract> *)start;
@end