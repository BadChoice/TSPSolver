#import "TSPRoute.h"
#import "RVCollection.h"

@implementation TSPRoute{
    double mDistance;
}

+ (id)make:(NSObject<TSPPointContract>*)location locations:(NSArray <TSPPointContract> *)locations{
    TSPRoute *route     = [TSPRoute new];
    route.locations     = locations.mutableCopy;
    route.start         = location;
    return route;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        mDistance = -1;
    }
    return self;
}

-(double)distance{
    if ( mDistance < 0 ) {
        id <TSPPointContract> firstLocation = self.locations.firstObject;
        id <TSPPointContract> lastLocation = self.locations.lastObject;

        double distance = [self.start.location distanceFromLocation:firstLocation.location];
        distance += [lastLocation.location distanceFromLocation:self.start.location];

        for (int i = 1; i < self.locations.count; i++) {
            id <TSPPointContract> location1 = self.locations[i - 1];
            id <TSPPointContract> location2 = self.locations[i];
            distance += [location1.location distanceFromLocation:location2.location];
        }
        mDistance = distance;
    }
    return mDistance;
}

-(void)dealloc{
    self.locations = nil;
    self.start = nil;
}
@end