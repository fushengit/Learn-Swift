/*
    函数
 1.函数的基础写法：func 函数名(参数列表) ->  返回值类型
 2.外部参数的使用,就是在形参前加一个名字，外部参数不会影响函数内部细节，外部参数会让外部调用看起来更加的直观
 3.默认值：通过给参数设置默认值，在调用的时候，可以任意组合参数，如果不指定就使用默认值。但是在OC中是不能实现的，需要定义多个函数
    
    闭包
 1.闭包的定义：类似于OC的block，但是比block应用更广泛
	OC中block是匿名的函数
	swift中函数是特殊的闭包
	1.提前准备好的代码
	2.在需要的时候执行
	3.可以当做参数传递
 2.OC中不能实现的函数赋值
 3.简单的闭包
    1.闭包中，参数，返回值，实现代码都是写在{}中
    2.{形参列表->返回值 in 实现代码}
    3.需要用 “in” 来分割定义和实现
 4.swift中GCD的使用方法
	1.GCD：将任务添加到队列，指定执行任务的函数
	2.翻译：队列调度任务（block/闭包）,以同步/异步 的方式来执行
 5.在异步执行任务，获取结果，通过 block/闭包 回调。 闭包的应用场景和block完全一致
 6.尾随闭包：如果函数的最后一个参数是闭包，函数参数可以提前结束，最后一个参数直接使用{}包装闭包的代码（3的例子）
 7.在OC中可以用{} 来区分作用域。但是在swift中是不行的，swift中遇到{}可能会识别为闭包
 8.swift中的循环应用：
    1.使用OC的方式
    2.Swift推荐方法
    3.Swift的一个特殊方法(不建议使用)
 9. [weak self ]是闭包整self的弱引用，如果self被释放，会自动设置为nil，与OC中的 __weak等效
	[unowned self] 是闭包中的self 的assign的 ，如果self被释放，指针地址保持不变，会出现野指针的错误，与OC中的 __unsafe_unretained 等效
 */
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        print(sum1(x: 10, y: 10));
        
//        print(sum2(num1: 10, num2: 10))
        
//        print(sum3())
//        print(sum3(x: 100))
//        print(sum3(y: 200))
//        print(sum3(x: 100, y: 200))
        
//        demo1();
//        demo2();
//        demo3();
//        demo6();

        demo7();

    }
    
    //1.函数的基础写法
    func sum1(x:Int,y:Int) -> Int {
        return x+y;
    }
    //2.外部参数
    func sum2(num1 x:Int,num2 y:Int) -> Int {
        return x+y;
    }
    //3.默认值
    func sum3(x:Int=10,y:Int=20) -> Int {
        return x+y;
    }
    //4.无返回值的情况：主要用在闭包
    func test1() {
    }
    func test2() -> () {
    }
    func test3() -> Void {
    }

    //1.OC中不能实现的函数赋值
    func demo1() {
        let f = sum1;
        print(f(10, 10))
    }
    //2.简单的闭包
    //没有参数和返回值的函数f (此情况下可以省略参数和返回值，包括”in”)
    func demo2() {
        let b1 = {
            print("hello word")
        }
        b1();
    }
    //3.带参数的闭包
    func demo3() {
        let b1 = {(x:Int)->() in
            print(x)
        }
        b1(100)
    }
    //4.带参数和返回值的闭包
    func demo4() {
        let  b1 = {(x:Int)->Int in
            return x+200
        }
        print(b1(100));
    }
    //5.GCD的用法
    func demo5() {
        DispatchQueue.global().async {
            print("耗时操作 \(Thread.current)");
            sleep(3);
            DispatchQueue.main.async {
                print("主线程刷新UI")
            }
        }
    }
    //6.block回调的应用方法
    func demo6() {
        loadData { (result) in
            for e in result{
                print(e);
            }
        }
    }
    func loadData(loadComplete:@escaping (_ myResult:[String])->()) -> () {
        DispatchQueue.global().async {
            print("耗时操作 \(Thread.current)");
            sleep(3);
            DispatchQueue.main.async {
                print("主线程刷新UI")
                let json = ["小王","小刘","小陈"]
                loadComplete(json)
            }
        }
    }
    //7.循环引用的解决方法
    func demo7() {
        //会造成循环引用的方法
//        loadData1 {
//            print(self.view);
//        }
        
        //方法1：OC的解决方案
//        细节1：要使用var修饰 不能使用let 。 因为weak可能在运行时被修改。weak指向的对象一旦被释放，会自动设置为nil ，所有不能为let
//        细节2：？(可选解包)通常用于单纯发送消息，没有计算       ！(强行解包) 强行解包必须有值，如果没有会造成崩溃，通常用于计算
//        weak var wSelf = self;
//        loadData1 {
//            print(wSelf?.view ?? ());
//        }
        //方法2：swift推荐解决方案
        loadData1 {
            [weak self] in
            print(self?.view ?? ())
        }
        //方法3：不建议使用
//        [unowned self] 表示闭包中所有的都是 assign的，不会强引用。但是对象释放指针地址不会变化，如果对象被释放，继续调用就会造成野指针的问题
//        loadData1 {
//            [unowned self] in
//            print(self.view)
//        }
    }
    
    var completeCallBack: (() -> ())?
    func loadData1(myComplete:@escaping ()->()) -> Void {
        completeCallBack = myComplete;
        myComplete()
    }
    
    deinit {
        print("被释放了")
    }
}

