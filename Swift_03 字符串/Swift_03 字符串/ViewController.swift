/*
    字符串 string  (注意区别NSString) ,建议转换成NSString后使用
 1.支持遍历 .characters
 2.lengthofbytes  返回指定编码状态下的字节长度
 3.characters.count 返回展示的长度(推荐使用)
 4.将string 转换成 NSString
 5.字符换的拼接
 6.使用格式字符串
 7.字符串的子串
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        test5(friend: nil);
        test6()
    }

    //字符串的遍历
    func test1() {
        let myStr:String = "hello word";
        for i in myStr.characters {
            print(i);
        }
    }
    //字符串的编码长度
    func test2() {
        let myStr:String = "hello word 你好";
        print(myStr.lengthOfBytes(using: String.Encoding.utf8));
    }
    //字符串字符个数(OC中字符串的长度)
    func test3() {
        let myStr:String = "hello word 你好";
        print(myStr.characters.count);
    }
    // String -> NSString
    func test4() {
        let myStr:String = "hello word 你好";
        let myOCStr = myStr as NSString;
        print(myOCStr.length);
    }
    
    //字符串的拼接
    func test5(friend:String?) {
        var greeting = "Hello, "
        if let name = friend {
            greeting.append(name)
        } else {
            greeting.append("friend")
        }
        print(greeting)
    }
    
    //格式字符串
    func test6() {
        print(String.init(format: "%d", 10))
    }
    
    //子串
    func test7() {
        let myStr:String = "hello word 你好";
        let subStr1 = myStr.substring(to: "11".endIndex);
        print(subStr1);
        let subStr2 = myStr.substring(from: "hello".endIndex)
        print(subStr2)
        //还不会.....
//        let subStr3 = myStr.substring(with: <#T##Range<String.Index>#>)
//        print(subStr3)
        
    }
}

