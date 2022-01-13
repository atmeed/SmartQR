//
//  GeneratorQR.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 12.01.2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins





struct GeneratorQR: View {
    
    @State private var text: String = ""
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    //Body
    var body: some View {
        NavigationView {
            Form {
                Image(uiImage: generateQR(from: "hell"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                Button("Поделиться") {
                    
                }.scaledToFit()
            }.navigationTitle("Создание QR кода")
        }
    }
    
    //Generate QR
    func generateQR(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
                
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    
}

struct GeneratorQR_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorQR()
    }
}
