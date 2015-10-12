//: Playground - noun: a place where people can play

import UIKit

//二叉堆基本操作
func getParent(index: Int) -> Int {
    return (index - 1) / 2
}

func getLeftChild(index: Int) -> Int {
    return 2 * index + 1
}

func getRightChild(index: Int) -> Int {
    return 2 * index + 2
}

var heapSize = 0

//维护最大堆性质
func maxHeapity(inout maxHeap: [Int], index: Int) {
    let left = getLeftChild(index)
    let right = getRightChild(index)

    //在index，left，right三者中取最大值
    var largest = (left < heapSize && maxHeap[left] > maxHeap[index]) ? left : index
    largest = (right < heapSize && maxHeap[right] > maxHeap[largest]) ? right : largest
    
    if largest != index {
        (maxHeap[index], maxHeap[largest]) = (maxHeap[largest], maxHeap[index])
        maxHeapity(&maxHeap, index: largest)
    }
}

func buildMaxHeap(inout list: [Int]) {
    heapSize = list.count
    var index = list.count/2 - 1
    //index+1...endIndex都是叶子节点
    while index >= 0 {
        maxHeapity(&list, index: index--)
    }
}

func heapSort(inout list: [Int]) {
    buildMaxHeap(&list)
    
    var endIndex = heapSize - 1
    while endIndex > 0 {
        //将最大元素换到底部
        (list[0], list[endIndex--]) = (list[endIndex], list[0])
        //将底部元素从堆中移除
        heapSize--
        //重新维持最大堆性质
        maxHeapity(&list, index: 0)
    }
}

//test
var testList = [27, 999, 77, 5, 90, 63, 11, 8]
heapSort(&testList)
