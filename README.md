# CopyTest
深拷贝与浅拷贝

Objective-C 对象是通过指向该对象内存地址的指针，以间接方式访问的。

指针赋值：
* MRC 下仅仅将一个新的指针指向该内存地址，并没有获取该内存的所有权，引用计数不变；
* ARC 下由于默认使用 strong 修饰，因此将一个新的指针指向该内存地址，获取该内存的所有权，引用计数+1；


对于实现了NSCopying与NSMutableCopying协议的对象来说，指针赋值并非简单的赋值，还有额外的操作：
* 浅拷贝：类似于ARC下的指针赋值，将一个新指针指向该内存地址；
* 深拷贝：将一个新指针指向新的内存对象，该内存的数据与被复制的数据相同！如果改变原内存数据，新对象不会随着改变！


#### 2、非容器类与容器类


##### 2.1、非容器类 NSString

系统类 `NSString` 实现了 `NSCopying` 与 `NSMutableCopying` 协议

##### 2.1.1、不可变对象 `NSString`

```
{
    NSString *string = [[NSString alloc] initWithString:@"String"];
    NSString *string_1 = string;
    NSString *string_2 = [string copy];
    NSString *string_3 = [string mutableCopy];
    NSLog(@"string     : %@",logString(string));
    NSLog(@"string_1   : %@",logString(string_1));
    NSLog(@"string_2   : %@",logString(string_2));
    NSLog(@"string_3   : %@",logString(string_3));
}

/** 打印日志
string     : String  0x1070701a8 |  rCount :-1 | __NSCFConstantString
string_1   : String  0x1070701a8 |  rCount :-1 | __NSCFConstantString
string_2   : String  0x1070701a8 |  rCount :-1 | __NSCFConstantString
string_3   : String  0x600003f381e0 |  rCount :1 | __NSCFString
 */
```

##### 2.1.2、可变对象 `NSMutableString`

```
{
    NSMutableString *mString = [[NSMutableString alloc] initWithString:@"Mutable String"];
    NSString *mString_1 = mString;
    NSString *mString_2 = [mString copy];
    NSString *mString_3 = [mString mutableCopy];
    NSLog(@"mString     : %@",logString(mString));
    NSLog(@"mString_1   : %@",logString(mString_1));
    NSLog(@"mString_2   : %@",logString(mString_2));
    NSLog(@"mString_3   : %@",logString(mString_3));
}
/** 打印日志
mString     : Mutable String  0x600003f10840 |  rCount :1 | __NSCFString
mString_1   : Mutable String  0x600003f10840 |  rCount :1 | __NSCFString
mString_2   : Mutable String  0x60000316d420 |  rCount :1 | __NSCFString
mString_3   : Mutable String  0x600003f12160 |  rCount :1 | __NSCFString
 */
```

操作 |非容器类 `NSString`|`NSMutableString`
-|-|-
`copy`|类似于ARC下的指针赋值|深拷贝，得到一个可变对象
`mutableCopy`|深拷贝，得到一个可变对象|深拷贝，得到一个可变对象



##### 2.2、容器类 `NSArray`、`NSDictionary`

##### 2.2.1、容器类 `NSArray`

```
{
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
/** 打印日志：
string  :  String  0x10aa001a8 |  rCount :-1 | __NSCFConstantString
mString :  Mutable String  0x600002c4e550 |  rCount :1 | __NSCFString
mString :  Mutable String_2  0x600002c4e550 |  rCount :3 | __NSCFString
array     :
      String ：0x10aa001a8
      Mutable String_2 ：0x600002c4e550
  0x6000022485e0 | rCount :2 | __NSArrayI
array_1   :
      String ：0x10aa001a8
      Mutable String_2 ：0x600002c4e550
  0x6000022485e0 | rCount :2 | __NSArrayI
array_2   :
      String ：0x10aa001a8
      Mutable String_2 ：0x600002c4e550
  0x6000022485e0 | rCount :2 | __NSArrayI
array_3   :
      String ：0x10aa001a8
      Mutable String_2 ：0x600002c4e550
  0x600002c463d0 | rCount :1 | __NSArrayM

  
mArray     :
      String ：0x10aa001a8
      Mutable String_2 ：0x600002c4e550
  0x600002c44000 | rCount :1 | __NSArrayM
mArray_1   :
      String ：0x10aa001a8
      Mutable String_2 ：0x600002c4e550
  0x600002c44000 | rCount :1 | __NSArrayM
mArray_2   :
      String ：0x10aa001a8
      Mutable String_2 ：0x600002c4e550
  0x6000022408c0 | rCount :1 | __NSArrayI
mArray_3   :
      String ：0x10aa001a8
      Mutable String_2 ：0x600002c4e550
  0x600002c78ff0 | rCount :1 | __NSArrayM
*/
```

##### 2.2.2、容器类`NSDictionary`

