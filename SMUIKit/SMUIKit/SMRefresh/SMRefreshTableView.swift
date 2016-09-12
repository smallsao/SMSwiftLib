//
//  SMRefreshTableView.swift
//  SMUIKit
//
//  Created by smallsao on 16/8/29.
//  Copyright © 2016年 smallsao. All rights reserved.
//

import UIKit

import SMExtension

@objc public protocol SMRefreshTableViewDelegate: NSObjectProtocol,UITableViewDelegate {

    @objc optional func tableHeaderRefresh(_ tableView:SMRefreshTableView)
    
    @objc optional func tableFooterRefresh(_ tableView:SMRefreshTableView)
}



public protocol SMRefreshTableViewDataSource:UITableViewDataSource {
    
}

enum SMRefreshTableHeaderViewStyle:Int {
    case Normal
    case Release
    case Loading
}

enum SMRefreshTableFooterViewStyle:Int {
    case Normal
    case Release
    case Loading
    case NoData
}


class SMRefreshTableHeaderView:SMView {
    var currentStyle:SMRefreshTableHeaderViewStyle = .Normal
    
    
    var lbPull:SMLabel = SMLabel()
    var lbTime:SMLabel = SMLabel()
    var vPull:SMView = SMView()
    var ivImage:SMImageView = SMImageView()
    var activity:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        self.backgroundColor = SMRGB(0xeeeeee)
        
        vPull = SMView()
        vPull.backgroundColor = UIColor.clear()
        self.addSubview(vPull)
    
        lbPull = SMLabel()
        lbPull.backgroundColor = UIColor.clear()
        lbPull.font = SMBFont(14)
        lbPull.textColor = SMRGB(0x666666)
        lbPull.textAlignment = .left
        vPull.addSubview(lbPull)
    
        lbTime = SMLabel()
        lbTime.font = SMFont(10)
        lbTime.textColor = SMRGB(0x9D9D9D)
        lbTime.backgroundColor = UIColor.clear()
        lbTime.textAlignment = .left
        vPull.addSubview(lbTime)
    
        ivImage = SMImageView()
        ivImage.contentMode = .scaleAspectFit
        ivImage.image = UIImage(named: "arrow_down")
        self.addSubview(ivImage)
    
        activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.hidesWhenStopped = true
        self.addSubview(activity)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        vPull.frame = CGRect(x: 0, y: self.height - 60, width: self.width, height: 60)
        
        var pullText = ""
        if lbPull.text != nil {
            pullText = lbPull.text!
        }
        let lbPullSize = pullText.smSize(font: lbPull.font, size: CGSize(width:vPull.width, height:vPull.height))
        lbPull.frame = CGRect(x: (self.width - lbPullSize.width)/2, y: 10, width: lbPullSize.width * 2, height: 20)
        
        var timeText = ""
        if lbPull.text != nil {
            timeText = lbTime.text!
        }
        let lbTimeSize = timeText.smSize(font: lbTime.font, size: CGSize(width: vPull.width, height: vPull.height))
        lbTime.frame = CGRect(x: lbPull.x, y: 30, width: lbTimeSize.width + 10, height: 20)
        ivImage.frame = CGRect(x: lbPull.x - 22 - 10, y: self.height - (60 - 22)/2 - 22, width: 22, height: 22)
        activity.frame = CGRect(x: lbPull.x - 22 - 10, y: self.height - (60 - 20)/2 - 20, width: 20, height: 20)
            }
    
    
    func update(style:SMRefreshTableHeaderViewStyle) {
        self.currentStyle = style
        
        var time = UserDefaults.standard.object(forKey: "LastRefreshDate") as? String
        if time != nil {
            lbTime.text = "未更新";
        }
        else {
            time = ""
            lbTime.text = "最近更新：\(time)"
        }
        
        switch style {
            case .Normal:
                self.dealImage(rotate:false, animated:true)
                self.dealActivity(isOn:false)
                self.lbPull.text = "下拉刷新"
            
            case .Release:
                self.dealImage(rotate: true, animated: true)
                self.dealActivity(isOn: false)
                self.lbPull.text = "松开刷新"
            
            case .Loading:
                self.dealImage(rotate: false, animated: true)
                self.dealActivity(isOn: true)
                self.lbPull.text = "加载中..."

        }
    }
    
    func startLoading(_ tableView:UITableView, animated:Bool) {
        if currentStyle != .Loading {
            update(style: .Loading)
            weak var weakTable = tableView
            if animated {
                UIView.animate(withDuration: 0.2, animations: {
                    weakTable?.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
                    }, completion: {
                        (finished: Bool) in
                        
                })
            }
            else {
                weakTable?.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
            }
        }
    }
    
    func finishLoading(_ tableView:UITableView, animated:Bool) {
        if currentStyle == .Loading {
            weak var weakTable = tableView
            weak var weakSelf = self
            if animated {
                UIView.animate(withDuration: 0.3, animations: {
                    weakTable?.contentInset = UIEdgeInsetsZero
                    }, completion: {
                        (finished: Bool) in
                        weakSelf?.viewFinishAnimation()
                })
            }
            else {
                weakTable?.contentInset = UIEdgeInsetsZero
                viewFinishAnimation()
            }
        }
    }
    
    func viewFinishAnimation() {
        update(style: .Normal)
        let formatter = DateFormatter()
        let date = Date()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let time = formatter.string(from: date)
        UserDefaults.standard.set(time, forKey: "LastRefreshDate")
        let dateStr = "最近更新\(time)"
        lbTime.text = dateStr
    }
    
    func dealImage(rotate:Bool, animated:Bool) {
        let previousFlip = ivImage.transform.isIdentity
        if rotate == previousFlip {
            return
        }
        if animated {
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.18)
        }
        if !rotate {
            ivImage.transform = CGAffineTransform.identity
        }
        else {
            ivImage.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
        }
        
        if animated {
            UIView.commitAnimations()
        }
    }
    
    func dealActivity(isOn:Bool) {
        ivImage.isHidden = isOn
        if isOn {
            activity.startAnimating()
        }
        else {
            activity.stopAnimating()
        }
    }
    
}

