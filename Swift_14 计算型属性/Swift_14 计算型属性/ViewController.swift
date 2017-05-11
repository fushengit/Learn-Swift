/**
        计算型属性
	引导：在OC语言的开发过程中，我们常用cell赋值model ，重写model的set方法来实现给cell修改UI，但是在Swift中呢？
1.getter & setter 仅用于演示，日常开发不用:
	private var _name:String?
	var name:String{
        get{
            return  _name
        }
        set{
            _name = newValue
        }
	}
2. readonly  的实现：重写getter方法，通过只写get方法实现。
	var title:String{
        get{
            return “mr 老王”
        }
	}
	计算型属性:
	1.readonly 简写  ：直接return
	var title:String{
        return “老王”
	}
	其实这就是一个计算型属性：本身是不保存内容，都是通过计算获得的。类似于一个函数，没有参数只有返回值，每次计算都会重新计算一次。
 3.懒加载和计算型属性的区别
	1.代码非常类似！！！ 懒加载只是多了一个 ‘lazy’ 和’=’
	2.懒加载会在第一次访问的时候执行，闭包执行结束后会保存结果到属性，第二次调用的时候是不会重新执行闭包的。计算型属性每次访问都会执行一次闭包
 
 4.利用重写set方法实现通过模型赋值改变UI
	var person：Person? {
        didSet {
            //此时name属性有值，可以直接使用
            self.text = person?.name
        }
	}
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
    
    //1. Swift的set和get方法
    //在Swift中，我们通常不用正常的setter 和getter方法，一下方法只是为了对应OC来实现的
    private var _name:String?
    var name:String?{
        set{
            _name = newValue
        }
        get{
            return _name
        }
    }
    /*
     打印结果:
     给name赋值
     给name赋值
     
     缺点：1.我们其实只需要一个属性 ，但是实现需要两个属性来记录，代码阅读性低！
          2.代码量复杂
     */
    func test1() {
        name = "给name赋值"
        print(name ?? "name 没有值")
        print(_name ?? "_name 没有值")
    }
    
    
    //2.  readonly 实现
    //在Swift中  我们通常在定义属性的时候只写getter方法，这样就实现了只读功能
    var myTitle1:String {
        get{
            return "这是一个标题1"
        }
    }
    func test2()  {
        print(myTitle1)
        //使用 myTitle1 = "这不是一个标题2"  编译就会报错
    }
    
    //3.计算型属性
    //计算型属性本身是不保存内容的，每次使用都是重新计算（类似于一个函数）,注意和get方法的区别
    //在Swift中  我们也可以使用计算型属性来实现只读功能
    var myTitle2:String{
        return "我是一个标题2"
    }
    func test3() {
        print(myTitle2)
        //使用 myTitle2 = "这不是一个标题2"  编译就会报错
    }
    
    //4.用didSet 代替OC中的setter方法
    lazy var label:UILabel = UILabel()
    var myTitle3:String?{
        didSet{
            //这里myTitle3 是有值的
            //我们可以在这里实现给UI赋值
            print(myTitle3 ?? "myTitle3 为nil")
            label.text = myTitle3
        }
    }
    func test4() {
        //利用set方法给label赋值
        label.center = view.center
        label.textColor = UIColor.blue
        myTitle3 = "hello word"
        label.sizeToFit()
        view.addSubview(label)
    }
    
}

