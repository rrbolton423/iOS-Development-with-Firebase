//
//  ViewController.swift
//  MyApp
//
//  Created by Romell Bolton on 12/3/18.
//  Copyright © 2018 Romell Bolton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseUI
import FirebaseStorage
import FirebaseFirestore

class ViewController: UIViewController, FUIAuthDelegate {
    
    // IBOutlets
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    // Create property for authentication class
    var authUI: FUIAuth?
    
    // Create Database reference property
    var ref: DatabaseReference?
    
    // Create Firestore reference property
    var fstore: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Gets the FUIAuth object for the default FirebaseApp.
        authUI = FUIAuth.defaultAuthUI()
        
        // Assign the delegate to this VC
        authUI?.delegate = self
        
        // Create an array of Firebase Authentication providers
        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
        
        // Set the providers
        authUI?.providers = providers
        
        // Initiliaze and get a reference to the Database
        ref = Database.database().reference()
        
        // Get Firestore reference
        fstore = Firestore.firestore()
        
        // If the user is logged in
        if Auth.auth().currentUser != nil {
            
            // Delete all documents in a collection
            fstore.collection("winner").getDocuments { (snapshot, error) in
                for doc in (snapshot?.documents)! {
                    doc.reference.delete()
                }
            }
            
//            // Get reference to winner document
//            let doc = fstore.collection("winner").document("100")
//
//            // Delete an entire document
//            doc.delete()
            
            // Delete field value
//            doc.updateData(["scores":FieldValue.delete()])
            
//            doc.updateData(["scores.top":700])
//            doc.updateData(["scores":["top":500, "low":5]])
//            doc.updateData(["level":200])
            
            // change the data
//            doc.setData(["game":1, "user":"brainofbear"], options: SetOptions.merge())
            
//            // Get all documents
//            fstore.collection("winner").whereField("game", isEqualTo: 2).getDocuments { (snapshot, error) in
//                // loop through documents returned
//                for doc in (snapshot?.documents)! {
//                    print(doc.data())
//                }
//            }
            
            // Get a reference to document 100
//            let doc = fstore.collection("winner").document("100")
//            doc.getDocument { (snapshot, error) in
//                // Fetch data from snapshot
//                if let d = snapshot?.data() {
//                    print(d["user"])
//                }
//            }
            
            // Create a db child reference "games"
            //ref?.child("games").child("1").setValue(["name":"first-edited", "level": 55])
            
            //            // Edit data using path
            //            ref?.child("games/1/score").setValue(nil)
            //
            //            // Remove a value
            //            ref?.child("games/1/score").removeValue()
            //
            //            // Generate a new child
            //            ref?.child("games").childByAutoId().setValue(["name": "second", "score": 20])
            // Read data once using observer. Data returned as a snapshot
            // Fetch the data and print it out to the console
            //            ref?.child("games").observeSingleEvent(of: .value, with: { (snapshot) in
            //                if let val = snapshot.value as? [String:Any] {
            //                    print(val)
            //                }
            //            })
            
//            // Observe a value being changed in Firebase
//            ref?.child("games/1/name").observe(.value, with: { (snapshot) in
//                if let val = snapshot.value as? String {
//                    print(val)
//                }
//            })
            
            // Updating data in Firebase
//            ref?.child("games").child("1").child("name").setValue("new name")
//            ref?.child("games/1/name").setValue("another new name")
//            ref?.child("games/1").setValue(["name":"final name", "score": 100])
//            
//            let childUpdates = ["games/1/name":"child update name", "games/2/name": "game 2", "games/1/score": nil] as [String: Any]
//            
//            ref?.updateChildValues(childUpdates)

            ref?.child("games/1").runTransactionBlock({ (data) -> TransactionResult in
                // If we have the right object
                if var game = data.value as? [String:Any] {
                    // Make update
                    game["name"] = "transaction name"
                    game["updatedAt"] = "\(Date())"
                    
                    // Store the changes back into the data
                    data.value = game
                }
                
                // Return the transaction
                return TransactionResult.success(withValue: data)
            }, andCompletionBlock: { (error, success, snapshot) in
                print(success)
            })
        }
    }
    
    // Remove observers when the view dissapears
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref?.child("games/1/name").removeAllObservers()
    }
    
    // If the user signs in successfully...
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        
        // If there is no error, update the UI
        if error == nil {
            btnLogin.setTitle("Logout", for: .normal)
        }
    }
    
    // This methods create's a user on Firebase
    @IBAction func doBtnCreate(_ sender: Any) {
        
        // Add data in Firestore
//        fstore.collection("winner").document("100").setData(["game":"1", "user":"brainofbear"])
        
//        fstore.collection("winner").addDocument(data: ["game":2, "user": "brainofbear"])
        
//        let doc = fstore.collection("winner").document()
//        doc.setData(["game":3, "user":"brainofbear"])
        
//        // Get image value out of game
//        ref?.child("games/1/image").observe(.value, with: { (snapshot) in
//
//            // If the value is not null
//            if let val = snapshot.value as? String {
//
//                // Get reference to file on the server that I can download
//                let fileref = Storage.storage().reference().child(val)
//
//                // Delete file
//                fileref.delete(completion: { (error) in
//                    print(error?.localizedDescription)
//                })
        
                // Get the download url
//                fileref.downloadURL(completion: { (url, error) in
//                    if let str = url?.absoluteString {
//                        print(str)
//                    }
//                })
                
//                // Download the data
//                fileref.getData(maxSize: 10000000, completion: { (data, error) in
//
//                    // Create a ImageView
//                    let iv = UIImageView.init(frame: self.view.bounds)
//
//                    // Set an image to the ImageView
//                    iv.image = UIImage.init(data: data!)
//
//                    // Update UI on main thread
//                    DispatchQueue.main.async {
//                        self.view.addSubview(iv)
//                    }
//                })
//            }
//        })
        
//        // Get the key for this game
//        let gameKey = ref?.child("game/2").key
//
//        // Create file name based on this key.
//        // We will upload this file as a png file
//        let filename = "\(gameKey!).png"
//
//        // Create the reference on the server for this file
//        let fileref = Storage.self.storage().reference().child(filename)
//
//        // Create metadata for this file
//        let meta = StorageMetadata()
//
//        // Set the content type
//        meta.contentType = "image/png"
//
//        // Upload the file from the disk
//        fileref.putFile(from: Bundle.main.url(forResource: "Guitar", withExtension: ".jpg")!, metadata: meta) { (meta, error) in
//            if error == nil {
//                self.ref?.child("games/1/image").setValue(filename)
//            }
//        }
        
        // Create reference to image
//        if let img = UIImage.init(named: "Guitar.jpg") {
//
//            // Upload the file
//            fileref.putData(img.pngData()!, metadata: meta) { (meta, error) in
//
//                // If there is no error...
//                if error == nil {
//
//                    // Relate the file we created to the game
//                    self.ref?.child("games/1/image").setValue(filename)
//                }
//            }
//        }
        
//        ref?.child("games/1/name").setValue("name + \(Date())")
        
        // Unwrap user input
//        if let email = tfEmail.text, let password = tfPassword.text {
//
//            // Create a user with the given credentials
//            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
//
//                // Print data returned
//                print(Auth.auth().currentUser?.email ?? "no email")
//                print(Auth.auth().currentUser?.uid ?? "no userid")
//            }
//        }
    }
    
    // This methods signs a user into Firebase
    @IBAction func doBtnLogin(_ sender: Any) {
        
        // If there isn't someone already logged in...
        if Auth.auth().currentUser == nil {
            
            // We dont have a user in this case, so present the UI
            if let authVC = authUI?.authViewController() {
                present(authVC, animated: true, completion: nil)
                
                // Unwrap user input
                //            if let email = tfEmail.text, let password = tfPassword.text {
                //
                //                // Sign in the user
                //                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                //
                //                    // Check for no error
                //                    if error == nil {
                //
                //                        // Update the UI
                //                        self.btnLogin.setTitle("Logout", for: .normal)
                //                    }
                //                }
                
            }
            
        } else { // If there is a user signed in already...
            
            /// Try to..
            do {
                
                // Sign the current user out
                try Auth.auth().signOut()
                
                // Update the UI
                self.btnLogin.setTitle("Login", for: .normal)
                
                // Catch error
            } catch {
                
                // Print error
                print("Error")
            }
        }
    }
    
}

