//
//  GeneratorQR.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 12.01.2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins




protocol QR {
    
    //Общие характеристики QR кода
    var name: String { get set }
    var image: UIImage { get }
    
    //Первичный инициализатор
    init(name: String)
    
    //Генератор QR кодов
    func generateQR() -> UIImage
    
    
    
}





    
class StringToQR: QR {
    
    //Общие характеристики QR кода
    var name: String
    var image: UIImage {
        get {
            generateQR()
        }
    }
    
    //Первичный инициализатор
    required init(name: String) {
        self.name = name
    }

    
    //Генератор QR кодов
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()

    internal func generateQR() -> UIImage {
        filter.message = Data(name.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }

        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }

       
}


 
    


