import UIKit

extension UIViewController{
    
    func alertAddCity(name: String, placeholder: String, complitionHendler: @escaping (String) -> ()) {
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { (action) in
            let tftext = alertController.textFields?.first
            guard let text = tftext?.text else { return }
            complitionHendler(text)
        }
        
        alertController.addTextField { (tf) in
            tf.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "CANCEL", style: .default) { (_) in}
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
