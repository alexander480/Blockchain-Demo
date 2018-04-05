//: Playground - noun: a place where people can play

import Foundation

class Blockchain {
    private (set) var blocks: [Block] = [Block]()
    
    init(_ genesisBlock: Block) {
        addBlock(genesisBlock)
    }
    
    func addBlock(_ block: Block) {
        if self.blocks.isEmpty {
            block.previousHash = "0"
            block.hash = generateHash(for: block)
        }
        else {
            let previousBlock = getPreviousBlock()
            block.previousHash = previousBlock.hash
            block.index = self.blocks.count
            block.hash = generateHash(for: block)
        }
        
        self.blocks.append(block)
        displayBlock(block)
    }
    
    private func getPreviousBlock() -> Block {
        return self.blocks[self.blocks.count - 1]
    }
    
    private func displayBlock(_ block: Block) {
        print("------ Block \(block.index) ---------")
        print("Date Created : \(block.dateCreated) ")
        print("Data : \(block.data) ")
        print("Nonce : \(block.nonce) ")
        print("Previous Hash : \(block.previousHash!) ")
        print("Hash : \(block.hash!) ")
    }
    
    private func generateHash(for block: Block) -> String {
        var hash = block.key.sha1Hash()
        
        while(!hash.hasPrefix("00")) {
            block.nonce += 1
            hash = block.key.sha1Hash()
            print(hash)
        }
    }
}

class Block {
    var index: Int = 0
    var dateCreated: String
    var previousHash: String!
    var hash: String!
    var nonce: Int
    var data: String
    
    var key: String {
        get {
            return String(self.index) + self.dateCreated + self.previousHash + self.data + String(self.nonce)
        }
    }
    
    init(data: String) {
        self.dateCreated = String(describing: Date())
        self.nonce = 0
        self.data = data
    }
}
