//
//  ViewController.swift
//  Swift_12 UI练习_联系列表
//
//  Created by 123 on 17/5/9.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import UIKit

//联系人列表控制器
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var datasArray: [Person] = [Person]()
    var mainTabeleView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        //导航栏设置
        setNav()
        //
        setTableView()
        //请求数据并刷新UI
        requestData { (data) in
            self.datasArray += data
            self.mainTabeleView?.reloadData()
        }
    }

    //导航栏设置
    func setNav() {
        navigationItem.title = "联系人列表"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addPerson))
    }
    func addPerson() -> Void {
        let detailVC = DetailPersonController.init()
        detailVC.completeAction = {
            (person) in
            self.datasArray.insert(person, at: 0)
            self.mainTabeleView?.beginUpdates()
            self.mainTabeleView?.insertRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
            self.mainTabeleView?.endUpdates()
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
    //tableview设置
    func setTableView() -> Void {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        mainTabeleView = tableView;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "mycell")
        }
        let p = datasArray[indexPath.row]
        cell?.textLabel?.text = p.name
        cell?.detailTextLabel?.text = p.phone
        cell?.showsReorderControl = true
        cell?.accessoryType = .disclosureIndicator;
        return cell!;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailPersonController.init()
        detailVC.p = datasArray[indexPath.row]
        detailVC.completeAction = {
            (person) in
            self.mainTabeleView?.beginUpdates()
            self.mainTabeleView?.reloadRows(at: [indexPath], with: .automatic)
            self.mainTabeleView?.endUpdates()
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
    //数据网络请求
    func requestData(complete:@escaping (_ array: [Person])->()) -> Void {
        //这里我们模拟
        URLSession.shared.dataTask(with: URL.init(string: "http://www.baidu.com")!) { (_, response, error) in
            if error != nil {
                print("数据请求失败 \(error)")
                return
            }
            var json:[Person] = [Person]()
            for i in 0...10{
                let dict:[String:Any] = ["name":String.init(format: "小明 %d", i),"phone":String.init(format: "186 009%5d ", arc4random()/5),"age":10+arc4random()/5]
                let p = Person.init(dict: dict)
                json.append(p)
            }
            DispatchQueue.main.async {
                complete(json)
            }
        }.resume()
    }
    
}

//联系人详情控制器
class DetailPersonController: UIViewController {
    var p:Person?
    var completeAction:((_ person:Person)->())?

    var textFiled1 = UITextField.init(frame: CGRect.init(x: 10, y: 120, width: 300, height: 30))
    var textFiled2 = UITextField.init(frame: CGRect.init(x: 10, y: 160, width: 300, height: 30))
    var textFiled3 = UITextField.init(frame: CGRect.init(x: 10, y: 200, width: 300, height: 30))
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        view.addSubview(textFiled1)
        view.addSubview(textFiled2)
        view.addSubview(textFiled3)
        textFiled1.borderStyle = .roundedRect;
        textFiled2.borderStyle = .roundedRect;
        textFiled3.borderStyle = .roundedRect;
        textFiled2.keyboardType = .phonePad;
        textFiled3.keyboardType = .numberPad;
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "完成", style: .plain, target: self, action: #selector(commitAction))
        
        if let nP = p {
            textFiled1.text = nP.name
            textFiled2.text = nP.phone
            textFiled3.text = String.init(format: "%d", nP.age)
        }
    }
    
    func commitAction(){
        if p==nil {
            p = Person()
        }
        p?.name = textFiled1.text;
        p?.phone = textFiled2.text;
        if let ageText = textFiled3.text,
            let ageInt = Int(ageText){
            p?.age = ageInt
        }
        if let p = p,
            let completeAction = completeAction
        {
            completeAction(p)
        }
       _ = navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("DetailPersonController  释放了")
    }
}


//联系人模型
class Person: NSObject {
    var name:String?
    var phone:String?
    var age:Int = 0;
    convenience init(dict:[String:Any]) {
        self.init()
        self.setValuesForKeys(dict)
    }
}



