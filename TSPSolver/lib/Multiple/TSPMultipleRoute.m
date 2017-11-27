#import <Collection/NSArray+Collection.h>
#import "TSPMultipleRoute.h"
#import "TSPSolver.h"
#import "TSPNearestAlgorithm.h"
#import "TSPGeneticAlgorithm.h"

@implementation TSPMultipleRoute {
    double mMaxDistance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        mMaxDistance = -1;
    }

    return self;
}


+ (id)make:(NSArray <TSPRoute*> *)routes{
    TSPMultipleRoute *multipleRoute = [TSPMultipleRoute new];
    multipleRoute.routes = routes;
    return multipleRoute;
}

-(NSArray*)getAllPoints{
    return [self.routes flatten:@"locations"];
}

- (void)optimize{
    self.routes = [self.routes map:^id(TSPRoute* route, NSUInteger idx) {
        return [TSPSolver solve:route.locations startingAt:route.start with:[TSPNearestAlgorithm new]];
    }].mutableCopy;
}

-(NSArray*)log{
    return [self.routes map:^id(TSPRoute *route, NSUInteger idx) {
        if(route.locations.count == 0) return @" ";
        return [[route.locations pluck:@"name"] implode:@","];
    }];
}

- (double)maxRoute {
    if (mMaxDistance < 0) {
        mMaxDistance = [self.routes max:@"distance"].doubleValue;
    }
    return mMaxDistance;
}

-(void)dealloc{
    self.routes = nil;
}

@end