class SMRefreshTableFooterView:SMView {
    var currentStyle:SMRefreshTableFooterViewStyle = .Normal
    var lbTitle:SMLabel = SMLabel()
    var activity:UIActivityIndicatorView = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        lbTitle = SMLabel()
        lbTitle.font = SMBFont(14)
        lbTitle.textColor = SMRGB(0x9A9A9A)
        lbTitle.backgroundColor = UIColor.clear()
        lbTitle.textAlignment = .center
        lbTitle.autoresizingMask = .flexibleWidth
        self.addSubview(lbTitle)
        
        
        activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activity.hidesWhenStopped = true
        self.addSubview(activity)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var title = ""
        if lbTitle.text != nil {
            title = lbTitle.text!
        }
        
        let titleSize = title.smSize(font: lbTitle.font, size: CGSize(width: self.width, height: CGFloat(MAXFLOAT)))
        if self.currentStyle == .NoData {
            let x = (self.width - titleSize.width - 4) / 2
            activity.frame = CGRect.zero
            lbTitle.frame = CGRect(x: x, y: 20, width: titleSize.width + 4, height: 20)
        }
        else {
            var x = (self.width - lbTitle.width - 20 - 6) / 2
            activity.frame = CGRect(x: x, y: 20, width: 20, height: 20)
            x = x + 20 + 6
            lbTitle.frame = CGRect(x: x, y: 20, width: titleSize.width, height: 20)
        }
    }
    
    func update(style:SMRefreshTableFooterViewStyle) {
        self.currentStyle = style
        switch style {
            case .Normal:
                lbTitle.text = ""
                activity.stopAnimating()
                self.isHidden = true
                
            case .Release:
                lbTitle.text = "正在加载..."
                activity.stopAnimating()
                self.isHidden = false
            
            case .Loading:
                lbTitle.text = "正在加载..."
                activity.startAnimating()
                self.isHidden = false
        
            case .NoData:
                lbTitle.text = "已经到最后了"
                activity.stopAnimating()
                self.isHidden = false
            
        }
        self.setNeedsLayout()
    }
}

public class SMRefreshTableView: SMView, SMRefreshTableViewDelegate, SMRefreshTableViewDataSource {
    var tableView:UITableView = SMTableView()

    weak public var delegate: SMRefreshTableViewDelegate?
    weak public var dataSource: SMRefreshTableViewDataSource?
    
    var headerView: SMRefreshTableHeaderView?
    var footerView: SMRefreshTableFooterView?
    
    public var isRefreshing:Bool = false  //0: 正常 1：刷新中
    var isDraging:Bool = false  //0: 正常 1：拖拽中
    
    var lastOffsetY:CGFloat = 0.0
    
    
    
    public var needHeaderRefresh:Bool {
        get {
            return self.needHeaderRefresh
        }
        set {
            configTableHeader()
        }
    }
    
