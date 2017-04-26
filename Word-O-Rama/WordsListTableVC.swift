//
//  WordsListTableVC.swift
//  Word-O-Rama
//
//  Created by Luke Schwarting on 3/1/17.
//  Copyright © 2017 Luke Schwarting. All rights reserved.
//

import UIKit

class WordsListTableVC: UITableViewController {
    //ivars
    var wordList = [WordBank]()
    var selectedWordList = ["Choose a Word Bank!"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //list the words
        let wiredList = ["barn","cop","come","comb","an","another","grow","freedom","facial","face","my","am","a","diamond","men","man's","like","impressive","want","wine","t-shirt","suit","I","rule","people","out","y","with","ing","s","he","she","they"]
        let emojiList = ["💔","💑","🏈","🎣","🏒","😀","😂","😎","🐕","🦍","🐄","🏔️","🌋","🏍️","🏟️","❤️️","🔥","🤔","🤷","🏅","🇺🇸","😘","😣","😝","😱","🔪","🎮","⚽","🤐","😤","🤠","🤥","🤢","💩","🦃","🖖🏻","🖕🏾","👉","✊🏻","👌🏼","👅","💦","🍑","🍏","🍆"]
        let originalList = ["by","but","as","and","an","am","a","diamond","delirious","death","crush","ing","in","have","from","eat","dress","my","not","music","moon","love","ing","s","for","purple","puppy","our","no","sweat","smear","sky","snow","sausage","when","what","tounge","they","there","you","y","with","soccer","lacrosse"]
        let teenageList = ["bff","my","name","is","jill","idk","i,","men","like","my","how","coffee","black","i","like","#hashtag","Bieber","lover","I","am","word","s","never","hurt","me","like","who","are","you","even","is","shots","shots","everybody","feeling","like","22","sticks","stones","break","and","bones","may","but"]
        let trumpList = ["bigly","bad","hombres","boom","fired","you're","wall","that","build","duct","tape","all","women","on","apprentice","flirted","with","consciously","or","the","me","unconsiciously","their","what", "so","up","out","if","about","who","get","which","go","me","when","make","can","like","time","no","just","him","now"]
        let drinkingList = ["jack","coke","and","when","life","you","gives","add","vodka","lemon","s","come", "its", "over", "think", "also", "back", "after", "use","two","how","our","work", "first","well","way","even","don't","stop","drinking","till","drink","can't","no","more","I","only","on","days","drink","end","ing","in","y"]
        let commonWordList = ["the","be","to","of","and","a","in","that","have","I","it","for","not","on","with","he","as","you","do","at","this","but","his","by","from","they","we","say","her","she","or","an","will","my","one","all","would","there","their","what","so","up","out","if","about","who","get","which","go","me","when","make","can","like","dungeons","dragons","people","are","amazing","hello"]
        
        //add to word bank list
        wordList += [WordBank(name:"Original", value: originalList)]
        wordList += [WordBank(name:"Wired", value: wiredList)]
        wordList += [WordBank(name:"Emoji", value: emojiList)]
        wordList += [WordBank(name:"Teenage Sayings", value: teenageList)]
        wordList += [WordBank(name:"Trump Sayings", value: trumpList)]
        wordList += [WordBank(name:"Drink Sayings", value: drinkingList)]
        wordList += [WordBank(name:"Common", value: commonWordList)]
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  wordList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        //get name from cell
        let t = wordList[indexPath.row]
        let name = t.name
        cell.textLabel?.text = name
        
        return cell
    }
    //value
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWordList = wordList[indexPath.row].value
    }
    
    // MARK: - Action Methods -
    @IBAction func cancelTapped(sender: AnyObject)
    {
        dismiss(animated: true, completion: nil)
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
