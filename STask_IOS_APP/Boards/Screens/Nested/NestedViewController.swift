////
////  NestedViewController.swift
////  ImageSlider
////
////  Created by A on 4/5/20.
////  Copyright © 2020 Eslam Shaker . All rights reserved.
////
//import UIKit
//import SwiftyJSON
//import Alamofire
//import MaterialActivityIndicator
//import YNExpandableCell
//import LUExpandableTableView
//import RestEssentials
//import WJXOverlappedImagesView
//import Kingfisher
//import SDWebImage
//import LetterAvatarKit
//
//@available(iOS 13.0, *)
//class NestedViewController: UIViewController {
//    let cellIdLetterAvatar = "CellLetterAvatar"
//    var shortNames: [String] = []
//    var team: Team? = nil
//    var  groups : [TasksGroup] = []
//    var tasksDic: [Int: [TaskH]] = [:]
//    var boardId: String = ""
//    var base : NestedBoardH?
//    var users: [UserHere] = []
//    fileprivate let tasks: [TaskH] = []
//    private var indicator = MaterialActivityIndicatorView()
//    @IBOutlet weak var collectionLetrreAvatars: UICollectionView!
//    @IBOutlet weak var overlappedImagesView: WJXOverlappedImagesView!
//    var images: [String] = []
//
//
//
//    //private let expandableTableView = LUExpandableTableView()
//    @IBOutlet weak var expandableTableView: LUExpandableTableView!
//
//
//    private let cellReuseIdentifier = "GroupTaskCell"
//    private let sectionHeaderReuseIdentifier = "GroupSectionHeader"
//    private lazy var imageUrls =  [
//        "https://avatars1.githubusercontent.com/u/4176744?v=40&s=132",
//        "https://avatars1.githubusercontent.com/u/565251?v=3&s=132",
//        "https://avatars2.githubusercontent.com/u/587874?v=3&s=132",
//        "https://avatars2.githubusercontent.com/u/1019875?v=4&s=132",
//        "https://avatars2.githubusercontent.com/u/839283?v=4&s=132",
//        "https://avatars0.githubusercontent.com/u/724423?v=3&s=132",
//        "https://avatars3.githubusercontent.com/u/602569?v=4&s=132",
//        "https://avatars1.githubusercontent.com/u/8086633?v=3&s=132",
//    ]
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.setupExpandableTableView()
//
//
//
//
//
//        print("Nested VC \(self.boardId)")
//        getNested()
//
//        //setting an empty array firstlty
//        accessOverlappingImagesView(overlappedImagesView: self.overlappedImagesView, images: self.images)
//
//
//        initCollectionLetterAvatars(sectionHeader: nil)
//        print(" kkee \(self.shortNames.count)")
//
//    }
//
//    func initCollectionLetterAvatars(sectionHeader: GroupSectionHeader?){
//
//
//        //if you use xibs:
//        self.collectionLetrreAvatars.register(UINib(nibName: "CellLetterAvatar", bundle: .main), forCellWithReuseIdentifier: self.cellIdLetterAvatar)
//        //or if you use class:
//        //         sectionHeader?.collectionLetrreAvatars.register(CellLetterAvatar.self, forCellWithReuseIdentifier: cellIdentifier)
//
//
//        self.collectionLetrreAvatars.delegate = self
//        self.collectionLetrreAvatars.dataSource = self
//
//
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        //        expandableTableView.frame = view.bounds
//        //    expandableTableView.frame.origin.y += 20
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        indicator.stopAnimating()
//    }
//
//    func setupExpandableTableView(){
//        //        view.addSubview(expandableTableView)
//
////        self.expandableTableView.register(GroupTaskCell.self, forCellReuseIdentifier: cellReuseIdentifier)
//
//        self.expandableTableView.register(UINib(nibName: cellReuseIdentifier, bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
//
//        self.expandableTableView.register(UINib(nibName: sectionHeaderReuseIdentifier, bundle: .main), forHeaderFooterViewReuseIdentifier: sectionHeaderReuseIdentifier)
//
//        expandableTableView.expandableTableViewDataSource = self
//        expandableTableView.expandableTableViewDelegate = self
//    }
//
//    func getNested(){
//        //self.view.makeToastActivity(.center)
//        //indicator.startAnimating()
//        self.showLoading()
//
//        let headers: HTTPHeaders = [
//            //.accept("application/json"),
//            .authorization(bearerToken: (Utils.fetchSavedUser()?.data.token)!)
//
//        ]
//        let id = "?id=\(self.boardId)"
//        let url = Constants.BASE_URL + Constants.Ends.END_POINT_NESTED + id
//        debugPrint(url)
//        AF.request(url,method: .get,
//                   //encoding: JSONEncoding.default,
//            headers: headers)
//            .response { response in
//                //.responseJSON { response in
//                //debugPrint("resp \(response)")
//                switch response.result {
//                case .success(let data):
//                    debugPrint( "Success: \(response.value)")
//                    self.stopLoading()
//
//                    let swiftyData = JSON(response.value as Any)
//                    let successful = swiftyData["successful"].intValue
//                    //debugPrint("state \(successful)")
//                    if successful == 1{
//                        let message = swiftyData["message"].stringValue
//                        //debugPrint(message)
//                        guard let data = response.data else { return }
//                        do {
//                            let decoder = JSONDecoder()
//                            let boardData = try decoder.decode(Nested.self, from: data)
//
//                            //fetching nested board
//                            self.base = boardData.data.BoardData.nestedBoard[0]
//
//                            self.accessFields()
//
//                        } catch let error {
//                            print(error)
//                        }
//
//
//                    }else{
//                        let errorMessage: String =  swiftyData["errorMessages"][0].stringValue
//                        debugPrint("error \(errorMessage)")
//                        UtilsAlert.showError(message: errorMessage)
//                    }
//
//                case .failure(let error):
//                    debugPrint( "Failure: \(error.localizedDescription)")
//                    self.stopLoading()
//                    UtilsAlert.showError(message: "Network connection error")
//
//                }
//
//
//        }
//
//    }
//
//    func accessFields(){
//
//        //settting the title
//        self.title = base?.name
//        //self.view.makeToast(base?.name)
//
//        //groups
//        self.groups  = self.base!.tasksGroup
//
//        //fetching tasks
//        for n in 0...self.groups.count - 1 {
//            let tasks = self.groups[n].tasks
//            self.tasksDic[n] = tasks
//        }
//
//        //users
//        self.users = self.base!.users
//        //print("Gogo \(self.users.count)")
//
//        ///team
//        self.team = self.base?.team
//
//        //set the user imags paths/letters
//        self.fillUserImages()
//
//        //refresh
//        self.expandableTableView.reloadData()
//        self.collectionLetrreAvatars.reloadData()
//    }
//
//    func fillUserImages(){
//        print("Gogo \(self.users.count)")
//        for n in 0..<self.users.count {
//            let user = users[n]
//            let image = user.userImage
//            let shortName = user.shortName
//            if image.starts(with: "http://") || image.starts(with: "https://") {
//                images.append(image)
//                print("Gogo \(image)")
//            }else{
//                self.shortNames.append(shortName)
//                print(shortName)
//            }
//        }
//
//        if images.isEmpty {
//            //sol1 temp array
//            //images = self.imageUrls
//            //sol2 letter avatar
//            self.collectionLetrreAvatars.isHidden = false
//            self.overlappedImagesView.isHidden = true
//
//            print(" isEmpty kkee \(self.shortNames.count)")
//            self.collectionLetrreAvatars.reloadData()
//
//        }else{
//            self.collectionLetrreAvatars.isHidden = true
//            self.overlappedImagesView.isHidden = false
//            accessOverlappingImagesView(overlappedImagesView: self.overlappedImagesView, images: self.images)
//        }
//
//
//
//    }
//
//
//    func stopLoading(){
//        //self.indicator.stopAnimating()
//        self.view.hideToastActivity()
//    }
//
//    func showLoading(){
//        self.view.makeToastActivity(.center)
//        //        indicator.startAnimating()
//    }
//
//}
//
//@available(iOS 13.0, *)
//extension NestedViewController: DelegateAttachGroupSection{
//
//    func onGroupSecAttachClicked() {
//        self.view.makeToast("Attach cleicked")
//        print("Attch clicked")
//
//    }
//
//}
//
//@available(iOS 13.0, *)
//extension NestedViewController: LUExpandableTableViewDataSource {
//
//    func fillTaskCell(cell: GroupTaskCell?,  indexPath: IndexPath){
//        //        let text = "Cell at row \(indexPath.row) section \(indexPath.section)";
//        let task: [TaskH] = self.tasksDic[indexPath.section]!
//        let taskName = task[indexPath.row].name
//        //print("Gogo \(taskName)")
//
//
//
//
//    }
//
//    func accessOverlappingImagesView(overlappedImagesView: WJXOverlappedImagesView?, images: [String]?){
//        //let overlappedImagesView: WJXOverlappedImagesView?
//        //= cell?.overlappedImagesView
//        overlappedImagesView?.imageFetcher = { imagesView, imageView, url, index in
//            // fetch image via YYWebImage
//            //            imageView.yy_setImage(with: URL(string: url)!, placeholder: UIImage(named: "demo-avatar"))
//
//            // fetch image via Kingfisher
//            //            imageView.kf.setImage(with: URL(string: url), placeholder: UIImage(named: "demo-avatar"))
//
//            // fetch image via SDWebImage
//            imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "demo-avatar"))
//        }
//        overlappedImagesView?.imageFetchCanceler = { imagesView, imageView, index in
//            //            imageView.yy_cancelCurrentImageRequest()
//            //            imageView.kf.cancelDownloadTask()
//            imageView.sd_cancelCurrentImageLoad()
//        }
//        overlappedImagesView?.updateInTransaction { imagesView in
//            imagesView.imageBorderWidth = 4
//            imagesView.imageBorderColor = UIColor.white
//            imagesView.imageHeight = 60
//            imagesView.overlapDistance = 16
//            imagesView.shouldShowMoreIndicatorImageViewWhenImageCountExceedsMaxLimit = true
//            imagesView.maxLimit = 4
//            //imagesView.imageUrls = self.imageUrls
//            imagesView.imageUrls = images
//
//        }
//
//    }
//
//    func numberOfSections(in expandableTableView: LUExpandableTableView) -> Int {
//        //return 3
//        return self.groups.count
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, numberOfRowsInSection section: Int) -> Int {
//        //return 3
//        return self.tasksDic[section]!.count
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = expandableTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? GroupTaskCell else {
//            assertionFailure("Cell shouldn't be nil")
//            return UITableViewCell()
//        }
//
//        fillTaskCell( cell: cell, indexPath: indexPath)
//
//        return cell
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, sectionHeaderOfSection section: Int) -> LUExpandableTableViewSectionHeader {
//        guard let sectionHeader = expandableTableView.dequeueReusableHeaderFooterView(withIdentifier: sectionHeaderReuseIdentifier) as? GroupSectionHeader else {
//            assertionFailure("Section header shouldn't be nil")
//            return LUExpandableTableViewSectionHeader()
//        }
//
//
//        let group = self.groups[section]
//        sectionHeader.label.text = group.name
//
//
//        //---------------------
//        //access team name
//        let teamName = self.team?.teamName
//        sectionHeader.labelTeamName.text = teamName
//        //print("teamName = \(teamName)")
//
//        //accessing the attach button
//        //conform protocol
//        sectionHeader.delegateAttach = self;
//
//
//
//        return sectionHeader
//    }
//
//    
//
//
//}
//
//
//@available(iOS 13.0, *)
//extension NestedViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1;
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width/5, height: collectionView.frame.width/2)
//    }
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.shortNames.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdLetterAvatar, for: indexPath) as! CellLetterAvatar
//
//        let shortName =  self.shortNames[indexPath.row]
//        print("soso = \(shortName)")
//
//        // Circle avatar image with white border
//        let circleAvatarImage = LetterAvatarMaker()
//            .setCircle(true)
//            .setUsername(shortName)
//            .setBorderWidth(1.0)
//            .setBackgroundColors([ .red ])
//            .build()
//
//        cell.imageView.image = circleAvatarImage;
//
//
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//}
//
//
//// MARK: - LUExpandableTableViewDelegate
//
//@available(iOS 13.0, *)
//extension NestedViewController: LUExpandableTableViewDelegate {
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
//        return 70
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, heightForHeaderInSection section: Int) -> CGFloat {
//        /// Returning `UITableViewAutomaticDimension` value on iOS 9 will cause reloading all cells due to an iOS 9 bug with automatic dimensions
//        return 170
//    }
//
//    // MARK: - Optional
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectRowAt indexPath: IndexPath) {
//        //print("Did select cell at section \(indexPath.section) row \(indexPath.row)")
//        //        let boardData = self.nestedBoard[indexPath.section]
//        //        let id  = boardData![indexPath.row].id
//        //        print(id)
//
//
//
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, didSelectSectionHeader sectionHeader: LUExpandableTableViewSectionHeader, atSection section: Int) {
//        print("Did select section header at section \(section)")
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print("Will display cell at section \(indexPath.section) row \(indexPath.row)")
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, willDisplaySectionHeader sectionHeader: LUExpandableTableViewSectionHeader, forSection section: Int) {
//        print("Will display section header for section \(section)")
//    }
//
//    func expandableTableView(_ expandableTableView: LUExpandableTableView, viewForFooterInSection section: Int) -> UIView? {
//        return nil
//    }
//
//    func expandableTableView(_ expandableTableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 5
//    }
//
//
//}
