//: Playground - noun: a place where people can play

import UIKit

/*
*归并排序

*T(n) = θ(nlgn)
*/

func mergeSort(inout list: [Int], startIndex: Int, endIndex: Int) {
    guard startIndex < endIndex else {
        return
    }
    
    let midIndex = (startIndex + endIndex) / 2
    
    mergeSort(&list, startIndex: startIndex, endIndex: midIndex)
    mergeSort(&list, startIndex: midIndex + 1, endIndex: endIndex)
    
    merge(&list, startIndex: startIndex, midIndex: midIndex, endIndex: endIndex)
}

//合并两个排好序的数组
func merge(inout list: [Int], startIndex: Int, midIndex: Int, endIndex: Int) {
    //构造两个新数组
    var subList1 = [Int]()
    for i in startIndex ... midIndex {
        subList1.append(list[i])
    }
    
    var subList2 = [Int]()
    for i in midIndex+1 ... endIndex {
        subList2.append(list[i])
    }
    
    var index1 = 0
    var index2 = 0
    for i in startIndex ... endIndex {
        //假如某一个数组已经遍历完了，便把另一个数组剩下部分全部放入list剩下的槽中，break退出循环
        guard index1 < subList1.count else {
            list[i...endIndex] = subList2[index2..<subList2.count]
            break
        }
        guard index2 < subList2.count else {
            list[i...endIndex] = subList1[index1..<subList1.count]
            break
        }
        //两个数组元素比较，将较小的元素放入list，然后该数组索引加1(":"后面接受的是个闭包，会延迟到判断之后再计算)
        list[i] = subList1[index1] <= subList2[index2] ? subList1[index1++] : subList2[index2++]
    }
}

//test
var testList = [8, 93, 76, 88, 23, 3, 0, 1]

mergeSort(&testList, startIndex: 0, endIndex: testList.count - 1)