```
{
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

/** 打印日志
string  :  String  0x10fba11a8 |  rCount :-1 | __NSCFConstantString
mString :  Mutable String  0x600003859f20 |  rCount :1 | __NSCFString
dict    :
    NSString String ：0x10fba11a8
    NSMutableString Mutable String ：0x600003859f20
   0x600002360700 | rCount :2 | __NSDictionaryI
dict_1  :
    NSString String ：0x10fba11a8
    NSMutableString Mutable String ：0x600003859f20
   0x600002360700 | rCount :2 | __NSDictionaryI
dict_2  :
    NSString String ：0x10fba11a8
    NSMutableString Mutable String ：0x600003859f20
   0x600002360700 | rCount :2 | __NSDictionaryI
dict_3  :
    NSString String ：0x10fba11a8
    NSMutableString Mutable String ：0x600003859f20
   0x600003611da0 | rCount :1 | __NSDictionaryM
   
mDict    :
    NSString String ：0x10fba11a8
    NSMutableString Mutable String ：0x600003859f20
   0x600003611600 | rCount :1 | __NSDictionaryM
mDict_1  :
    NSString String ：0x10fba11a8
    NSMutableString Mutable String ：0x600003859f20
   0x600003611600 | rCount :1 | __NSDictionaryM
mDict_2  :
    NSString String ：0x10fba11a8
    NSMutableString Mutable String ：0x600003859f20
   0x600003650860 | rCount :1 | __NSFrozenDictionaryM
mDict_3  :
    NSString String ：0x10fba11a8
    NSMutableString Mutable String ：0x600003859f20
   0x600003650800 | rCount :1 | __NSDictionaryM
 */
```


操作 |`NSArray`、`NSDictionary`|`NSMutableArray`、`NSMutableDictionary`|容器中元素
-|-|-|-
`copy`|浅拷贝，类似于ARC下的指针赋值|深拷贝，得到一个可变对象|浅拷贝
`mutableCopy`|深拷贝，得到一个可变对象|深拷贝，得到一个可变对象|浅拷贝

#### 3、`NSString` 类型的属性修饰符

什么时候使用 `copy` 修饰 `NSString` 类型的属性？什么时候使用 `strong` 修饰 `NSString` 类型的属性？


```
@property (nonatomic ,strong) NSString *sString;
@property (nonatomic ,copy) NSString *cString;
```

#### 3.1、赋值`NSMutableString`常量

```
{
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
}

/** 打印日志
mString   : Mutable String : 0x600002f19650 : 0x7ffee5f1a138 : 2
sString   : Mutable String : 0x600002f19650 : 0x7fad5cf0d800 : 2
cString   : Mutable String : 0x600002135d40 : 0x7fad5cf0d808 : 1

mString   : Mutable String_1 : 0x600002f19650 : 0x7ffee5f1a138 : 2
sString   : Mutable String_1 : 0x600002f19650 : 0x7fad5cf0d800 : 2
cString   : Mutable String : 0x600002135d40 : 0x7fad5cf0d808 : 1

mString   : Mutable String_2 : 0x600002f0c1b0 : 0x7ffee5f1a138 : 1
sString   : Mutable String_1 : 0x600002f19650 : 0x7fad5cf0d800 : 2
cString   : Mutable String : 0x600002135d40 : 0x7fad5cf0d808 : 1
 */
```

将 `NSMutableString *mString` 赋值给上述属性 `cString` 与 `sString`：
* `copy` 修饰的变量`cString`属于深拷贝，使用新的指针指向新的内存地址，新的内存地址存储的数据与被赋值的数据相同;
* `strong` 修饰的变量`sString`属于浅拷贝，使用新的指针指向被赋值变量的内存地址，类似于 `retain` 操作，引用计数 +1；

改变 `mString.string` 的值：
* 由于变量`cString`属于深拷贝，不被 `mString` 的操作影响;
* `strong` 修饰的变量仍然指向 `mString` 的内存，因此该变量的字符串也被改变;
 
将 `mString` 指向别处：
* 由于变量`cString`属于深拷贝，不被 `mString` 的操作影响；
* `strong` 修饰的变量仍然指向原有内存，值不改变；

#### 3.2、赋值`NSString`常量

```
{        
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

/** 打印日志
string   : Hello Word! : 0x109ce5608 : 0x7ffee5f1a130 : -1
sString   : Hello Word! : 0x109ce5608 : 0x7fad5cf0d800 : -1
cString   : Hello Word! : 0x109ce5608 : 0x7fad5cf0d808 : -1

string   : hehe : 0x109ce5648 : 0x7ffee5f1a130 : -1
sString   : Hello Word! : 0x109ce5608 : 0x7fad5cf0d800 : -1
cString   : Hello Word! : 0x109ce5608 : 0x7fad5cf0d808 : -1
 */
```

将 `NSString *string` 赋值给上述属性 `cString` 与 `sString`：都是浅拷贝，类似于 `retain` 操作，引用计数 +1；
改变变量 `string` 的值，即将指针 `string` 指向别的内存地址；此时变量`cString` 与`sString` 指向原有内存，值不改变；

结论：

* 如果不希望属性变量 `string` 的值随着 `NSMutableString` 变化，就用`copy`来修饰`string`属性;
* 如果需要属性变量 `string` 的值随着 `NSMutableString` 变化而改变，就用`strong`来修饰`string`。

