//: Playground - noun: a place where people can play

import UIKit

//栈
struct Stack<T> {
    var items = [T]()
    
    //栈顶指针
    var top: Int {
        return items.count - 1
    }
    
    var isEmpty: Bool {
        return items.isEmpty
    }
    
    //加上mutating才能改变struct中的属性
    //因为struct是值类型，默认是不可变的
    mutating func push(item: T, list: Array<T>) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
}

//队列
struct Queue<T> {
    var items = [T]()
    
    //入队
    mutating func enqueue(item: T) {
        items.append(item)
    }
    
    mutating func dequeue(item: T) -> T {
        return items.removeFirst()
    }
}

//节点(只能用class，struct不支持类型嵌套，也就是Node<T>内部不能声明类型为Node<T>的属性)
class Node<T: Equatable> {
    var value: T?
    var next: Node<T>!
    var prev: Node<T>!
    init(value: T?) {
        self.value = value
    }
}

//带哨兵(nilNode)的链表，没有head和tail
class LinkedList<T: Equatable> {
    
    var nilNode: Node<T>
    
    init() {
        nilNode = Node<T>(value: nil)
        nilNode.next = nilNode
        nilNode.prev = nilNode
    }
    
    //线性搜索
    func search(value: T) -> Node<T> {
        var node = nilNode.next
        //node.value为空则说明node是nilNode，因为其他节点的value都由值
        while let v = node.value {
            if v != value {
                node = node.next
            }
        }
        return node
    }
    
    //插入到nilNode之后
    func insert(value: T) {
        let node = Node<T>(value: value)
        node.next = nilNode.next
        nilNode.next.prev = node
        nilNode.next = node
        node.prev = nilNode
    }
    
    func delete(value: T) {
        let node = search(value)
        assert(node.value != nil, "Value not found in LinkedList.")
        node.prev.next = node.next
        node.next.prev = node.prev
    }
}

class Tree<T: Equatable> {
    var value: T
    var leftChild: Tree<T>!
    var rightChild: Tree<T>!
    init(value: T) {
        self.value = value
    }
}


//class BinaryTree<T: Equatable> {
//    
//    var root: TreeNode<T>
//    init(rootValue: T) {
//        root = TreeNode<T>(value: rootValue)
//    }
//    
//}
func ==<T>(lhs: Element<T>, rhs: Element<T>) -> Bool {
    return lhs.key == rhs.key && lhs.value == rhs.value
}

struct Element<T: Equatable>: Equatable {
    var key: Int?
    var value: T?
    init(key: Int?, value: T?) {
        self.key = key
        self.value = value
    }
    
    }
//哈希表
struct HashTable<T: Equatable> {
    typealias E = Element<T>
    
    var size: Int
    var memory : [LinkedList<E>?]
    init(size: Int) {
        self.size = size
        memory = [LinkedList<E>?](count: size, repeatedValue: nil)
    }
    
    //假定关键字都是Int
    func hash(key: Int) -> Int {
        return key % size
    }
    
    subscript(key: Int) -> T? {
        get {
            guard let linkedList = memory[hash(key)] else {
                return nil
            }
            let element = Element<T>(key: key, value: nil)
            return linkedList.search(element).value?.value
        }
        set {
            let element = Element<T>(key: key, value: newValue)
            let linkedList = memory[hash(key)] ?? LinkedList<E>()
            linkedList.insert(element)
            memory[hash(key)] = linkedList
        }
        
    }
    
//    mutating func insert(key: Int, value: T) {
//        memory[hash(key)] = value
//    }
}

//树中序遍历
func inorderTreeWalk<T>(tree: Tree<T>?) {
    guard let node = tree else {
        return
    }
    
    inorderTreeWalk(node.leftChild)
    print(node.value)
    inorderTreeWalk(node.rightChild)
}

//前序
func preorderTreeWalk<T>(tree: Tree<T>?) {
    guard let node = tree else {
        return
    }
    
    print(node.value)
    preorderTreeWalk(node.leftChild)
    preorderTreeWalk(node.rightChild)
}
//后序
func postorderTreeWalk<T>(tree: Tree<T>?) {
    guard let node = tree else {
        return
    }
    
    postorderTreeWalk(node.leftChild)
    postorderTreeWalk(node.rightChild)
    print(node.value)
}


