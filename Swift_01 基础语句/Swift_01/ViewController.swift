/*
    Swith 基础语法练习
 1.取消了预处理命令
 2.取消了指针的概念
 3.取消了NS前缀
 4.大量将类替换成struct
 5.“;” 在同一行用来分割语句，如果不是同一行可以省略
 6.可选项?
 7.playground
 8.条件语句”if”，空执行”()”
 9.没有非0即真的逻辑
 10.switch  
 （1）可以针对任意类型的值进行分支，不在局限在整数
 （2）且一般不需要break。
 （3）可以用“，”分割可选值
 （4）所有的分支最少需要一条指令，如果没用指令的时候，就用break
 11.传统的for循环已经被取消。 统一用for in   ，并支持反转(正序逆序)等
 12.i++, ++1 , i—， —i 都已经被取消
 */
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        test1();
//        test2(age: 0);
//        test3(num: 10)
        test4(name: "小红")
    }
    
    //条件语句if
    func test1(){
        if 1<10 {
            print("hello word");
        }
    }
    
    //三目
    func test2(age:Int) {
        age>10 ? print("大了"):()
    }
    
    //for语句
    func test3(num:Int) {
        //闭区间
        for _ in 0...num {
            print("hello ");
        }
        //半开半闭区间
        for i in 0..<num {
            print("hellow word \(i)")
        }
    }
    
    //switch 语句
    func test4(name:String) {
        switch name {
        case "小红":
            print("红色")
        case "小红","小蓝":
            print("红蓝")
        default:
            print("未知颜色")
        }
    }
}

