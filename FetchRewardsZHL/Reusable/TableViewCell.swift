//
//  TableViewCell.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/5/21.
//

import UIKit
import SnapKit


class TableViewCell: UITableViewCell {
  private var topImageSpacing: UILayoutGuide!
  private var leftImageSpacing: UILayoutGuide!
  private var imageview: UIImageView!
  private var rightImageSpacing: UILayoutGuide!
  private var bottomTextSpacing: UILayoutGuide!
  private var titleTextLabel: UILabel!
  private var locationTextLabel: UILabel!
  private var timeTextLabel: UILabel!
  private var likeImageView: UIImageView!


  override init(style: UITableViewCell.CellStyle, reuseIdentifier reusreuseIdentifiereIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reusreuseIdentifiereIdentifier)
      setupTopImageSpacing()
      setupLeftImageSpacing()
      setupImageView()
      setupRightImageSpacing()
      setupTitleLabel()
      setupLocationTextLabel()
      setupTimeTextLabel()
      setupBottomTextSpacing()
      setupLikeImageView()

    }
    
    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
  public func setupCell(imageURL: String, title: String, location: String, time: String, isLiked: Bool) {
    let url = URL(string: imageURL)
    DispatchQueue.global().async {
        let data = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
          self.imageview.image = UIImage(data: data!)
        }
    }
    
    titleTextLabel.text = title
    locationTextLabel.text = location
    timeTextLabel.text = time
    if (isLiked) {
      likeImageView.image = UIImage(named: "blogHeartIcon")
    }
    
  }
  
  private func setupTopImageSpacing() {
    topImageSpacing = UILayoutGuide()
    self.addLayoutGuide(topImageSpacing)
    topImageSpacing.snp.makeConstraints { (make) in
        make.left.equalTo(self.snp.left)
        make.top.equalTo(self.snp.top)
        make.right.equalTo(self.snp.right)
        make.height.equalTo(self.snp.width).multipliedBy(UITableViewCellConstant.shared.topSpacingheightRatio)
    }
  }
  
  private func setupLeftImageSpacing() {
      leftImageSpacing = UILayoutGuide()
      self.addLayoutGuide(leftImageSpacing)
      leftImageSpacing.snp.makeConstraints { (make) in
          make.left.equalTo(self.snp.left)
          make.top.equalTo(topImageSpacing.snp.bottom)
          make.width.equalTo(self.snp.width).multipliedBy(UITableViewCellConstant.shared.topSpacingheightRatio)
      }
    }
  
  private func setupImageView() {
    imageview = UIImageView()
    imageview.contentMode = .scaleToFill
    imageview.clipsToBounds = true
    self.addSubview(imageview)
    imageview.snp.makeConstraints { (make) in
      make.left.equalTo(self.leftImageSpacing.snp.right)
        make.top.equalTo(topImageSpacing.snp.bottom)
        make.width.equalTo(self.snp.width).multipliedBy(UITableViewCellConstant.shared.imageWidthRatio)
      make.height.equalTo(imageview.snp.width)
    }
  }
    
  private func setupRightImageSpacing() {
    rightImageSpacing = UILayoutGuide()
    self.addLayoutGuide(rightImageSpacing)
    rightImageSpacing.snp.makeConstraints { (make) in
        make.left.equalTo(self.imageview.snp.right)
        make.top.equalTo(topImageSpacing.snp.bottom)
        make.width.equalTo(self.snp.width).multipliedBy(UITableViewCellConstant.shared.topSpacingheightRatio)
    }
  }
   
  private func setupTitleLabel() {
    titleTextLabel = UILabel()
    self.addSubview(titleTextLabel)
    titleTextLabel.numberOfLines = 0
    titleTextLabel.font = UIFont(name:"HelveticaNeue-Bold", size: UITableViewCellConstant.shared.titleViewFontSize)
    titleTextLabel.snp.makeConstraints { (make) in
        make.left.equalTo(self.rightImageSpacing.snp.right)
        make.top.equalTo(topImageSpacing.snp.bottom)
        make.right.equalTo(self.snp.right)
        make.height.equalTo(UITableViewCellConstant.shared.titleViewHeightConstraint)
    }
  }
  
  
  private func setupLocationTextLabel() {
    locationTextLabel = UILabel()
    self.addSubview(locationTextLabel)
    locationTextLabel.textColor = UIColor.gray
    locationTextLabel.font = .systemFont(ofSize: UITableViewCellConstant.shared.locationViewFontSize)
    locationTextLabel.snp.makeConstraints { (make) in
        make.left.equalTo(self.rightImageSpacing.snp.right)
        make.top.equalTo(titleTextLabel.snp.bottom)
        make.right.equalTo(self.snp.right)
        make.height.equalTo(self.snp.height).multipliedBy(UITableViewCellConstant.shared.locationSpacingHeightRatio)
    }
  }
  
  private func setupTimeTextLabel() {
    timeTextLabel = UILabel()
    timeTextLabel.numberOfLines = 0
    self.addSubview(timeTextLabel)
    timeTextLabel.textColor = UIColor.gray
    timeTextLabel.font = .systemFont(ofSize: UITableViewCellConstant.shared.timeViewFontSize)
    timeTextLabel.snp.makeConstraints { (make) in
        make.left.equalTo(self.rightImageSpacing.snp.right)
        make.top.equalTo(locationTextLabel.snp.bottom)
        make.right.equalTo(self.snp.right)
        make.height.equalTo(UITableViewCellConstant.shared.titleViewHeightConstraint)
    }
  }
  
  private func setupLikeImageView() {
    likeImageView = UIImageView()
    self.addSubview(likeImageView)
    likeImageView.snp.makeConstraints { (make) in
        make.centerX.equalTo(self.imageview.snp.left)
      make.top.equalTo(self.imageview.snp.top)
        make.width.equalTo(self.snp.width).multipliedBy(UITableViewCellConstant.shared.likeImageViewWidthRatio)
        make.height.equalTo(likeImageView.snp.width)
    }
  }
  
  private func setupBottomTextSpacing() {
    bottomTextSpacing = UILayoutGuide()
    self.addLayoutGuide(bottomTextSpacing)
    bottomTextSpacing.snp.makeConstraints { (make) in
        make.right.equalTo(self.snp.right)
        make.bottom.equalTo(self.snp.bottom)
        make.top.equalTo(self.timeTextLabel.snp.bottom)
        make.left.equalTo(self.rightImageSpacing.snp.right)
    }
  }
  
 
  
  override func prepareForReuse() {
      likeImageView.image = nil
  }
  
    
  override func layoutSubviews() {
    super.layoutSubviews()
    // make textview fit to its content size
    let sizeThatFitsTextView = titleTextLabel.sizeThatFits(CGSize(width: titleTextLabel.frame.size.width, height: CGFloat(MAXFLOAT)))
    self.titleTextLabel.snp.updateConstraints { (make) in
      make.height.equalTo(sizeThatFitsTextView.height)
    }
    let sizeThatFitsTextView2 = timeTextLabel.sizeThatFits(CGSize(width: timeTextLabel.frame.size.width, height: CGFloat(MAXFLOAT)))
    self.timeTextLabel.snp.updateConstraints { (make) in
      make.height.equalTo(sizeThatFitsTextView2.height)
    }
    imageview.layer.cornerRadius = UITableViewCellConstant.shared.imageCornorRadius
  }
  
  

}
extension TableViewCell {
    private struct UITableViewCellConstant {
      static var shared = UITableViewCellConstant()
  
      let fontSize: CGFloat = 16
      
      //top ImageSpacing
      let topSpacingConstraint: CGFloat = 0
      let topSpacingheightRatio: CGFloat = 0.04
    
      //left ImageSpacing
      let leftImageSpacingConstraint: CGFloat = 0
      let leftImageWidthRatio: CGFloat = 0.057
      
      //image
      let imageWidthRatio: CGFloat = 0.17
      let imageCornorRadius: CGFloat = 5
      
      //title view
      let titleViewHeightConstraint: CGFloat = 0
      let titleViewFontSize: CGFloat = 17
    
      //location view
      let locationViewFontSize: CGFloat = 14
      
      //time view
      let timeViewFontSize: CGFloat = 14
        
        
      //location spacing
      let locationSpacingHeightRatio: CGFloat = 0.15
      
    
      //like image view
      let likeImageViewWidthRatio: CGFloat = 0.07
      
    }
}


