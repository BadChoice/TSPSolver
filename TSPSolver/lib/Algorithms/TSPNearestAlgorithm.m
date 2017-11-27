#import "TSPNearestAlgorithm.h"
#import "NSArray+Collection.h"

@implementation TSPNearestAlgorithm

- (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start {
    TSPRoute *route = [TSPRoute new];
    route.start = start;
    route.locations = @[start].mutableCopy;
    NSMutableArray *leftLocations = locations.mutableCopy;
    while(leftLocations.count > 0 ) {
        NSObject<TSPPointContract>* nearest = [self findNearest:route.locations.lastObject locations:leftLocations];
        [route.locations addObject:nearest];
        [leftLocations removeObject:nearest];
    }
    route.locations = [route.locations slice:1].mutableCopy;
    return route;
}

-(NSObject<TSPPointContract> *)findNearest:(NSObject<TSPPointContract> *)current locations:(NSArray*)locations{
    return [locations minObjectFor:^double(NSObject<TSPPointContract> *point) {
        return [point.location distanceFromLocation:current.location];
    }];
}
@end