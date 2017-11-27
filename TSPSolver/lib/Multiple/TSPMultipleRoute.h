#import <Foundation/Foundation.h>

#import "TSPRoute.h"

@protocol TSPSolverContract;

@interface TSPMultipleRoute : NSObject
@property(strong, nonatomic) NSMutableArray<TSPRoute*>*routes;

+ (id)make:(NSArray <TSPRoute*> *)routes;

- (NSArray *)getAllPoints;

- (instancetype)optimize;
- (instancetype)optimize:(id<TSPSolverContract>)algorithm;

- (NSArray *)log;
- (void) validate;
- (double)maxRoute;
@end
