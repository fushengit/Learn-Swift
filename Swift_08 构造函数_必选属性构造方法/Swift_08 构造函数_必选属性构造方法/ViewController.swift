/*
    构造函数
 1.（） 相当于 alloc  init。  swift中对应一个init()构造函数，作用是给成员变量分配内存空间并初始化
 2.构造函数的写法：
	一：必选属性的构造方法
	1.给自己的属性分配内存空间并设置初始值
	2.调用父类的构造函数，给父类的属性分配雷村空间设置初始值(Swift3.0以前是需要的)
	3.NSObject没有属性，只有一个成员变量 isa·
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let s = Student1();
        print(s.name,s.no);
    }
}

//MARK: -必选属性的构造方法
class Person1: NSObject {
    var name:String
    var age:Int
    override init() {
        name = "张三"
        age = 10
        //在swift3.0 以前需要用 super.init()
        //现在系统默认调用
    }
}
class Student1: Person1 {
    var no:String
    override init() {
        no = "101"
        //在swift3.0 以前需要用
        //super.init()
    }
}
