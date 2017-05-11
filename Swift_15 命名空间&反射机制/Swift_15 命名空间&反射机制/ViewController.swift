/**
 5.命名空间&反射机制
1.反射机制的概念
 (1)在任意一个类，都能通过方法来获取这个类的所有属性和方法
 (2)对于任何一个对象，都能调用他的任意一个方法和属性
 (3)这种动态获取信息及动态的调用对象的方法功能成为Java 语言的反射机制
2.在OC中如何使用反射机制
 （1）利用NSClassFromString 方法来使用字符串获取类
 （2）isMemberofClass
 （3）isKindofClass
 （4）conformstoprotorol
 （5）respondstoselector
 （6）performSelector 或者obj_msgSend
3.主义事项：
 （1）在Swift中有命名空间
 （2）在同一个命名空间全局共享
 （3）第三框架使用swift如果直接拖拽到项目中，从属于同一个命名空间可能会有重提
 （4）在Swift中 NSClassFromString 是需要在前面添加命名空间的,例如: let clsName = “反射机制.ViewController”
 （5）反射重要的目的就是为了解耦
 （6）可以搜索“反射机制和工厂方法”继续学习反射机制
4.动态获得命名空间：
 4.1 在info.plist中  bundle name 就是命名空间
 4.2 info.plist 需要从bundle.main.infoDictionary读取
 4.3 所以命名空间为:Bundle.main.infoDictionary[“CFBundleName”]
 4.4 通过写分类实现代码精简：
 4.4.1 通过函数调用
 4.4.2 通过计算型属性。这种方法可以增加代码的可阅读型。
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        test1()
//        test2()
//        test3()
        test4()
    }
    
    //正常方法跳转
    func test1() {
        let detailVC = DetailController()
        present(detailVC, animated: true, completion: nil)
    }
    
    //反射机制 
    //在Swift中，NSClassFromString(str:String) 中的str必须前面加上该类的命名空间
    func test2() {
        let clsName = "DetailController"
        let cls = NSClassFromString(clsName) as? DetailController.Type;
        if let cls = cls {
            print(cls)
        }else{
            print("类不存在")
        }
    }
    //命名空间(也就是项目名称）最好不要用中文 或者特殊符号等，不然也是不太管用的
    func test3() {
        let clsName = "Swift_15 命名空间&反射机制.DetailController"
        let cls = NSClassFromString(clsName) as? DetailController.Type;
        if let cls = cls {
            print(cls)
        }else{
            print("类不存在")
        }
    }
    // 读取info.plist 也不管用  中文有坑！！！！
    func test4() {
        let productName = Bundle.main.infoDictionary?["CFBundleName"] as? String
        let clsName = (productName ?? "") + ".DetailController"
        print(clsName)
        let cls = NSClassFromString(clsName) as? DetailController.Type;
        if let cls = cls {
            print(cls)
        }else{
            print("类不存在")
        }
    }
    
}


class DetailController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
}





