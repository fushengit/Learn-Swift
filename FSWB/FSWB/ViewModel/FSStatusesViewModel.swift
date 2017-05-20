//
//  FSStatusesViewModel.swift
//  FSWB
//
//  Created by 123 on 17/5/19.
//  Copyright © 2017年 MakeKeyReuseable. All rights reserved.
//

import Foundation

class FSStatusesViewModel {
    
    lazy var statusesList:[FSStatusesModel] = [FSStatusesModel]()
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - isLoadMore: 是否是上拉加载更多
    ///   - complete: 完成回调
    func loadData(isLoadMore:Bool = false,complete:@escaping (_ isSucc:Bool ,_ error:String?) -> ()) -> () {
        let since_id = isLoadMore ? 0:(statusesList.first?.id ?? 0)
        var max_id = isLoadMore ? (statusesList.last?.id ?? 0):0
        max_id = max_id > 0 ? max_id-1:0
        FSNetWorkManager.shared.statusesHomeTimeline(since_id: since_id, max_id: max_id)  { (isSucc, json, errorCode) in
            //MARK: 这里可以根据返回的code来自定义提示错误信息返回给主页面
            var errStr:String?
            if errorCode == 403 {
                errStr = "授权过期"
            }
            let array = NSArray.yy_modelArray(with: FSStatusesModel.self, json: json ?? [])
            guard let listArray = array as? [FSStatusesModel] else {
                complete(isSucc,errStr)
                return
            }
            if isLoadMore{
                self.statusesList += listArray
            }else{
                self.statusesList = listArray + self.statusesList
            }
            print("加载了\(listArray.count)条数据")
            complete(isSucc,errStr)
        }
    }
}
