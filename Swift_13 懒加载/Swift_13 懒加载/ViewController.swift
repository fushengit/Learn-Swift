/**
 懒加载、计算型属性、反射机制
 1.懒加载：
	目的:1.延迟创建，需要时加载，节省内存空间
        2.避免开发中处理解包的问题（重要！！！）
	
	知识:1.所有的UIView 及子类在开发是，一旦重写了构造函数，必须要实现initwithcoder函数以保证提供两个通道，目前Xcode会有提示。
 2.在swift中懒加载的简单写法
 lazy var label:UILabel = UILabel()
 3.懒加载本质上是一个闭包,完整写法如下:
 {}包装代码  ()执行代码
 lazy var labe = {()->UILabel in
 let l = UILabel()
 return l
 }()
 注意的是了解就好，因为日常开发法中在闭包中的提示不太好，且需要注意循环引用
 4.懒加载和OC的区别：
 （1）在OC中是使用get方法实现懒加载的。
 （2）OC中只要设置成nil以后，可以再通过get方法重新加载，而在swift中懒加载只能加载一次，如果设置成nil以后，就不能直接通过懒加载重新创建
 
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        test1()
//        test2()
//        test3()
        test4()
    }
    
    //非懒加载的方法，该属性在该类被创建的时候同时创建
//    var label1:MyLabel = MyLabel()
   
    //懒加载的简单写法
    lazy var label2:MyLabel = MyLabel()
    
    //懒加载的本质写法
    lazy var label3:MyLabel = {
        let label = MyLabel()
        return label
    }()
    
    //懒加载可选项
    lazy var label4:MyLabel? = MyLabel()
    
    
    //执行该方法结论:
    //非懒加载 var label1:MyLabel = MyLabel() 在 ViewController创建的时候就会自动创建
    func test1() {
        print("viewDidLoad 走了")
    }
    //注释掉label1后执行该方法结论:
    //懒加载的方法只会在第一次使用的时候加载label2
    func test2() {
        print("viewDidLoad 走了")
        label2.text = "label2 第一次被使用"
        print(label2.text ?? "")
    }
    
    //注释掉label1后执行该方法结论:
    //懒加载的方法只会在第一次使用的时候加载label3
    //执行效果与test2 相同，label3 和label2 的懒加载一个是简单创建方法，一个是本质写法
    func test3() {
        print("viewDidLoad 走了")
        label3.text = "label3 第一次被使用"
        print(label3.text ?? "")
    }
    /*
     注释掉label1后 打印结果:
     viewDidLoad 走了
     MyLabel ---被创建了
     label4 第一次被使用
     label4 已经被释放了
     懒加载方法一般是不用可选项的，因为懒加载只是会在第一次使用的时候加载，如果第一次加载完成后又设置成nil, 那么第二次使用的时候是不会重新创建的
     */
    func test4() {
        print("viewDidLoad 走了")
        label4?.text = "label4 第一次被使用"
        print(label4?.text ?? "")
        
        label4 = nil
        print(label4 ?? "label4 已经被释放了")
    }
}


class MyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("MyLabel ---被创建了")
    }
    //因为在所有的view中，只要重写构造方法就必须重写下列函数，否则就会crash
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
}












