//
//  ViewController.swift
//  RandomPhoto
//
//  Created by Aykhan Ahmadli on 9/14/23.
//

import UIKit

extension UIColor {
    static func fromHex(_ hex: String) -> UIColor {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

class ViewController: UIViewController {
    
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Generate Random", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    
    let colors: [UIColor]=[
        UIColor.fromHex("#68BBE3"),
        UIColor.fromHex("#0E86D4"),
        UIColor.fromHex("#055C9D"),
        UIColor.fromHex("#003060"),
        UIColor.fromHex("#274472"),
        
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.fromHex("##003392")
        view.addSubview(imageView)
        imageView.frame = CGRect(x:0,y:0, width:300, height:300)
        imageView.center = view.center
        
        view.addSubview(button)
       
        getRandomPhoto()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        getRandomPhoto()
        view.backgroundColor = colors.randomElement()
    }
    
    override func viewDidLayoutSubviews() {
        button.frame =  CGRect(x:30,y:view.frame.size.height-150-view.safeAreaInsets.bottom,width:view.frame.size.width-60,height: 60)
    }
    
    func getRandomPhoto(){
        let urlString = "https://source.unsplash.com/random/600x600"
        let url = URL(string: urlString)!
        guard let data = try?  Data(contentsOf:url) else {return}
        imageView.image = UIImage(data:data)
    }


}

