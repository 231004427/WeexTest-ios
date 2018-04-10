//
//  SelectPickerView.swift
//  WeexTest
//
//  Created by 孙林 on 2018/4/9.
//  Copyright © 2018年 sunlin. All rights reserved.
//

import Foundation
protocol SelectPickerViewDelegate: class {
    func selectSure(index: Int?, value:String?)
}
class SelectPickerView:UIView{
    let backView = UIButton()
    var pickerView: UIPickerView?
    var barView: MylineUIView?
    var loadView:UIButton?
    var cancelBtn: UIButton?
    var sureBtn: UIButton?
    var addView:UIView?
    private let animateTime = 0.3
    private let barHeight: CGFloat = 44.0
    private let pickerHeight: CGFloat = 200
    private let viewHeight:CGFloat = 244
    var vd : [String : AnyObject] = [String : AnyObject]()
    weak var delegate:SelectPickerViewDelegate?
    var select = 0
    var list:[String]!
    
    @objc func show(){
        isHidden=false
        UIView.animate(withDuration: animateTime, animations: {
            self.backView.frame=CGRect(x: 0, y: self.bounds.height-self.viewHeight, width: self.bounds.width, height: self.viewHeight)
            self.backView.backgroundColor=UIColor.red
        }){[weak self] (finished) in
            if finished {
                //初始化数据
            }
        }
    }
    @objc func hide(){
        UIView.animate(withDuration: animateTime, animations: {
           self.backView.frame=CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: self.viewHeight)
        }){[weak self] (finished) in
            if finished{self?.isHidden=true}
            self?.removeFromSuperview()
        }
    }
    @objc func sure(){
        select = pickerView!.selectedRow(inComponent: 0)
        if delegate != nil {
            delegate?.selectSure(index: select, value: list[select])
        }
        hide()
    }
    class func addTo(superView:UIView) -> SelectPickerView{
        let pickerView = SelectPickerView(frame: CGRect(x: 0, y: 0, width: superView.frame.width, height: superView.frame.height))
        superView.addSubview(pickerView)
        return pickerView
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.white
        isHidden=true
        list=["aaa","bbb","ccc"]
        loadBackView()
        loadTitleBar()
        loadLoadingView()
        loadPicker()
    }
    //加载loading
    private func loadLoadingView(){
        loadView=UIButton()
        loadView?.isHighlighted=false
        loadView?.adjustsImageWhenHighlighted=false
        loadView?.adjustsImageWhenDisabled = false
        //loadView?.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.viewHeight)
        loadView?.setImage(UIImage(named:"cat22"), for: UIControlState.normal)
        loadView?.setTitle("加载中", for: UIControlState.normal)
        loadView?.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        loadView?.setTitleColor(SWColor.init(hexString: "#cccccc"), for: UIControlState.normal)
        loadView?.translatesAutoresizingMaskIntoConstraints=false
        backView.addSubview(loadView!)
        vd["loadView"] = loadView!
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[loadView(120)]", options: [], metrics: nil, views: vd))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[loadView(44)]", options: [], metrics: nil, views: vd))
        addConstraints([NSLayoutConstraint(item: loadView!, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.backView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)])
        addConstraints([NSLayoutConstraint(item: loadView!, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self.backView, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0)])
        
    }
    //加载弹框
    private func loadBackView() {
        addSubview(backView)
        backView.frame = CGRect(x: 0, y: self.bounds.height, width: self.bounds.width, height: self.viewHeight)
        backView.addTarget(self, action: #selector(hide), for: .touchUpInside)
    }
    //加载标题栏
    private func loadTitleBar(){
        
        barView = MylineUIView()
        barView?.type=2
        barView?.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: barHeight)
        //            let backColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        barView?.backgroundColor = SWColor.white
        barView?.translatesAutoresizingMaskIntoConstraints=false
        
        backView.addSubview(barView!)
        
        vd["barView"] = barView!
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[barView]|", options: [], metrics: nil, views: vd))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[barView(44)]", options: [], metrics: nil, views: vd))
        
        cancelBtn = UIButton(type: .custom)
        cancelBtn?.setTitle("取消", for: UIControlState())
        cancelBtn?.addTarget(self, action: #selector(hide), for: .touchUpInside)
        let cancelColor = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        cancelBtn?.setTitleColor(cancelColor, for: UIControlState())
        cancelBtn?.frame = CGRect(x: 0, y: 0, width: 44, height: barHeight)
        barView?.addSubview(cancelBtn!)
        
        sureBtn = UIButton(type: .custom)
        sureBtn?.setTitle("确定", for: UIControlState())
        sureBtn?.addTarget(self, action: #selector(sure), for: .touchUpInside)
        let sureColor = UIColor(red: 5/255.0, green: 5/255.0, blue: 5/255.0, alpha: 1.0)
        sureBtn?.setTitleColor(sureColor, for: UIControlState())
        sureBtn?.frame = CGRect(x: (barView?.frame.size.width)! - 44, y: 0, width: 44, height: barHeight)
        barView?.addSubview(sureBtn!)
    }
    //加载下拉
    private func loadPicker() {
        if pickerView == nil {
            let dframe = CGRect(x: 0, y: barHeight, width: self.bounds.width, height: pickerHeight)
            
            pickerView = UIPickerView(frame: dframe)
            //UIColor(red: 239/255.0, green: 239/255.0, blue: 244/255.0, alpha: 1.0)
            pickerView?.backgroundColor = UIColor.white
            pickerView?.delegate = self
            pickerView?.dataSource = self
            backView.addSubview(pickerView!)
            pickerView?.translatesAutoresizingMaskIntoConstraints=false
            
            vd["pickerView"] = pickerView!
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[pickerView]|", options: [], metrics: nil, views: vd))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-44-[pickerView]|", options: [], metrics: nil, views: vd))
            
            //handleIsOpenLasst()
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension SelectPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch component {
        case 0:
            return list[row]
        default:
            return nil
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print("select:\(row) component:\(component)")
        switch component {
        case 0:
            //let selectC = pickerView.selectedRow(inComponent: 1)
            //let selectZ = pickerView.selectedRow(inComponent: 2)
            break
        default:
            break
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label = view as? UILabel
        if label == nil {
            label = UILabel()
            label?.textColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
            label?.adjustsFontSizeToFitWidth = true
            label?.textAlignment = .center
            label?.font = UIFont.systemFont(ofSize: 24)
        }
        label?.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        return label!
    }
}
extension SelectPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return list.count
        default:
            return 0
        }
    }
}
