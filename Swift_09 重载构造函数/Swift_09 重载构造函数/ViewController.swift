/*
    重载构造函数
 1.重载函数方法：函数名相同， 但是参数和个数不同。可以给自己的属性在外部调用的时候赋初始值。OC是没有重载的

 2.如果重载了构造函数，并且没有实现父类的init方法， 系统将不再提供init() 构造函数。因为默认的构造函数是不能给本类的属性分配内存空间
 
 3.控制台用 p 命令获取对象信息

 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let p = Person(name: "张三", age: 10);
        print(p.age,p.name)

        //Person() 函数已经被重载，系统将不再提供该函数
    }
}

class Person: NSObject {
    var name:String
    var age:Int
    init(name:String,age:Int) {
        self.name = name;
        self.age = age;
        //在Swift3.0以前是需要写 super.init()
        //现在系统默认在最后使用 super,init()
    }
}
