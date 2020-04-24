//
//  ViewController.m
//  ARC
//
//  Created by 苏沫离 on 2020/4/24.
//  Copyright © 2020 苏沫离. All rights reserved.
//

#import "ViewController.h"

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


/** 浅拷贝与指针赋值
 *
 *
 */

/** copy 修饰的变量 cString 与 strong 修饰的变量 sString ：
 *
 * 将 NSString *string 赋值给上述变量：copy 与 strong 修饰的变量，都是浅拷贝，类似于 retain 操作，引用计数 +1；
 *  改变变量 string 的值，即将指针 string 指向别的内存地址；此时copy 与 strong 修饰的变量仍指向原有内存，值不改变；
 *
 * 将 NSMutableString *mString 赋值给上述变量：
 *  copy   修饰的变量属于深拷贝，使用新的指针指向新的内存地址，新的内存地址存储的数据与被赋值的数据相同
 *  strong 修饰的变量属于浅拷贝，使用新的指针指向被赋值变量的内存地址，类似于 retain 操作，引用计数 +1；
 * 改变 mString.string 的值：
 *  由于 copy 修饰的变量是深拷贝，不被 mString 的操作影响
 *  strong 修饰的变量仍然指向 mString 的内存，因此该变量的字符串也被改变
 * 将 mString 指向别处：
 *  由于 copy 修饰的变量是深拷贝，不被 mString 的操作影响
 *  strong 修饰的变量仍然指向原有内存，值不改变
 *
 * 结论：
 * 如果不希望属性变量 String 的值随着 NSMutableString 变化，就用copy来修饰string的属性。
 * 如果需要属性变量 String 的值随着 NSMutableString 变化而改变，就用strong来修饰string。
 */

- (void)copyTest{
    
    NSMutableString *mString = [[NSMutableString alloc] initWithString:@"Mutable String"];
    self.sString = mString;
    self.cString = mString;
    NSLog(@"mString   : %@ : %p : %p",mString,mString,&mString);
    NSLog(@"sString   : %@ : %p : %p",self.sString,self.sString,&_sString);
    NSLog(@"cString   : %@ : %p : %p",self.cString,self.cString,&_cString);
    
    printf("\n  \n");

    mString.string = @"Mutable String_1";
    NSLog(@"mString   : %@ : %p : %p",mString,mString,&mString);
    NSLog(@"sString   : %@ : %p : %p",self.sString,self.sString,&_sString);
    NSLog(@"cString   : %@ : %p : %p",self.cString,self.cString,&_cString);
    
    printf("\n  \n");

    mString = [[NSMutableString alloc] initWithString:@"Mutable String_2"];
    NSLog(@"mString   : %@ : %p : %p",mString,mString,&mString);
    NSLog(@"sString   : %@ : %p : %p",self.sString,self.sString,&_sString);
    NSLog(@"cString   : %@ : %p : %p",self.cString,self.cString,&_cString);
    
    printf(" -------------------------------------------------- \n");
    
    NSString *string = @"Hello Word!";
    self.sString = string;
    self.cString = string;
     NSLog(@"string   : %@ : %p : %p",string,string,&string);
    NSLog(@"sString   : %@ : %p : %p",self.sString,self.sString,&_sString);
    NSLog(@"cString   : %@ : %p : %p",self.cString,self.cString,&_cString);
    
    printf("\n  \n");
    
    string = @"hehe";
    NSLog(@"string   : %@ : %p : %p",string,string,&string);
    NSLog(@"sString   : %@ : %p : %p",self.sString,self.sString,&_sString);
    NSLog(@"cString   : %@ : %p : %p",self.cString,self.cString,&_cString);
    
//    self.sString = @"strong String";
//    self.cString = @"copy String";
//    NSLog(@"sString   : %@ : %p : %p",self.sString,self.sString,&_sString);
//    NSLog(@"cString   : %@ : %p : %p",self.cString,self.cString,&_cString);
    
    
//    NSString *string = @"Hello Word!";
//    NSString *string_2 = string;
//    NSString *string_3 = [string copy];
//    NSString *string_4 = [string mutableCopy];
//    NSLog(@"string   : %@ : %p : %p",string,string,&string);
//    NSLog(@"string_2 : %@ : %p : %p",string_2,string_2,&string_2);
//    NSLog(@"string_3 : %@ : %p : %p",string_3,string_3,&string_3);
//    NSLog(@"string_4 : %@ : %p : %p",string_4,string_4,&string_4);
//
//    string = @"hehe";
//
//    NSLog(@"string   : %@ : %p : %p",string,string,&string);
//    NSLog(@"string_2 : %@ : %p : %p",string_2,string_2,&string_2);
//    NSLog(@"string_3 : %@ : %p : %p",string_3,string_3,&string_3);
//    NSLog(@"string_4 : %@ : %p : %p",string_4,string_4,&string_4);
}

@end
