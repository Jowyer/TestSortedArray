//
//  ViewController.m
//  TestSortedArray
//
//  Created by Jun Wang on 13-8-23.
//  Copyright (c) 2013年 jo2studio. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSMutableArray *array = [[[NSMutableArray alloc] initWithObjects:@"8655", @"1347",@"257",@"2557",@"8967",@"757",@"97",@"712", @"7",nil] autorelease];
    NSMutableArray *array = [[[NSMutableArray alloc] initWithObjects:@"7", @"1347",@"257",@"2557",@"8967",@"757",@"97",@"712",@"715954",@"7626",@"173",@"557",@"797",@"715",@"17",@"7087655",@"7087",@"1372",@"719867",@"70",@"1557",@"78685",@"7655",@"15677",@"287",@"70776",@"7765",@"70784",@"7844",@"7036",@"798",@"170762",@"7283955",@"9759457",@"15667",@"56267",@"6627",@"477",@"72",nil] autorelease];
    
    /*
     个数少用冒泡更快
     个数多用快排更快
     */
    
    
    [self bubbleSortWith:array];
    
    //time start
    NSDate* tmpStartData = [[NSDate date] retain];
    
    NSArray *sortedArray = [self quickSort:array];
    
    //time end
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@">>>>>>>>>> QuickSort cost time = %f ms", deltaTime*1000);
    [tmpStartData release];
    
    NSLog(@"QuickSort sorted array is %@", sortedArray);

}

-(void)bubbleSortWith:(NSMutableArray *)array
{
    //time start
    NSDate* tmpStartData = [[NSDate date] retain];
    
    int i, j, min;
    NSString *temp;
    for (i = 0; i < [array count]; i++)
    {
        min = i;
        
        for (j = [array count] - 1; j > i; j--)
        {
            if ([[array objectAtIndex:j] integerValue] < [[array objectAtIndex:min] integerValue])
            {
                min = j;
            }
        }
        
        if (i != min)
        {
            temp = [array objectAtIndex:i];
            [array replaceObjectAtIndex:i withObject:[array objectAtIndex:min]];
            [array replaceObjectAtIndex:min withObject:temp];
        }
    }
    //time end
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@">>>>>>>>>> bubbleSort cost time = %f ms", deltaTime*1000);
    [tmpStartData release];
    
    NSLog(@"BubbleSort sorted array is %@", array);
}

-(NSArray*)quickSort:(NSArray*)unsortedArray
{
    NSInteger numberOfElements = [unsortedArray count];
    if(numberOfElements <= 1)
    {
        return unsortedArray;
    }
    
    NSNumber* pivotValue = [unsortedArray objectAtIndex: numberOfElements/2];
    
    NSMutableArray* lessArray = [[[NSMutableArray alloc] initWithCapacity:numberOfElements] autorelease];
    NSMutableArray* moreArray = [[[NSMutableArray alloc] initWithCapacity:numberOfElements] autorelease];
    
    for (NSNumber* value in unsortedArray)
    {
        if([value floatValue] < [pivotValue floatValue])
        {
            [lessArray addObject:value];
        }
        else if([value floatValue] > [pivotValue floatValue])
        {
            [moreArray addObject:value];
        }
    }
    
    NSMutableArray* sortedArray = [[[NSMutableArray alloc] initWithCapacity:numberOfElements] autorelease];
    [sortedArray addObjectsFromArray:[self quickSort:lessArray]];
    [sortedArray addObject:pivotValue];
    [sortedArray addObjectsFromArray:[self quickSort:moreArray]];
    
    return sortedArray;
}

@end
