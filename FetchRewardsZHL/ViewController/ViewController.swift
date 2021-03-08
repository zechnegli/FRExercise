//
//  ViewController.swift
//  FetchRewardsZHL
//
//  Created by Jeremy on 3/5/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  private let tableViewCellReuseID = "viewCell"
  private let segue = "detail"
  private var events = [EventModel]()
  private var filltedEvents = [EventModel]()
  private var eventDic = [Int : EventModel]()
  private let searchController = UISearchController(searchResultsController: nil)
  private var isFiltering: Bool {
    return searchController.isActive && !isSearchBarEmpty
  }
  private  var isSearchBarEmpty: Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  let eventsManager: EventsManager = EventsManager()
  private var selectedRow: Int = 0 {
    didSet {
      self.performSegue(withIdentifier: segue, sender: nil)
    }
  }
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.isNavigationBarHidden = true
    tableView.register(TableViewCell.self, forCellReuseIdentifier: tableViewCellReuseID)
    tableView.dataSource = self
    tableView.delegate = self
    setupSearchController()

  }
  
  private func loadLikedEvents() {
    let likedEvent = CoreDataManager.shared.loadLikedEvent()
    for (id, isLiked) in likedEvent {
        eventDic[id]?.isLiked = isLiked
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    if events.isEmpty {
      fetchEvents()
    }
    tableView.reloadData()
  }

  
  private func fetchEvents() {
    eventsManager.getAllEvents(callback: { (events, error) in
      guard error == nil || events == nil || events?.events == nil else {return}
      for event in events!.events! {
        let eventModel = EventModel(location: event.venue?.location ?? "", time: event.time ?? "", title: event.title ?? "", imageURL: event.performers?[0].imageURL ?? "", id: event.id ?? 0, isLiked: false)
        self.events.append(eventModel)
        self.eventDic[eventModel.id] = eventModel
        
      }
      DispatchQueue.main.async {
        self.loadLikedEvents()
        self.tableView.reloadData()
      }
    })
  }
  
  private func setupSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    self.tableView.tableHeaderView = searchController.searchBar
    navigationItem.searchController = searchController
    setSearchBar( searchBar: searchController.searchBar)
    definesPresentationContext = true
  }
  
  //set search bar appearence
  private func setSearchBar(searchBar: UISearchBar) {
    let blueColor = UIColor(red: 46 / 255.0, green: 61 / 255.0, blue: 77 / 255.0, alpha: 1)
    searchBar.backgroundColor = blueColor
    searchBar.showsCancelButton = true
    searchBar.searchBarStyle = .minimal
    let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
    textFieldInsideSearchBar?.textColor = .gray
    searchBar.placeholder = "Search events"
    let textField = searchBar.value(forKey: "searchField") as! UITextField
    let glassIconView = textField.leftView as! UIImageView
    glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
    glassIconView.tintColor = .white
    if let buttonItem = searchBar.subviews.first?.subviews.last as? UIButton {
      buttonItem.setTitleColor(UIColor.white, for: .normal)
    }
    
    let uiButton = searchBar.value(forKey: "cancelButton") as? UIButton
    uiButton?.setTitleColor(UIColor.white,for: .normal)
    textFieldInsideSearchBar?.clearButtonMode = .never
    self.view.backgroundColor = blueColor
  }
  
  func filterContentForSearchText(_ searchText: String) {
    filltedEvents = events.filter { (event: EventModel) -> Bool in
      return (event.title.lowercased().contains(searchText.lowercased()))
    }
    
    tableView.reloadData()
  }

  
  override var preferredStatusBarStyle : UIStatusBarStyle {
      return .lightContent
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier! == self.segue, let destination = segue.destination as? DetailViewController {
      destination.event = isFiltering ? filltedEvents[selectedRow] : events[selectedRow]
    }
  }
  
  deinit {
      NotificationCenter.default.removeObserver(self)
  }



}

//tablew view delegate and data source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isFiltering {
      return filltedEvents.count
    }
    return events.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellReuseID)! as! TableViewCell
    let event: EventModel
    if isFiltering {
      event = filltedEvents[indexPath.row]
    } else {
      event = events[indexPath.row]
    }
    cell.setupCell(imageURL: event.imageURL, title: event.title, location: event.location, time: DateFormat.convertUTCTimeWithNewLine(dateString:  event.time), isLiked: event.isLiked)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UIScreen.main.bounds.height / 4.7
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    selectedRow = indexPath.row
 
  }
  
  
}

//search controller delegate
extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}



