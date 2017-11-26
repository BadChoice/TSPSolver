
#import <Foundation/Foundation.h>
#import "TSPPointContract.h"
#import "TSPRoute.h"

@interface GAPopulation : NSObject
@property (strong, nonatomic) NSMutableArray * tours;

+ (GAPopulation *)make:(int)count;
+ (GAPopulation *)make:(int)count locations:(NSArray<TSPPointContract>*)locations start:(NSObject<TSPPointContract>*)start;

- (TSPRoute *)best;

@end