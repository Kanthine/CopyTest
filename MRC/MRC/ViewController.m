//
//  ViewController.m
//  MRC
//
//  Created by 苏沫离 on 2020/4/24.
//  Copyright © 2020 苏沫离. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>

NSString *logString(NSString *object){
    return [NSString stringWithFormat:@"%@  %p |  rCount :%ld | %@",object,object,object.retainCount,object_getClass(object)];
}

NSString *logArray(NSArray *array){
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendString:@"\n"];
    [array enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendString:[NSString stringWithFormat:@"      %@ ：%p ",obj,obj]];
        [string appendString:@"\n"];
    }];
    [string appendString:[NSString stringWithFormat:@"  %p | rCount :%ld | %@ \n",array,array.retainCount,object_getClass(array)]];
    return string;
}

NSString *logDictionary(NSDictionary *dict){
    NSMutableString *string = [[NSMutableString alloc] init];
    [string appendString:@"\n"];
    [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendString:[NSString stringWithFormat:@"%@ %@ ：%p ",key,obj,obj]];
        [string appendString:@"\n"];
    }];
    [string appendString:[NSString stringWithFormat:@"  %p | rCount :%ld | %@ \n",dict,dict.retainCount,object_getClass(dict)]];
    return string;
}


@interface ViewController ()
@property (nonatomic ,strong) NSString *sString;
@property (nonatomic ,copy) NSString *cString;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    [self copyTest];
}

/** 系统容器类 NSArray、NSMutableArray
 * NSArray
 *  指针赋值 -> 浅拷贝
 *  copy 操作 -> 浅拷贝
 *  mutableCopy 操作 -> 深拷贝
 *
 * NSMutableArray
 *  指针赋值 -> 浅拷贝
 *  copy 操作 -> 深拷贝
 *  mutableCopy 操作 -> 深拷贝
 */
- (void)copyArrayTest{
    NSString *string = @"String";
    NSMutableString *mString = [[NSMutableString alloc] initWithString:@"Mutable String"];
    NSLog(@"string  :  %@",logString(string));
    NSLog(@"mString :  %@",logString(mString));
    
    NSArray *array = [[NSArray alloc] initWithObjects:string,mString, nil];
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithObjects:string,mString, nil];
    
    mString.string = @"Mutable String_2";
    NSLog(@"mString :  %@",logString(mString));
    
    NSArray *array_1 = array;
    NSArray *array_2 = [array copy];
    NSArray *array_3 = [array mutableCopy];
    NSLog(@"array     : %@",logArray(array));
    NSLog(@"array_1   : %@",logArray(array_1));
    NSLog(@"array_2   : %@",logArray(array_2));
    NSLog(@"array_3   : %@",logArray(array_3));
    
    printf("\n  \n");
    NSMutableArray *mArray_1 = mArray;
    NSMutableArray *mArray_2 = [mArray copy];
    NSMutableArray *mArray_3 = [mArray mutableCopy];
    NSLog(@"mArray     : %@",logArray(mArray));
    NSLog(@"mArray_1   : %@",logArray(mArray_1));
    NSLog(@"mArray_2   : %@",logArray(mArray_2));
    NSLog(@"mArray_3   : %@",logArray(mArray_3));
}

- (void)copyDictionaryTest{
    NSString *string = @"String";
    NSMutableString *mString = [[NSMutableString alloc] initWithString:@"Mutable String"];
    NSLog(@"string  :  %@",logString(string));
    NSLog(@"mString :  %@",logString(mString));
    
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:string,@"NSString",mString,@"NSMutableString", nil];
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:string,@"NSString",mString,@"NSMutableString", nil];
    
    NSDictionary *dict_1 = dict;
    NSDictionary *dict_2 = [dict copy];
    NSDictionary *dict_3 = [dict mutableCopy];
    NSLog(@"dict    : %@",logDictionary(dict));
    NSLog(@"dict_1  : %@",logDictionary(dict_1));
    NSLog(@"dict_2  : %@",logDictionary(dict_2));
    NSLog(@"dict_3  : %@",logDictionary(dict_3));
    
    printf("\n  \n");
    NSMutableDictionary *mDict_1 = mDict;
    NSMutableDictionary *mDict_2 = [mDict copy];
    NSMutableDictionary *mDict_3 = [mDict mutableCopy];
    NSLog(@"mDict    : %@",logDictionary(mDict));
    NSLog(@"mDict_1  : %@",logDictionary(mDict_1));
    NSLog(@"mDict_2  : %@",logDictionary(mDict_2));
    NSLog(@"mDict_3  : %@",logDictionary(mDict_3));
}



