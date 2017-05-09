/*
    可选项
 1.使用！强行解包（慎用）
 2.使用 ？？  解包（实际上是一个特殊的三目），优先级较低，一般用（）包一下
 3.连用语法   if let / var    判断对象的值是否为nil，进入分支后不需要解包
 4.连用语法   guard let / var
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        test1(age1: 10, age2: 20);
//        test2(age1: nil, age2: 10)
//        test3(age1: 10, age2: 10)
        test4(age1: nil, age2: 10)
    }
    
    //“！” 强行解包
    func test1(age1:Int?,age2:Int?) {
        print(age1! + age2!)
    }
    // "??" 解包
    func test2(age1:Int?,age2:Int?) {
        print(age1 ?? (10))
    }
    // if let /var
    func test3(age1:Int?,age2:Int?) {
        if let Nage = age1 {
            print(Nage);
        }
    }
    
    // gurad let /var
    func test4(age1:Int?,age2:Int?) {
        guard age1 != nil else {
            print("不能计算空值")
            return
        }
    }

}