    public var needFooterRefresh:Bool {
        get {
            return self.needFooterRefresh
        }
        set {
            configTableFooter()
        }
    }
    
    
   
    
    
    override internal init(frame: CGRect) {
        super.init(frame: frame)
        
        configTable(style: .plain)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame)
        configTable(style: style)
    }
    
    
    func configTable(style: UITableViewStyle) -> Void {
        tableView = SMTableView(frame: CGRect.zero, style: style)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        self.addSubview(tableView)
    }
    
    
    func configTableHeader() {
        if headerView == nil {
            headerView = SMRefreshTableHeaderView()
            headerView?.update(style: .Normal)
            tableView.addSubview(headerView!)
        }
    }
    
    func configTableFooter() {
        if footerView == nil {
            footerView = SMRefreshTableFooterView()
            footerView?.update(style: .Normal)
            tableView.addSubview(footerView!)
        }
    }
    
    func showHeaderLoading() {
        tableView.reloadData()
        if (headerView != nil && headerView?.currentStyle != .Loading) {
            headerView?.startLoading(tableView, animated: true)
        }
    }
    
    func hideHeaderLoading() {
        tableView.reloadData()
        if (headerView != nil && headerView?.currentStyle != .Normal) {
            headerView?.finishLoading(tableView, animated: true)
        }
    }
    
    func reloadData() {
        tableView.reloadData()
        tableView.setNeedsLayout()
    }
    
    func reloadDataAndEnable() {
        enableTableFooter()
        enableTableHeader()
        tableView.reloadData()
    }
    
    func enableTableHeader() {
        if (headerView != nil && headerView?.currentStyle != .Normal) {
            hideHeaderLoading()
        }
        isRefreshing = false
    }
    
    func enableTableFooter() {
        if (footerView != nil && footerView?.currentStyle != .Normal) {
            footerView?.update(style: .Normal)
        }
        isRefreshing = false
    }
    
    func noDataFooter() {
        if footerView != nil {
            footerView?.update(style: .NoData)
        }
    }
    
    
    func drag() {
        if (isRefreshing || isDraging) {
            return
        }
        else {
            let offsetY = tableView.contentOffset.y
            if offsetY > lastOffsetY {
                let cOffset = tableView.contentOffset
                let cSize = tableView.contentSize
                let draggedDistance = tableView.height - cSize.height + cOffset.y
                if draggedDistance > 0  {
                    if footerView != nil && footerView?.currentStyle != .Normal {
                        footerView?.update(style: .Release)
                    }
                }
                else if draggedDistance > -80 {
                    if footerView != nil && footerView?.currentStyle != .Normal {
                        footerView?.update(style: .Loading)
                        if delegate != nil {
                            let k = delegate!
                            if k.responds(to: #selector(SMRefreshTableViewDelegate.tableFooterRefresh(_:))) {
                                isRefreshing = true
                                k.tableFooterRefresh!(self)
                            }
                        }
                    }
                }
            }
            else if offsetY < lastOffsetY {
                if offsetY <= -65 {
                    if headerView != nil && headerView?.currentStyle != .Normal {
                        headerView?.update(style: .Release)
                    }
                }
            }
        }
    }
    
    
    
    func dragEnd() {
        if isRefreshing {
            return
        }
        
        if (headerView != nil && headerView?.currentStyle == .Loading) || (footerView != nil && footerView?.currentStyle == .Loading) {
            return
        }
        
        if headerView != nil && headerView?.currentStyle == .Release {
            headerBeginRefresh()
        }
        
        if footerView != nil && footerView?.currentStyle == .Release {
            footerBeginRefresh()
        }
    }
    
    func headerBeginRefresh() {
        headerView?.startLoading(tableView, animated: true)
        if delegate != nil {
            let k = delegate!
            if k.responds(to: #selector(SMRefreshTableViewDelegate.tableHeaderRefresh(_:))) {
                isRefreshing = true
                delegate?.tableHeaderRefresh!(self)
            }
        }
    }
    
    func footerBeginRefresh() {
        if delegate != nil {
            let k = delegate!
            if k.responds(to: #selector(SMRefreshTableViewDelegate.tableFooterRefresh(_:))) {
                footerView?.update(style: .Loading)
                isRefreshing = true
                delegate?.tableFooterRefresh!(self)
            }
        }
    }
    
    func disableTableHeader() {
        if headerView != nil {
            headerView?.removeFromSuperview()
            headerView = nil
        }
    }
    
    func disableTableFooter() {
        if footerView != nil {
            footerView?.removeFromSuperview()
            footerView = nil
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        tableView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        headerView?.frame = CGRect(x: 0, y: -self.height, width: self.width, height: self.height)
        footerView?.frame = CGRect(x: 0, y: tableView.contentSize.height, width: self.width, height: 60)
    }
    
//MARK: ******************  UIScrollViewDelegate  ******************
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let k = delegate {
            if k.responds(to: #selector(UIScrollViewDelegate.scrollViewDidScroll(_:))) {
                k.scrollViewDidScroll!(scrollView)
            }
        }
        drag()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView {
            if let k = delegate {
                if k.responds(to: #selector(UIScrollViewDelegate.scrollViewDidEndDragging(_:willDecelerate:))) {
                    k.scrollViewDidEndDragging!(scrollView, willDecelerate: decelerate)
                }
            }
            isDraging = true
            dragEnd()
        }
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            if let k = delegate {
                if k.responds(to: #selector(UIScrollViewDelegate.scrollViewDidZoom(_:))) {
                    k.scrollViewDidZoom!(scrollView)
                }
            }
        }
    }
    
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isDraging = false
        lastOffsetY = scrollView.contentOffset.y
        if scrollView == tableView {
            if let k = delegate {
                if k.responds(to: #selector(UIScrollViewDelegate.scrollViewWillBeginDragging(_:))) {
                    k.scrollViewWillBeginDragging!(scrollView)
                }
            }
        }
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == tableView {
            if let k = delegate {
                if k.responds(to: #selector(UIScrollViewDelegate.scrollViewWillEndDragging(_:withVelocity:targetContentOffset:))) {
                    k.scrollViewWillEndDragging!(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
                }
            }
        }
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            if let k = delegate {
                if k.responds(to: #selector(UIScrollViewDelegate.scrollViewWillBeginDecelerating(_:))) {
                    k.scrollViewWillBeginDecelerating!(scrollView)
                }
            }
        }
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            if let k = delegate {
                if k.responds(to: #selector(UIScrollViewDelegate.scrollViewDidEndDecelerating(_:))) {
                    k.scrollViewDidEndDecelerating!(scrollView)
                }
            }
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            if let k = delegate {
                if k.responds(to: #selector(UIScrollViewDelegate.scrollViewDidEndScrollingAnimation(_:))) {
                    k.scrollViewDidEndScrollingAnimation!(scrollView)
                }
            }
        }
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if let k = delegate {
            if k.responds(to: #selector(UIScrollViewDelegate.viewForZooming(in:))) {
                return k.viewForZooming!(in: scrollView)
            }
        }
        return nil
    }
    
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        if let k = delegate {
            if k.responds(to: #selector(UIScrollViewDelegate.scrollViewWillBeginZooming(_:with:))) {
                k.scrollViewWillBeginZooming!(scrollView,with:view)
            }
        }
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if let k = delegate {
            if k.responds(to: #selector(UIScrollViewDelegate.scrollViewDidEndZooming(_:with:atScale:))) {
                k.scrollViewDidEndZooming!(scrollView,with:view,atScale:scale)
            }
        }
    }
    
    public func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        if let k = delegate {
            if k.responds(to: #selector(UIScrollViewDelegate.scrollViewDidScrollToTop(_:))) {
                k.scrollViewDidScrollToTop!(scrollView)
            }
        }
    }
    
