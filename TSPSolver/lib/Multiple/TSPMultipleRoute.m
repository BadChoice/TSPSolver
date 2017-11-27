#import <Collection/NSArray+Collection.h>
#import "TSPMultipleRoute.h"

@implementation TSPMultipleRoute

+ (id)make:(NSArray <TSPRoute*> *)routes{
    TSPMultipleRoute *multipleRoute = [TSPMultipleRoute new];
    multipleRoute.routes = routes;
    return multipleRoute;
}

-(NSArray*)getAllPoints{
    return [self.routes flatten:@"locations"];
}

- (double)maxRoute {
    return [self.routes max:@"distance"].doubleValue;
}

@end