/*
    UI练习：写一个简单的加法计算器
 */

import UIKit

class ViewController: UIViewController {

    var textField1 : UITextField?
    var textField2 : UITextField?
    var lable1     : UILabel?
    var lable2     : UILabel?
    var lable3     : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField1 = UITextField.init(frame: CGRect.init(x: 20, y: 20, width: 100, height: 30));
        textField1?.text = "0";
        textField1?.textAlignment = .center;
        textField1?.borderStyle = .line;
        if let f1 = textField1 {
            view.addSubview(f1);
        }
    
        lable1 = UILabel.init(frame: CGRect.init(x: 120, y: 20, width: 20, height: 30));
        lable1?.text = "+";
        lable1?.textAlignment = .center;
        if let l1 = lable1 {
            view.addSubview(l1);
        }
        
        textField2 = UITextField.init(frame: CGRect.init(x: 140, y: 20, width: 100, height: 30));
        textField2?.text = "0";
        textField2?.textAlignment = .center;
        textField2?.borderStyle = .line;
        if let f2 = textField2 {
            view.addSubview(f2);
        }
        
        
        lable2 = UILabel.init(frame: CGRect.init(x: 240, y: 20, width: 20, height: 30));
        lable2?.text = "=";
        lable2?.textAlignment = .center;
        if let l2 = lable2 {
            view.addSubview(l2);
        }
        
        lable3 = UILabel.init(frame: CGRect.init(x: 260, y: 20, width: 60, height: 30));
        lable3?.text = "0";
        lable3?.textAlignment = .center;
        if let l3 = lable3 {
            view.addSubview(l3);
        }
        
        let btn = UIButton.init(type: .custom);
        btn.setTitle("计算", for: .normal);
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.center = view.center
        btn.sizeToFit();
        view.addSubview(btn);
        btn.addTarget(self, action: #selector(caculate), for: .touchUpInside)
    }

    func caculate() {
        guard let num1 = Int(textField1?.text ?? "0"),
        let num2 = Int(textField2?.text ?? "0")else {
            print("请输入正确的计算数字");
            return;
        }
        print("result =  \(num1 + num2)")
        lable3?.text = "\(num1 + num2)";
    }
    
}

