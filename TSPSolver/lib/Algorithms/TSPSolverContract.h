
#import <Foundation/Foundation.h>
#import "TSPRoute.h"

@protocol TSPSolverContract <NSObject>
- (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject <TSPPointContract> *)start;
@end