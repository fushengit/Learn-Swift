/*
        Swift 运行时加载属性列表：类似OC
	1.获取’类’的属性列表
	2.遍历数组
	3.根据下标获取属性：objc_property_t?
	4.获取属性的名称的C语言字符串
	5.转换成string
	6.释放C语言对象
	7.推荐使用guard 依次判断可选项
    8.需要注意的是  使用private 的时候，并非只能获取得到非私有的属性，通过运行时也可以获取到私有属性.下面连个例子就是参照说明
 
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(Person.varlists(), Person.propertys());
        
    }
}
class Person: NSObject {
    var name:String?
    var age:Int = 10;
    private var title:String?
    
    //获取所有的属性
    class func varlists() -> [String] {
        var result: [String] = [String]()
        var count: UInt32 = 0;
        //UnsafeMutablePointer<Ivar?>
        let varlist = class_copyIvarList(self, &count);
        for i in 0..<Int(count) {
            let ivar = varlist?[i]
            //reture A C string containing the instance variable's name.
            let cStr = ivar_getName(ivar)
            result.append(String.init(cString: cStr!))
        }
        free(varlist)
        return result;
    }
    //获取非私有的属性
    class func propertys() -> [String]{
        var result: [String] = [String]()
        var count: UInt32 = 0;
        let propertyList = class_copyPropertyList(self, &count)
        for i in 0..<count {
            let objc_property = propertyList?[Int(i)];
            //return A C string containing the property's name.
            let cStr = property_getName(objc_property)
            result.append(String.init(cString: cStr!))
        }
        free(propertyList)
        return result;
        
    }
}