//MARK: ******************  UITableViewDataSource  ******************
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.tableView(_:numberOfRowsInSection:))) {
                return k.tableView(tableView, numberOfRowsInSection: section)
            }
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.tableView(_:cellForRowAt:))) {
                cell = k.tableView(tableView, cellForRowAt: indexPath)
                if cell != nil {
                    return cell!
                }
            }
        }
 
        let cellID = "SMRefreshTableViewCellID"
        cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        return cell!
        
    }
 
    public func numberOfSections(in tableView: UITableView) -> Int {
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) {
                return k.numberOfSections!(in: tableView)
            }
        }
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.tableView(_:titleForHeaderInSection:))) {
                return k.tableView!(tableView, titleForHeaderInSection:section)
            }
        }
        return ""
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.tableView(_:titleForFooterInSection:))) {
                return k.tableView!(tableView, titleForFooterInSection:section)
            }
        }
        return ""
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.tableView(_:canEditRowAt:))) {
                return k.tableView!(tableView, canEditRowAt: indexPath)
            }
        }
        return false
    }
    
    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.tableView(_:canMoveRowAt:))) {
                return k.tableView!(tableView, canMoveRowAt: indexPath)
            }
        }
        return false
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.sectionIndexTitles(for:))) {
                return k.sectionIndexTitles!(for: tableView)
            }
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.tableView(_:sectionForSectionIndexTitle:at:))) {
                return k.tableView!(tableView, sectionForSectionIndexTitle: title, at: index)
            }
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.tableView(_:commit:forRowAt:))) {
                k.tableView!(tableView, commit: editingStyle, forRowAt: indexPath)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if let k = dataSource {
            if k.responds(to: #selector(UITableViewDataSource.tableView(_:moveRowAt:to:))) {
                k.tableView!(tableView, moveRowAt: sourceIndexPath, to: destinationIndexPath)
            }
        }
    }
    
