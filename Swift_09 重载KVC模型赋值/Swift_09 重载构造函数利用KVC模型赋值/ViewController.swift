/*
    构造函数(KVC)，
 1.在手机开发中内存很宝贵，有些属性并不是必须分配空间的。
 2.延迟加载：在需要的时候才创建
 3.如果是模型属性的时候，如果是对象，通常都是可选的、简化写构造函数的时候的代码
 4.KVC的方法是OC的方法，在运行时给对象发送消息，要求对象已经实例化完成！应该使用spuer.init()实例化
 5.给基本数据类型初始化是不能设置成可选的，必须提前设置初始值。否则KVC会崩溃
 6.如果是私有属性 private  ，使用KVC设置值的时候，同样会无法设置，KVC会崩溃
 7.同OC一样，字典中的key如果类中没有队形的属性与之对应，则需要重写setvalueforundifindkey
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let dict:[String:Any] = ["name":"李明","title":"boss","age":15];
        let p = Person(dict: dict);
        print(p.name ?? "",p.age ,p.title ?? "")
//        print(p.name ?? "",p.age)
    }
}

class Person: NSObject {
    //如果使用KVC来赋值的话，属性通常是用可选的
    //错误写法 ： var name:String 程序会直接报错
    var name:String?
    
    //在swift中，如果是设置成私有属性private,那么绝对是私有的，KVC也不能访问。如果不重写 setvalue forundefinedkey 的情况下会造成crash
    //错误写法: private var title:String?
    var title:String?
    
    //这里的age是基本数据类型，是不能设置成可选的。
    //错误写法  var age:Int?
    var age:Int = 10;
    
    //需要重写这个防止字典中的key不能与属性对应造成crash
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    init(dict:Dictionary<String, Any>) {
        //因为KVC 是OC的方法，需要在运行时给对象发送消息，要求对象已经实例化完成，如果不写的话城西会报错
        super.init()
        self.setValuesForKeys(dict);
    }
}
