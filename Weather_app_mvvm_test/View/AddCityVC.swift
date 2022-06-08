import UIKit
import MapKit
import CoreLocation

protocol AddCityVCDelagate: AnyObject {
    func addCityVC(_ vc: AddCityVC, didSelectLocationWith cityName: String?)
}

class AddCityVC: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    weak var delegate: AddCityVCDelagate?
    
    private let field: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите название города"
        field.layer.cornerRadius = 9
        field.backgroundColor = .tertiarySystemBackground
        field.leftView = UIView (frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftViewMode = .always
        return field
    }()
    
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        return table
    }()
    
    var locations = [Location]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        view.addSubview(field)
        view.addSubview(tableView)
        field.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .secondarySystemBackground
            }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let fieldY: CGFloat = 100
        field.frame = CGRect(x: 10, y: fieldY, width: view.frame.size.width-20, height: 50)
        let tableY: CGFloat = field.frame.origin.y+field.frame.size.height+5
        tableView.frame = CGRect(x: 0,
                                 y: tableY,
                                 width: view.frame.size.width,
                                 height: view.frame.size.height-tableY)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        field.resignFirstResponder()
        if let text = field.text, !text.isEmpty {
            LocationManager.shared.findLocations(with: text) { [weak self] locations in
                DispatchQueue.main.async {
                    self?.locations = locations
                    self?.tableView.reloadData()
                }
            }

        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        
        cell.textLabel?.text = locations[indexPath.row].city + locations[indexPath.row].administrativeArea + locations[indexPath.row].country
        cell.textLabel?.numberOfLines = 0
        cell.contentView.backgroundColor = .secondarySystemBackground
        cell.backgroundColor = .secondarySystemBackground

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        let cityName = locations[indexPath.row].city
        delegate?.addCityVC(self, didSelectLocationWith: cityName)
        self.navigationController?.popViewController(animated: true)
    }
    
}
