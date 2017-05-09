/*
 数组
 1.swift存放类型可以存基础数据类型和结构体不需要包装，oc需要包装NSNumber，NSValue(包装结构体)
 2.如果数组类型中的类型不一致，自动推导成NSObject
	注意的是，CG 结构体中，还是需要用NSValue包装
 3.swift 中还有一种类型，AnyObject —> 任意对象，可以没有父类，这个跟oc所有的类都有父类是不同的
 4.遍历数组
 (1） 与oc一样直接用[]去下标 					for i in 0..<array.count
	（2）与OC一样用for in 遍历   					for s in array
	（3）与OC一样用同时遍历下标和内容                 	for e in array.enumerated()
	（4）swift特有的同事遍历下标和内容			for (n,s) in array.enumerated()
	（5）反序遍历								for s in array.reversed()
	（6）反序遍历下标&内容(先枚举后反序)			for (n,s) in array. enumerated().reversed()
 5.数组的增删改
	（1）OC中数组可分为不可变NSArray和可变NSMutableArray，swift中用的是let，var来声明
	（2）追加元素								array.append(“111”)
	（3）修改通过下标定位修改					array[0] = “222”
	（4）删除									array.remove(at:3); array.removeAll(keepingCapcity:ture)（移除但是保留空间）
 6.数组的初始化可变数组，初始化容量为0，若插入后，如果还要插入容量不够，则容量=当前容量*2+1。如果初始化指定容量，可以避免插入时重复分配空间
 var array = [int]()
 7.数组的合并 var array1 ，let array2。
	（1） array1 += array2 要合并的数组的类型必须一致，不同类型
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test8()
    }
    
    //数组存储类型
    func test1() {
        let arrayInt:[Int] = [1,2,4,5];
        let arrayStr:[String] = ["1","2","3","4"];
        let arrayPoint:[CGPoint] = [CGPoint.init()];
        let arrayAny:[AnyObject] = [1 as AnyObject,"11" as AnyObject];
        print(arrayInt,arrayStr,arrayPoint,arrayAny);
    }
    
    //数组的遍历
    func test2() {
        let arrayInt:[Int] = [11,22,33,44];
        //for in 遍历
        for i in arrayInt {
            print(i);
        }
        
        //下标法遍历
        for i in 0..<arrayInt.count {
            print(arrayInt[i])
        }
        
        //遍历下标和内容1
        for s in arrayInt.enumerated() {
            print(s.offset,s.element);
        }
        
        //遍历下标和内容2
        for (index,value) in arrayInt.enumerated() {
            print(index,value);
        }
        
        //返序for in 遍历
        for i in arrayInt.reversed() {
            print(i);
        }
        
        //返序遍历下标和内容
        for (index,value) in arrayInt.enumerated().reversed() {
            print(index,value);
        }
    }
    
    //数组的添加
    func test3() {
        var arrayInt:[Int] = [11,22,33,44];
        arrayInt.append(55);
        print(arrayInt,arrayInt.count);
    }
    //插入
    func test4() {
        var arrayInt:[Int] = [11,22,33,44];
        arrayInt.insert(0, at: 0);
        print(arrayInt,arrayInt.count);
    }
    //删除
    func test5() {
        var arrayInt:[Int] = [11,22,33,44];
        arrayInt.remove(at: 0);
        print(arrayInt,arrayInt.count);
    }
    //修改
    func test6() {
        var arrayInt:[Int] = [11,22,33,44];
        arrayInt[1] = 2;
        print(arrayInt,arrayInt.count);
    }
    
    //可变数组的初始化及容量变化
    func test7() {
        var arrayInt:[Int] = [];
        for i in 0...10 {
            print(arrayInt.capacity)
            arrayInt.append(i);
        }
    }
    
    //数组的合并
    func test8() {
        var arrayInt:[Int] = [11,22,33,44];
        let newArrayInt:[Int] = [55,66,77];
        arrayInt += newArrayInt;
        print(arrayInt);
    }
}

