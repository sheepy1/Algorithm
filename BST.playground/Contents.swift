//: Playground - noun: a place where people can play

import UIKit

func ==<T>(lhs: Node<T>, rhs: Node<T>) -> Bool {
    if lhs.value == rhs.value && lhs.leftChild == rhs.leftChild && lhs.rightChild == rhs.rightChild && lhs.parent == rhs.parent {
        return true
    }
    
    return false
}

class Node<T: Comparable>: Equatable {
    var value: T
    var leftChild: Node<T>!
    var rightChild: Node<T>!
    var parent: Node<T>!
    init(value: T) {
        self.value = value
    }
}

class Tree<T: Comparable> {
    var root: Node<T>
    //todo
}

///以下所有操作的时间复杂度都是O(h)(h是树高,h = lgn ~ n)，平均运行时间是θ(lgn)

//查询二叉搜索树
func search<T>(optionalNode: Node<T>?, value: T) -> Node<T>? {
    guard let node = optionalNode where node.value != value else {
        return optionalNode ?? nil
    }
    
    if value < node.value {
        return search(node.leftChild, value: value)
    } else {
        return search(node.rightChild, value: value)
    }
}

//查询-迭代版
func iterativeSearch<T>(var optionalNode: Node<T>?, value: T) -> Node<T>? {
    while let node = optionalNode where node.value != value {
        if value < node.value {
            optionalNode = node.leftChild
        } else {
            optionalNode = node.rightChild
        }
    }
    
    return optionalNode ?? nil
}

//最小值
func minimum<T>(root: Node<T>) -> Node<T> {
    var node = root
    while let leftChild = node.leftChild {
        node = leftChild.leftChild
    }
    return node
}

//最大值 
func maximum<T>(root: Node<T>) -> Node<T> {
    var node = root
    while let rightChild = node.rightChild {
        node = rightChild.rightChild
    }
    return node
}

//后继
func successor<T>(var node: Node<T>) -> Node<T> {
    //若有右字树，则后继为右子树中的最小值
    if let rightChild = node.rightChild {
        return minimum(rightChild)
    }

    //若无右子树，则后继为沿树而上遇到的第一个左孩子的父节点（若自身便为左孩子，则直接返回父节点）
    while let parent = node.parent where node == parent.rightChild {
        node = node.parent
    }
    
    return node.parent
}

//插入
//todo

