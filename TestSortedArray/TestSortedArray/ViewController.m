//
//  ViewController.m
//  TestSortedArray
//
//  Created by Jun Wang on 13-8-23.
//  Copyright (c) 2013年 jo2studio. All rights reserved.
//

#import "ViewController.h"
#import "TestObject.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //个数少用冒泡更快。可以解决相等对象的问题。
    //个数多用快排更快。有多个相等对象的时候，只会保留一个，bug...
    
    int totalNum = 9;
    TestObject *obj[totalNum];
    NSMutableArray *mutableArray = [NSMutableArray array];
    
    for (int i = 0; i < totalNum; i++)
    {
        obj[i] = [[[TestObject alloc] init] autorelease];
        [mutableArray addObject:obj[i]];
    }
    
    obj[0].value = 1136;
    obj[1].value = 1021;
    obj[2].value = 10;
    obj[3].value = 791;
    obj[4].value = 7;
    
    // QUICK SORT
    for (int i = 0; i < [mutableArray count]; i++)
    {
        TestObject *object = [mutableArray objectAtIndex:i];
        NSLog(@"quickUnsortArray%d: %d", i, object.value);
    }
    
    //time start
    NSDate* tmpStartData = [[NSDate date] retain];
    
    NSArray *quickSortedArray = [self quickSortObjectArray:mutableArray];
    
    double deltaTime = [[NSDate date] timeIntervalSinceDate:tmpStartData];
    NSLog(@">>>>>>>>>> QuickSort cost time = %f ms", deltaTime*1000);
    [tmpStartData release];
    //time end
    
    for (int i = 0; i < [quickSortedArray count]; i++)
    {
        TestObject *object = [quickSortedArray objectAtIndex:i];
        NSLog(@"quickSortedArray%d: %d", i, object.value);
    }
    
    NSLog(@"======================");
    
    // BUBBLE SORT 
    for (int i = 0; i < [mutableArray count]; i++)
    {
        TestObject *object = [mutableArray objectAtIndex:i];
        NSLog(@"bubbleUnsortArray%d: %d", i, object.value);
    }
    
    //time start
    NSDate* tmpStartData2 = [[NSDate date] retain];
    
    NSMutableArray *bubbleSortedArray = [self bubbleSortObjectArray:mutableArray];
    
    double deltaTime2 = [[NSDate date] timeIntervalSinceDate:tmpStartData2];
    NSLog(@">>>>>>>>>> BubbleSort cost time = %f ms", deltaTime2*1000);
    [tmpStartData2 release];
    //time end
    
    for (int i = 0; i < [bubbleSortedArray count]; i++)
    {
        TestObject *object = [bubbleSortedArray objectAtIndex:i];
        NSLog(@"bubbleSortedArray%d: %d", i, object.value);
    }
}

-(NSMutableArray*)bubbleSortObjectArray:(NSMutableArray*)unsortedArray
{
    int i, j, min;
    TestObject *tempObject;
    for (i = 0; i < [unsortedArray count]; i++)
    {
        min = i;
        
        for (j = [unsortedArray count] - 1; j > i; j--)
        {
            TestObject *testObj = [unsortedArray objectAtIndex:j];
            TestObject *minObj = [unsortedArray objectAtIndex:min];
            if (testObj.value < minObj.value)
            {
                min = j;
            }
        }
        
        if (i != min)
        {
            tempObject = [unsortedArray objectAtIndex:i];
            [unsortedArray replaceObjectAtIndex:i withObject:[unsortedArray objectAtIndex:min]];
            [unsortedArray replaceObjectAtIndex:min withObject:tempObject];
        }
    }
    return unsortedArray;
}

-(NSArray*)quickSortObjectArray:(NSArray*)unsortedArray
{
    NSInteger numberOfElements = [unsortedArray count];
    if(numberOfElements <= 1)
    {
        return unsortedArray;
    }
    
    TestObject* pivotObject = [unsortedArray objectAtIndex:numberOfElements / 2];
    
    NSMutableArray* lessArray = [[[NSMutableArray alloc] initWithCapacity:numberOfElements] autorelease];
    NSMutableArray* moreArray = [[[NSMutableArray alloc] initWithCapacity:numberOfElements] autorelease];
    
    for (TestObject* obj in unsortedArray)
    {
        if(obj.value < pivotObject.value)
        {
            [lessArray addObject:obj];
        }
        else if(obj.value > pivotObject.value)
        {
            [moreArray addObject:obj];
        }
    }
    
    NSMutableArray* sortedArray = [[[NSMutableArray alloc] initWithCapacity:numberOfElements] autorelease];
    [sortedArray addObjectsFromArray:[self quickSortObjectArray:lessArray]];
    [sortedArray addObject:pivotObject];
    [sortedArray addObjectsFromArray:[self quickSortObjectArray:moreArray]];
    
    return sortedArray;
}

@end
