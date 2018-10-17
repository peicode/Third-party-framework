//
//  DetailSearchController.swift
//  Third-party-framework
//
//  Created by 廖佩志 on 2018/9/28.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit
import SnapKit

class DetailSearchController: UIViewController {

    
    var titleLabel: UILabel?
    var str: String?
    var id: String?
    var detailViewModel = DetailSearchViewModel()
    
    let stepCellID = "stepCellID"
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        detailViewModel.delegate = self
        detailViewModel.id = id ?? "C"
        detailViewModel.fetchSearchDataList()
    }
    
    /// 设置UI
    func setupUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(UINib(nibName: "PSStepCell", bundle: nil), forCellReuseIdentifier: stepCellID)
//        tableView.estimatedRowHeight = 300
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
        let lab = UILabel.init()
        view.addSubview(lab)
        lab.backgroundColor = #colorLiteral(red: 1, green: 0.5115470886, blue: 0, alpha: 1)
        lab.textAlignment = .center
        titleLabel = lab
        lab.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.top.equalTo(50)
            //            make.left.equalTo(100)
            make.centerX.equalToSuperview()
        }
        lab.text = str!
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }

}

// MARK: - delegate dataSource
extension DetailSearchController: DetailSearchViewModelDelegate,UITableViewDelegate,UITableViewDataSource{
    func fetchDataFinish() {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return detailViewModel.resultItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let stepModel = detailViewModel.resultSteps[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: stepCellID) as? PSTableViewCell
        if cell == nil {
//            cell = Bundle.main.loadNibNamed("PSStepCell", owner: self, options: nil)?.last as! PSStepCell
            cell = PSTableViewCell.init(style: .default, reuseIdentifier: stepCellID)
        }
        cell?.detailmodel = stepModel
        cell?.setFrameWithModel()
        cell?.delegate = self
        print(cell?.iconView.frame.height)
        return cell!
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let model = detailViewModel.resultSteps[indexPath.row]
//
//        return model.cellHeight
//    }
}
extension DetailSearchController: PSTableViewCellDelegate{
    func iconViewDidSelect() {
        //进入新的控制器
//        let BrowseVc = BrowseViewController.init(imageCounts: <#T##NSArray#>, currentIndexP: <#T##IndexPath#>)
        
    }
}
//extension DetailSearchController: BrowsePresentDelegate{
//    func imageForPresent(indexPath: IndexPath) -> UIImageView {
//        let imageV = UIImageView()
//        imageV.contentMode = .scaleAspectFill
//        imageV.clipsToBounds = true
//        //设置图片
//        let imageIndex = imageVM.imageArray[indexPath.row] as! String
//        imageV.image = UIImage(named: imageIndex)
//        return imageV
//        
//    }
//    
//    func startImageRectForPresent(indexPath: IndexPath) -> CGRect {
//        // 这里直接取得cell的frame，不是图片的frame
//        // 1.取出cell
//        guard let cell = collectionView?.cellForItem(at: indexPath) else {
//            return CGRect(x: collectionView!.bounds.width * 0.5, y: kScreenHeight + 50, width: 0, height: 0)
//        }
//        
//        // 2.计算转化为UIWindow上时的frame
//        return collectionView!.convert( cell.frame, to: UIApplication.shared.keyWindow)
//    }
//    
//    func endImageRectForPresent(indexPath: IndexPath) -> CGRect {
//        let imageIndex = imageVM.imageArray[indexPath.row]
//        let icon = UIImage(named: imageIndex as! String)
//        
//        let imageH = kScreenWidth / (icon?.size.width)! * (icon?.size.height)!
//        let y = imageH < kScreenHeight ? (kScreenHeight - imageH) / 2 : 0
//        
//        return CGRect(x: 0, y: y, width: kScreenWidth, height: imageH)
//    }}