//MARK: ******************  UITableViewDelegate  ******************
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:willDisplay:forRowAt:))) {
                k.tableView!(tableView, willDisplay: cell, forRowAt: indexPath)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:willDisplayHeaderView:forSection:))) {
                k.tableView!(tableView, willDisplayHeaderView: view, forSection: section)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:willDisplayFooterView:forSection:))) {
                k.tableView!(tableView, willDisplayFooterView: view, forSection: section)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:heightForRowAt:))) {
                return k.tableView!(tableView, heightForRowAt: indexPath)
            }
        }
        
        return 44
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:heightForHeaderInSection:))) {
                return k.tableView!(tableView, heightForHeaderInSection: section)
            }
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:heightForFooterInSection:))) {
                return k.tableView!(tableView, heightForFooterInSection: section)
            }
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:viewForHeaderInSection:))) {
                return k.tableView!(tableView, viewForHeaderInSection: section)
            }
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:viewForFooterInSection:))) {
                return k.tableView!(tableView, viewForFooterInSection: section)
            }
        }
        return nil
    }
    
    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:accessoryButtonTappedForRowWith:))) {
                return k.tableView!(tableView, accessoryButtonTappedForRowWith: indexPath)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:willSelectRowAt:))) {
                return k.tableView!(tableView, willSelectRowAt: indexPath)
            }
        }
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath? {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:willDeselectRowAt:))) {
                return k.tableView!(tableView, willDeselectRowAt: indexPath)
            }
        }
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))) {
                k.tableView!(tableView, didSelectRowAt: indexPath)
            }
        }

    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:didDeselectRowAt:))) {
                k.tableView!(tableView, didDeselectRowAt: indexPath)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:editingStyleForRowAt:))) {
                return k.tableView!(tableView, editingStyleForRowAt: indexPath)
            }
        }
        return .none
    }
    
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:titleForDeleteConfirmationButtonForRowAt:))) {
                return k.tableView!(tableView, titleForDeleteConfirmationButtonForRowAt: indexPath)
            }
        }
        return ""
    }
    
    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:shouldIndentWhileEditingRowAt:))) {
                return k.tableView!(tableView, shouldIndentWhileEditingRowAt: indexPath)
            }
        }
        return true
    }
    
    public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:willBeginEditingRowAt:))) {
                k.tableView!(tableView, willBeginEditingRowAt: indexPath)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:didEndDisplaying:forRowAt:))) {
                k.tableView!(tableView, didEndDisplaying: cell, forRowAt: indexPath)
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:targetIndexPathForMoveFromRowAt:toProposedIndexPath:))) {
                return k.tableView!(tableView, targetIndexPathForMoveFromRowAt: sourceIndexPath, toProposedIndexPath: proposedDestinationIndexPath)
            }
        }
        return IndexPath()
    }
    
    public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:indentationLevelForRowAt:))) {
                return k.tableView!(tableView, indentationLevelForRowAt: indexPath)
            }
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:shouldShowMenuForRowAt:))) {
                return k.tableView!(tableView, shouldShowMenuForRowAt: indexPath)
            }
        }
        return true
    }
    
    public func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: AnyObject?) -> Bool {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:canPerformAction:forRowAt:withSender:))) {
                return k.tableView!(tableView, canPerformAction: action, forRowAt:indexPath, withSender:sender)
            }
        }
        return false;
    }
    
    public func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: AnyObject?) {
        if let k = delegate {
            if k.responds(to: #selector(UITableViewDelegate.tableView(_:performAction:forRowAt:withSender:))) {
                k.tableView!(tableView, performAction: action, forRowAt:indexPath, withSender:sender)
            }
        }
    }
}
