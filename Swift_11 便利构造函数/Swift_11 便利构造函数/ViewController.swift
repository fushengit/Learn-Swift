/*
 14.便利构造函数
    目的：
	1.判断条件，只有条件满足才实例化对象
	2.简化对象的创建
	注意事项：
    3.本身不负责属性的创建和初始化操作
	4.便利构造函数允许返回nil,正常的构造函数一定会创建对象，判定给的参数是否符合条件，如果不符合则返回nil，不会创建对象，减少内存开销！
	5.只有便利构造函数中使用 ‘self.init’ 构造当前对象
	6.没有convenience 关键字的构造函数是负责创建对象的，反之是用来检查条件的，本身是不负责对象的创建
	7.如果要在便利构造函数中使用当前对象的属性，一定要在 self.init 之后
 */
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let p1 = Person(age: 0);
        let p2 = Person(age: 20);
        print(p1?.name ?? "没有值" ,p2?.name ?? "没有值")
        
        
        //注意这里！！！
        //如果直接重载构建函数，则 Student() 这个函数将不会再生效，便利构造函数就是来解决这个问题的
        let s1 = Student();
        let s2 = Student(name: "小红", age: 10);
        print(s1,s2)
    }
}

//判断条件，只有条件满足才实例化对象
class Person: NSObject {
    var name:String?
    convenience init?(age:Int) {
        if age<10 {
            return nil;
        }
        self.init()
        name = "小红"
    }
}

//简化对象的创建
class Student: NSObject {
    var name:String?
    var age:Int = 0;
    convenience init(name:String ,age:Int) {
        self.init();
        self.name = name;
        self.age = age;
    }
}
