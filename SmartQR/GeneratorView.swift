//
//  GeneratorView.swift
//  SmartQR
//
//  Created by Leonid Zemtsov on 15.01.2022.
//

import SwiftUI




struct GeneratorView: View {
    
    var qr = StringToQR(name: "Default")
    
    var body: some View {
        Image(uiImage: qr.image)
    }
}

struct GeneratorView_Previews: PreviewProvider {
    static var previews: some View {
        GeneratorView()
    }
}
