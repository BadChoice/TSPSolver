#import <Foundation/Foundation.h>
#import "TSPPointContract.h"
#import "TSPMultipleRoute.h"

@interface GAMultiplePopulation : NSObject

@property (strong, nonatomic) NSMutableArray * individuals;
+ (GAMultiplePopulation *)make:(int)size drivers:(int)drivers locations:(NSArray <TSPPointContract> *)locations start:(NSObject <TSPPointContract> *)start;

+ (TSPMultipleRoute *)generateRandomIndividual:(int)drivers start:(NSObject <TSPPointContract> *)start locations:(NSArray <TSPPointContract> *)locations;

+ (GAMultiplePopulation *)make:(int)size;

- (TSPMultipleRoute *)best;
@end