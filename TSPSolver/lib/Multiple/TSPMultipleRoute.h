#import <Foundation/Foundation.h>

#import "TSPRoute.h"

@interface TSPMultipleRoute : NSObject
@property(strong, nonatomic) NSArray<TSPRoute*>*routes;

+ (id)make:(NSArray <TSPRoute*> *)routes;

- (NSArray *)getAllPoints;
- (double)maxRoute;
@end
