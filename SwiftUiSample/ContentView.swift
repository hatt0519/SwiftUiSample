//
//  ContentView.swift
//  SwiftUiSample
//
//  Created by 服部一樹 on 2022/06/10.
//

import SwiftUI

struct ContentView: View {
    @State private var passwordProcessingTask: Task<(), Never>?
    @State private var isPasswordCreated: Bool = false
    @State private var isProgress: Bool = false
    @State private var nextViewArg: String = ""
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .center)  {
                    Text("これはサンプルですよ")
                        .padding()
                    
                    Button(
                        action: {
                            self.passwordProcessingTask =
                            Task {
                                isProgress.toggle()
                                self.nextViewArg = await PasswordManagerImpl().create()
                                isPasswordCreated.toggle()
                                isProgress.toggle()
                            }
                        }
                    ){
                        Text("パスワード生成")
                            .buttonStyle(.bordered)
                            .padding()
                    }
                    NavigationLink(destination: NextView(password: $nextViewArg),isActive: $isPasswordCreated) {
                        EmptyView()
                    }
                }
                if isProgress {
                    ProgressView("")
                }
                
            }
            .navigationTitle("パスワード作成")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onDisappear {
            passwordProcessingTask?.cancel()
        }
    }
    
}

protocol PasswordManager {
    func create() async -> String
}

// FIXME: 仮実装
// ライブラリのラッパーになる可能性大
struct PasswordManagerImpl : PasswordManager {
    func create() async -> String {
        try! await Task.sleep(nanoseconds: 3_000_000_000)
        return randomString(length: 10)
    }
    private func randomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in characters.randomElement()! })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