/** 系统非容器类 NSString、NSMutableString
 * NSString
 *  指针赋值 -> 浅拷贝
 *  copy 操作 -> 浅拷贝
 *  mutableCopy 操作 -> 深拷贝
 *
 * NSMutableString
 *  指针赋值 -> 浅拷贝
 *  copy 操作 -> 深拷贝
 *  mutableCopy 操作 -> 深拷贝
 *
 * 不管容器类是深拷贝还是浅拷贝，容器中的元素都是浅拷贝
 */
- (void)copyStringTest{
    
    NSString *string = [[NSString alloc] initWithString:@"String"];
    NSString *string_1 = string;
    NSString *string_2 = [string copy];
    NSString *string_3 = [string mutableCopy];
    NSLog(@"string     : %@",logString(string));
    NSLog(@"string_1   : %@",logString(string_1));
    NSLog(@"string_2   : %@",logString(string_2));
    NSLog(@"string_3   : %@",logString(string_3));
    
    printf("\n  \n");
    NSMutableString *mString = [[NSMutableString alloc] initWithString:@"Mutable String"];
    NSString *mString_1 = mString;
    NSString *mString_2 = [mString copy];
    NSString *mString_3 = [mString mutableCopy];
    NSLog(@"mString     : %@",logString(mString));
    NSLog(@"mString_1   : %@",logString(mString_1));
    NSLog(@"mString_2   : %@",logString(mString_2));
    NSLog(@"mString_3   : %@",logString(mString_3));
}


- (void)copyTest{
    
    NSMutableString *mString = [[NSMutableString alloc] initWithString:@"Mutable String"];
    self.sString = mString;
    self.cString = mString;
    NSLog(@"mString   : %@ : %p : %p : %ld",mString,mString,&mString,mString.retainCount);
    NSLog(@"sString   : %@ : %p : %p : %ld",self.sString,self.sString,&_sString,_sString.retainCount);
    NSLog(@"cString   : %@ : %p : %p : %ld",self.cString,self.cString,&_cString,_cString.retainCount);
    
    mString.string = @"Mutable String_1";
    NSLog(@"mString   : %@ : %p : %p : %ld",mString,mString,&mString,mString.retainCount);
    NSLog(@"sString   : %@ : %p : %p : %ld",self.sString,self.sString,&_sString,_sString.retainCount);
    NSLog(@"cString   : %@ : %p : %p : %ld",self.cString,self.cString,&_cString,_cString.retainCount);
    
    mString = [[NSMutableString alloc] initWithString:@"Mutable String_2"];
    NSLog(@"mString   : %@ : %p : %p : %ld",mString,mString,&mString,mString.retainCount);
    NSLog(@"sString   : %@ : %p : %p : %ld",self.sString,self.sString,&_sString,_sString.retainCount);
    NSLog(@"cString   : %@ : %p : %p : %ld",self.cString,self.cString,&_cString,_cString.retainCount);
        
    NSString *string = @"Hello Word!";
    self.sString = string;
    self.cString = string;
    NSLog(@"string   : %@ : %p : %p : %ld",string,string,&string,string.retainCount);
    NSLog(@"sString   : %@ : %p : %p : %ld",self.sString,self.sString,&_sString,_sString.retainCount);
    NSLog(@"cString   : %@ : %p : %p : %ld",self.cString,self.cString,&_cString,_cString.retainCount);
        
    string = @"hehe";
    NSLog(@"string   : %@ : %p : %p : %ld",string,string,&string,string.retainCount);
    NSLog(@"sString   : %@ : %p : %p : %ld",self.sString,self.sString,&_sString,_sString.retainCount);
    NSLog(@"cString   : %@ : %p : %p : %ld",self.cString,self.cString,&_cString,_cString.retainCount);
}

@end
