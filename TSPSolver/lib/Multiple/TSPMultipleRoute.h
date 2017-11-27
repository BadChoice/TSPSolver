#import <Foundation/Foundation.h>

#import "TSPRoute.h"

@interface TSPMultipleRoute : NSObject
@property(strong, nonatomic) NSMutableArray<TSPRoute*>*routes;

+ (id)make:(NSArray <TSPRoute*> *)routes;

- (NSArray *)getAllPoints;

- (void)optimize;

- (NSArray *)log;

- (double)maxRoute;
@end
