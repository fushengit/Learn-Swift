/*
 字典
 1.字典的定义，OC中用{} ，swift中用[].   例如  let dict = [“name”:”张三”，“age”:10]
	特例： let array [[string : Any]] = [ [“name”:”张三”,”age”:10] , [“name”:”李四”,”age”:15]]
 
 2.字典的增删改 OC中有可变和不可变，swift中let 定义不可变， var 定义可变
	var dict:[String:Any] = [“name”:”张三”.”age”:15]
	新增 如果key不存在就是新增
	dict[“title”] = “大哥”
	修改 如果key存在就是修改
	dict[“name”] = “李四”
	删除  —指定key删除
	dict.removeValue(forKey:“name”)
	注意：字典是通过key来定位的，且key必须是可以 hash的(每一个key可以转换成一个唯一的整数)
	
 3.字典的遍历, OC遍历只能通过遍历key，然后才能取值
	for e in dict	e 是一个值对 用e.key  e.value  分别取值
	for (key,value) in dict    key,value 分别取值
	
 11.字典的合并
	var dict1 =  [“name”:”张三”.”age”:15]
	let  dict2 = [“name”:”李四”，“title”：“大哥”]
	字典不能和数组类似的直接相加！！！
	for e in dict2 {
 dict1[e.key] = dict2[e.key]
	}
	合并的过程，如果key存在只是修改，不存在是新增
 */

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        test4();
    }
    
    //字典的初始化
    func test1() {
        //字典
        let dict:[String:Any] = ["name":"小红","age":20]
        //数组包字典
        let dictArray:[[String:Any]] =
            [
                ["name":"小红","age":20],
                ["name":"小蓝","age":10]
            ]
        //空字典
        let mDict:[String:Any] = [:]
        print(dict,dictArray,mDict);
    }
    
    //字典的增，删，改
    func test2() {
        var dict:[String:Any] = ["name":"小红","age":20];
        //增(赋值字典中没有的key为增)
        dict["sex"] = "boy"
        //改(赋值字典中有的key为改)
        dict["name"] = "小蓝"
        //删(根据key移除)
        dict.removeValue(forKey: "age")
        print(dict);
    }
    
    //字典的遍历：利用for in 直接遍历所有的key和value
    func test3() {
        let dict:[String:Any] = ["name":"小红","age":20,"sex":"boy"];
        for (key,valye) in dict {
            print(key,valye)
        }
    }
    
    //字典的合并：本质上是可变字典的增改
    func test4() {
        var mDict:[String:Any] = ["name":"小红","age":20,"sex":"boy"];
        let dict:[String:Any] = ["sex":"boy","score":100]
        for (key,value) in dict {
            mDict[key] = value;
        }
        print(mDict);
    }
    
}








