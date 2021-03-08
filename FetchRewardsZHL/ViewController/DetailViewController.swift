//
//  DetailViewController.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/6/21.
//

import UIKit

class DetailViewController: UIViewController {
  private var wrapperView: UIView!
  private var backButton: UIButton!
  private var titleLabel: UILabel!
  private var hearButton: UIButton!
  private var barView: UIView!
  private var imageview: UIImageView!
  private var timeLabel: UILabel!
  private var locationLabel: UILabel!
  var event: EventModel?
  
  
  override func viewDidLoad() {
    setupTitleWrapperView()
    setupTitleLabel()
    setupBackButton()
    setupHeartButton()
    setupLineView()
    setupImageView()
    setupTimeLabel()
    setupLocationLabel()
    setupEvent()
  }

  private func setupEvent() {
    guard event != nil else {
      return
    }
    titleLabel.text = event!.title
    if (event!.isLiked) {
      hearButton.setImage(UIImage(named: "blogHeartIcon"), for: .normal)
    } else {
      hearButton.setImage(UIImage(named: "heart"), for: .normal)
    }
    backButton.setImage(UIImage(named: "searchFormBackButton"), for: .normal)
    
    let url = URL(string: event!.imageURL)
    DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
          self.imageview.image = UIImage(data: data!)
        }
    }
    timeLabel.text = DateFormat.convertUTCTime(dateString: event!.time)
    locationLabel.text = event!.location
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    // make textviews fit to its content size
    let sizeThatFitsTextView = self.titleLabel.sizeThatFits(CGSize(width: self.titleLabel.frame.size.width, height: CGFloat(MAXFLOAT)))
    self.wrapperView.snp.updateConstraints { (make) in
      make.height.equalTo(sizeThatFitsTextView.height + 20)
    }
    self.titleLabel.snp.updateConstraints { (make) in
      make.height.equalTo(sizeThatFitsTextView.height )
    }
    let sizeThatFitsTextView2 = self.timeLabel.sizeThatFits(CGSize(width: self.timeLabel.frame.size.width, height: CGFloat(MAXFLOAT)))
    let sizeThatFitsTextView3 = self.locationLabel.sizeThatFits(CGSize(width: self.locationLabel.frame.size.width, height: CGFloat(MAXFLOAT)))
    self.timeLabel.snp.updateConstraints { (make) in
      make.height.equalTo(sizeThatFitsTextView2.height)
    }
    self.locationLabel.snp.updateConstraints { (make) in
      make.height.equalTo(sizeThatFitsTextView3.height )
    }
    imageview.layer.cornerRadius = CGFloat(DetailViewControllerConstant.shared.imageCornorRadius)
  }
  
  @objc func backTap(_ sender: UITapGestureRecognizer? = nil) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc func likeTap(_ sender: UITapGestureRecognizer? = nil) {
    guard event != nil else {
      return
    }
    event!.isLiked = !event!.isLiked
    if (event!.isLiked) {
      hearButton.setImage(UIImage(named: "blogHeartIcon"), for: .normal)
      CoreDataManager.shared.saveLikedEvent(id: event!.id)
      
    } else {
      hearButton.setImage(UIImage(named: "heart"), for: .normal)
      CoreDataManager.shared.deleteLikedEvent(id: event!.id)
     
    }
   
  }
  
}



extension DetailViewController {
  
  private func setupTitleWrapperView() {
    wrapperView = UIView()
    self.view.addSubview(wrapperView)
    wrapperView.snp.makeConstraints { (make) in
      make.width.equalTo(self.view.snp.width).multipliedBy(DetailViewControllerConstant.shared.widthRatio)
      make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
      make.centerX.equalTo(self.view.snp.centerX)
      make.height.equalTo(100)
    }
  }
  
