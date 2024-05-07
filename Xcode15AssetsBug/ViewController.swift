//
//  ViewController.swift
//  Xcode15AssetsBug
//
//  Created by moonShadow on 2024/5/7
//  
//
//  LICENSE: SAME AS REPOSITORY
//  Contact me: [GitHub](https://github.com/darkThanBlack)
//
    

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
        setupSubviews(in: view)
    }
    
    private func setupSubviews(in box: UIView) {
        box.addSubview(stacks)
        
        [stacks].forEach({
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
        NSLayoutConstraint.activate([
            stacks.topAnchor.constraint(equalTo: box.topAnchor, constant: 64.0),
            stacks.leftAnchor.constraint(equalTo: box.leftAnchor, constant: 32.0),
            stacks.rightAnchor.constraint(equalTo: box.rightAnchor, constant: -32.0),
            stacks.bottomAnchor.constraint(equalTo: box.bottomAnchor, constant: -64.0),
        ])
    }
    
    // Xcode BUG:
    //
    // On Xcode 14.3, iOS 16.*, the visual effect of the picture is correct
    // On Xcode 15.1, iOS 17.2, parts of the image that are transparent appear black
    // ~~ Is there any solution to quick fix it? ~~
    // Update: [Thread_733455](https://forums.developer.apple.com/forums/thread/733455)
    
    private lazy var stacks: UIStackView = {
        var images: [UIImage] = []
        
        // 4 bit, wrong render.
        if let bit_4 = UIImage(named: "bit_4") {
            images.append(bit_4)
        }
        // Convert to 8 bit, right render.
        if let bit_4_converted = UIImage(named: "bit_4_converted") {
            images.append(bit_4_converted)
        }
        // Check info with "Finder", it is already 8 bit, wrong render.
        if let fromAssets = UIImage(named: "bit_8") {
            images.append(fromAssets)
        }
        // Move to bundle (or change ``Assets - Image Set - Compression - Lossy, Basic``), right render.
        //
        // Can I simply change ``Assets - Assets Catalog - Compression``?
        // Nope. Other image will render incorrectly.
        if let path = Bundle.main.path(forResource: "bit_8_bundle", ofType: "png"),
           let fromBundle = UIImage(contentsOfFile: path) {
            images.append(fromBundle)
        }
        // But if I convert directly once, right render.
        // I don't understand the details of the image processing, but I guess the image itself is a "fake 8 bit".
        // [Next question] Can we write a script to scan images that may be rendering incorrectly?
        // [Finally] I decided to convert all images at once. This may cause other problems, but it is worth.
        if let bit_8_converted = UIImage(named: "bit_8_converted") {
            images.append(bit_8_converted)
        }
        
        let stacks = UIStackView(arrangedSubviews: images.compactMap({ item in
            let view = UIImageView(image: item)
            view.contentMode = .scaleAspectFit
            return view
        }))
        stacks.axis = .vertical
        stacks.alignment = .center
        return stacks
    }()
}

