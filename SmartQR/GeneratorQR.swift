//
//  GeneratorQR.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 12.01.2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins




    
struct QR {
    
    //Имя QR кода
    private var text: String
    
    
    //Генератор QR кодов
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
        
    private func generateQR(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
            
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
                    
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    //Создание QR кода в UI
    public func getImage() -> UIImage {
        return generateQR(from: text)
    }
    
    
    //Инициализатор
    init(name: String) {
        self.text = name
    }
       
}


 
    


