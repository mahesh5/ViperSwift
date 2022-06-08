//
//  AlertView.swift
//  Lloyds
//
//  Created by Mahesh Varadaraj on 09/06/22.
//

import Foundation
import UIKit

public class ErrorAlert {
    func showMessage(message: String, controller: UIViewController) {
        let alert = UIAlertController(title: K.appTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: K.okButton, style: UIAlertAction.Style.default, handler: nil))
        controller.present(alert, animated: true, completion: nil)
    }
}
