//
//  ViewController.swift
//  ApiTest
//
//  Created by 門崎　由暉 on 2020/04/30.
//  Copyright © 2020 門崎　由暉. All rights reserved.
//

import UIKit
import Foundation



struct Post: Codable{
    let status: String
    let message: String
    let data: PostId
    
    struct PostId: Codable {
        let id: Int
        let title: String
    }
}

struct Posts: Codable{
    let status: String
    let message: String
    let data: [PostId]
    
    struct PostId: Codable {
        let id: Int
        let title: String
    }
}

struct PostTitle: Codable {
    let title: String
}

struct PostPost: Codable {
    let status: String
    let data: PostData
    
    struct PostData: Codable {
        let title: String
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var idNumberTextField: UITextField!
    @IBOutlet weak var idTitleTextField: UITextField!
    @IBAction func onGetButtonTap(_ sender: Any) {
        let url = URL(string: "https://limitless-refuge-12748.herokuapp.com/api/v1/posts" + idNumberTextField.text!)!
        print(url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
            if let error = error {
                print("クライアントエラー: \(error.localizedDescription) \n")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                return
            }

            if response.statusCode == 200 {
                print(data)
                do{
                    if (self.idNumberTextField.text == "") {
                        let myblog: Posts
                        myblog = try JSONDecoder().decode(Posts.self, from: data)
                        let hogeManJsonData = try! JSONEncoder().encode(myblog)
                        // Data型→String型にキャスト
                        let hogeManJsonString = String(data: hogeManJsonData, encoding: .utf8)!
                        self.myTextField.text = hogeManJsonString
                    } else {
                        let myblog: Post
                        myblog = try JSONDecoder().decode(Post.self, from: data)
                        let hogeManJsonData = try! JSONEncoder().encode(myblog)
                        // Data型→String型にキャスト
                        let hogeManJsonString = String(data: hogeManJsonData, encoding: .utf8)!
                        self.myTextField.text = hogeManJsonString
                    }
                    
                } catch let jsonError{
                    print("error", jsonError)
                }
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバエラー ステータスコード: \(response.statusCode)\n")
            }

        }
        task.resume()
    }
    
    @IBAction func onPostButtonTap(_ sender: Any) {
        let url = URL(string: "https://limitless-refuge-12748.herokuapp.com/api/v1/posts")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let post1 = PostTitle(title: idTitleTextField.text!)
        let hogeManJsonData = try! JSONEncoder().encode(post1)
        request.httpBody = hogeManJsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
            if let error = error {
                print("クライアントエラー: \(error.localizedDescription) \n")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                return
            }

            if response.statusCode == 200 {
                print(data)
                do{
                    let myblog = try JSONDecoder().decode(PostPost.self, from: data)
                    let hogeManJsonData = try! JSONEncoder().encode(myblog)
                    // Data型→String型にキャスト
                    let hogeManJsonString = String(data: hogeManJsonData, encoding: .utf8)!
                    self.myTextField.text = hogeManJsonString
                } catch let jsonError{
                    print("error", jsonError)
                }
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバエラー ステータスコード: \(response.statusCode)\n")
            }

        }
        task.resume()
    }
    
    @IBAction func onPutButtonTap(_ sender: Any) {
        let url = URL(string: "https://limitless-refuge-12748.herokuapp.com/api/v1/posts" + idNumberTextField.text!)!
        print(url)
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        let post1 = PostTitle(title: idTitleTextField.text!)
        let hogeManJsonData = try! JSONEncoder().encode(post1)
        request.httpBody = hogeManJsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
            if let error = error {
                print("クライアントエラー: \(error.localizedDescription) \n")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                return
            }

            if response.statusCode == 200 {
                print(data)
                do{
                    let myblog = try JSONDecoder().decode(PostPost.self, from: data)
                    let hogeManJsonData = try! JSONEncoder().encode(myblog)
                    // Data型→String型にキャスト
                    let hogeManJsonString = String(data: hogeManJsonData, encoding: .utf8)!
                    self.myTextField.text = hogeManJsonString
                } catch let jsonError{
                    print("error", jsonError)
                }
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバエラー ステータスコード: \(response.statusCode)\n")
            }

        }
        task.resume()
    }
    
    @IBAction func onDeleteButtonTap(_ sender: Any) {
        let url = URL(string: "https://limitless-refuge-12748.herokuapp.com/api/v1/posts" + idNumberTextField.text!)!
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            // ここのエラーはクライアントサイドのエラー(ホストに接続できないなど)
            if let error = error {
                print("クライアントエラー: \(error.localizedDescription) \n")
                return
            }

            guard let data = data, let response = response as? HTTPURLResponse else {
                print("no data or no response")
                return
            }

            if response.statusCode == 200 {
                print(data)
                do{
                    let myblog = try JSONDecoder().decode(Post.self, from: data)
                    let hogeManJsonData = try! JSONEncoder().encode(myblog)
                    // Data型→String型にキャスト
                    let hogeManJsonString = String(data: hogeManJsonData, encoding: .utf8)!
                    self.myTextField.text = hogeManJsonString
                } catch let jsonError{
                    print("error", jsonError)
                }
            } else {
                // レスポンスのステータスコードが200でない場合などはサーバサイドエラー
                print("サーバエラー ステータスコード: \(response.statusCode)\n")
            }

        }
        task.resume()
    }
    
    @IBOutlet weak var myTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

