//
//  NextView.swift
//  SwiftUiSample
//
//  Created by 服部一樹 on 2022/06/11.
//

import SwiftUI

struct NextView: View {
    @Binding var password: String
    var body: some View {
        Text(password)
    }
}

struct NextView_Previews: PreviewProvider {
    @State static var password = "fdjsjadlj"
    static var previews: some View {
        NextView(password: $password)
    }
}