  private func setupTitleLabel() {
    titleLabel = UILabel()
    titleLabel.numberOfLines = 0
    titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: DetailViewControllerConstant.shared.titleFontSize)
    self.wrapperView.addSubview(titleLabel)
    titleLabel.snp.makeConstraints { (make) in
      make.width.equalTo(self.wrapperView.snp.width).multipliedBy(DetailViewControllerConstant.shared.titleWidthRatio)
      make.top.equalTo(self.wrapperView.snp.top)
      make.centerX.equalTo(self.view.snp.centerX)
      make.height.equalTo(2)
    }
  }
  
  private func setupBackButton() {
    backButton = UIButton()
    backButton.contentHorizontalAlignment = .fill
    backButton.contentVerticalAlignment = .fill
    backButton.imageView?.contentMode = .scaleAspectFit
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.backTap(_:)))
    backButton.addGestureRecognizer(tap)
    self.wrapperView.addSubview(backButton)
    backButton.snp.makeConstraints { (make) in
      make.width.equalTo(self.wrapperView.snp.width).multipliedBy(DetailViewControllerConstant.shared.backButtonRatio)
      make.top.equalTo(self.wrapperView.snp.top)
      make.left.equalTo(self.wrapperView.snp.left)
      make.height.equalTo(self.backButton.snp.width)
    }
  }
  
  
  private func setupHeartButton() {
    hearButton = UIButton()
    self.hearButton.accessibilityIdentifier = "heart-button"
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.likeTap(_:)))
    hearButton.addGestureRecognizer(tap)
    hearButton.contentHorizontalAlignment = .fill
    hearButton.contentVerticalAlignment = .fill
    self.wrapperView.addSubview(hearButton)
    hearButton.snp.makeConstraints { (make) in
      make.width.equalTo(self.wrapperView.snp.width).multipliedBy(DetailViewControllerConstant.shared.backButtonRatio)
      make.top.equalTo(self.wrapperView.snp.top)
      make.right.equalTo(self.wrapperView.snp.right)
      make.height.equalTo(self.backButton.snp.width)
    }
  }

  private func setupLineView() {
    barView = UIView()
    barView.backgroundColor = .black
    self.view.addSubview(barView)
    barView.snp.makeConstraints { (make) in
      make.width.equalTo(self.view.snp.width).multipliedBy(DetailViewControllerConstant.shared.widthRatio)
      make.top.equalTo(self.wrapperView.snp.bottom)
      make.centerX.equalTo(self.view.snp.centerX)
      make.height.equalTo(DetailViewControllerConstant.shared.barHeightConstraint)
    }
  }
  
  private func setupImageView() {
    imageview = UIImageView()
    imageview.image = UIImage(named: "heart")
    self.view.addSubview(imageview)
    imageview.layer.masksToBounds = true
    imageview.contentMode = .scaleToFill
    imageview.snp.makeConstraints { (make) in
      make.width.equalTo(self.view.snp.width).multipliedBy(DetailViewControllerConstant.shared.widthRatio)
      make.top.equalTo(self.barView.snp.bottom).offset(DetailViewControllerConstant.shared.imageTopSpacing)
      make.centerX.equalTo(self.view.snp.centerX)
      make.height.equalTo(self.view.snp.height).multipliedBy(DetailViewControllerConstant.shared.imageHeightRatio)
    }
  }
  
  
  private func setupTimeLabel() {
    timeLabel = UILabel()
    self.view.addSubview(timeLabel)
    timeLabel.font = UIFont(name:"HelveticaNeue-Bold", size: DetailViewControllerConstant.shared.timeFontSize)
    timeLabel.snp.makeConstraints { (make) in
      make.width.equalTo(self.view.snp.width).multipliedBy(DetailViewControllerConstant.shared.widthRatio)
      make.top.equalTo(self.imageview.snp.bottom).offset(DetailViewControllerConstant.shared.titleTopSpacing)
      make.left.equalTo(self.imageview.snp.left)
      make.height.equalTo(DetailViewControllerConstant.shared.barHeightConstraint)
    }
  }
  
  private func setupLocationLabel() {
    locationLabel = UILabel()
    self.view.addSubview(locationLabel)
    locationLabel.font =  .systemFont(ofSize: DetailViewControllerConstant.shared.locationFontSize)
    locationLabel.snp.makeConstraints { (make) in
      make.width.equalTo(self.view.snp.width).multipliedBy(DetailViewControllerConstant.shared.widthRatio)
      make.top.equalTo(self.timeLabel.snp.bottom).offset(DetailViewControllerConstant.shared.titleTopSpacing)
      make.left.equalTo(self.imageview.snp.left)
      make.height.equalTo(DetailViewControllerConstant.shared.barHeightConstraint)
    }
  }
  
}


extension DetailViewController {
  private struct DetailViewControllerConstant {
    static let shared = DetailViewControllerConstant()
    
    //width
    let widthRatio: CGFloat = 0.9
    //image
    let imageWidthRatio: CGFloat = 0.3
    let imageHeightRatio: CGFloat = 0.32
    let imageCornorRadius:CFloat = 12
    let imageTopSpacing: CGFloat = 30
    
    //back button ratio
    let backButtonRatio: CGFloat = 0.07
    
    //heart button ratio
    let heartButtonRatio: CFloat = 0.06
    
    //title font
    let titleFontSize: CGFloat = 24
    let titleWidthRatio: CGFloat = 0.74
    let titleTopSpacing: CGFloat = 17
    
    //bar
    let barHeightConstraint: CGFloat = 1
    //location
    let locationFontSize: CGFloat = 16
    
    //time
    let timeFontSize: CGFloat = 21
    
  }
}
