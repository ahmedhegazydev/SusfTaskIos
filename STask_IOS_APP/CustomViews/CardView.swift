////
////  CardView.swift
////  buenobonitoybarato
////
////  Created by santhosh ramaiah on 1/31/17.
////  Copyright © 2017 santhosh ramaiah. All rights reserved.
////
//
//import Foundation
//import SnapKit
//import UIKit
//
//class CardView: UIView {
//    var totalHeight: CGFloat = 0
//    var totalWidth: CGFloat = 0
//    var stackView: UIStackView
//
//    init(width: CGFloat){
//        totalWidth = width
//        stackView = UIStackView()
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.axis = .vertical
//        stackView.distribution  = UIStackView.Distribution.equalSpacing
//        stackView.alignment     = UIStackView.Alignment.center
//        stackView.spacing       = 8
//        stackView.layer.shadowOpacity = 0.0;
//
//        super.init(frame: CGRect(x: 0, y:  0, width: width, height: 0))
//        super.addSubview(stackView)
//
//        stackView.snp.makeConstraints { (make) -> Void in
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.right.equalToSuperview()
//            make.left.equalToSuperview()
//        }
//
//    }
//
//    required init?(coder: NSCoder) {
//        //fatalError("init(coder:) has not been implemented")
//    }
//
//    public func getStackView() -> UIStackView {
//        return stackView
//    }
//
//
//
//    public func addArrangedSubview(_ view: UIView) {
//        stackView.addArrangedSubview(view)
//        totalHeight += view.frame.size.height
//        totalHeight += 8
//    }
//
//    public func removeAll() {
//
//        for view in subviews {
//            view.removeFromSuperview()
//        }
//        totalHeight = 0
//    }
//
//    public func prepareBlankView(height: CGFloat){
//        let blankView = UIView(frame: CGRect(x: 0, y:  0, width: totalWidth - 40, height: height))
//        blankView.heightAnchor.constraint(equalToConstant: height).isActive = true
//        self.addArrangedSubview(blankView)
//    }
//
//    public func showCardShadow(){
//        self.backgroundColor = UIColor.white
//        //self.frame = CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight - 8)
//        self.layer.masksToBounds = false
//        self.layer.shadowOffset = CGSize(width: 0, height: 0.0);
//        self.layer.cornerRadius = 0;
//        self.layer.shadowRadius = 2;
//        self.layer.shadowOpacity = 0.5;
//        //self.layer.shouldRasterize = true
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
//    }
//
//
//
//    override func layoutSubviews() {
//        showCardShadow()
//        super.layoutSubviews()
//    }
//
//
//}
