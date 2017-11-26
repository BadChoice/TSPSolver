#import "TSPExactAlgorithm.h"
#import "NSArray+Collection.h"

@implementation TSPExactAlgorithm

- (TSPRoute *)solve:(NSArray<TSPPointContract>*)locations startingAt:(NSObject<TSPPointContract> *)start {
    NSArray* permutations = locations.permutations;
    return [[permutations map:^id(NSArray<TSPPointContract> *locationsPermutation, NSUInteger idx) {
        return [TSPRoute make:start locations:locationsPermutation];
    }] minObject:@"distance"];
}

@end