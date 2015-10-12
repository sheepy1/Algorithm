//: Playground - noun: a place where people can play

import Foundation


/*
*快速排序

*最坏情况(初始数组已排序或逆序):
*   T(n) = T(0) + T(n-1) + θ(n) = θ(1) + T(n-1) + θ(n) = T(n-1) + θ(n) = θ(n²)  (等差级数)
*平均情况: 
    T(n) = θ(nlgn)
*/

func quickSort(inout list: [Int], startIndex: Int, endIndex: Int) {
    //若startIndex<EndIndex则表明序列至少有2个元素，其他情况直接返回
    guard startIndex < endIndex else {
        return
    }
    //排序，并返回参考点(参考点左侧的数都小于参考点，右侧的都大于参考点)
    let referenceIndex = divide(&list, startIndex: startIndex, endIndex: endIndex)
    //递归对参考点左边部分排序
    quickSort(&list, startIndex: startIndex, endIndex: referenceIndex - 1)
    //递归对参考点右边部分排序
    quickSort(&list, startIndex: referenceIndex + 1, endIndex: endIndex)
}

func divide(inout list: [Int], startIndex: Int, endIndex: Int) -> Int {
    //用来记录参考点位置(遍历完成之后用来放置序列的第一个数)
    var referenceIndex = startIndex
    //参考点的值(序列中第一个数)
    let referencePoint = list[startIndex]
    //遍历序列，与参考点比较
    for compareIndex in startIndex+1 ... endIndex {
        //若小于参考点，就跟referenceIndex后的数交换，referenceIndex前进一位
        if list[compareIndex] < referencePoint {
            (list[referenceIndex], list[compareIndex]) = (list[compareIndex], list[++referenceIndex])
        }
    }
    //将序列第一个数放到参考点位置，它左边的值都比它小，右边的都比他大
    (list[startIndex], list[referenceIndex]) = (list[referenceIndex], list[startIndex])
    //返回参考点位置
    return referenceIndex
}


/*
*随机化快排

*T(n) = θ(nlgn)
*/
func randomQuickSort(inout list: [Int], startIndex: Int, endIndex: Int) {
    guard startIndex < endIndex else {
        return
    }
    //排序，并返回参考点(参考点左侧的数都小于参考点，右侧的都大于参考点)
    let referenceIndex = randomDivide(&list, startIndex: startIndex, endIndex: endIndex)
    //递归对参考点左边部分排序
    randomQuickSort(&list, startIndex: startIndex, endIndex: referenceIndex - 1)
    //递归对参考点右边部分排序
    randomQuickSort(&list, startIndex: referenceIndex + 1, endIndex: endIndex)
}

func randomDivide(inout list: [Int], startIndex: Int, endIndex: Int) -> Int {
    let random = getRandomNumIn(startIndex ... endIndex)
    (list[startIndex], list[random]) = (list[random], list[startIndex])
    
    return divide(&list, startIndex: startIndex, endIndex: endIndex)
}

func getRandomNumIn(range: Range<Int>) -> Int {
    guard let min = range.first, let max = range.last else {
        return 0
    }
    let delta = max - min + 1
    //不能直接arc4random % delta，否则在x86、x64不同平台运行时由于字长不同会出现不可测错误
    let randomDelta = Int(arc4random() % UInt32(delta))
    let randomNum = min + randomDelta
    return randomNum
}


//高阶函数相关
func customQuickSort(inout list: [Int], startIndex: Int, endIndex: Int, randomHandler: ((range: Range<Int>) -> Int)?) {
    let divide: () -> Int = {
        if let getRandom = randomHandler {
            let randomIndex = getRandom(range: startIndex ... endIndex)
            (list[startIndex], list[randomIndex]) = (list[randomIndex], list[startIndex])
        }
        //用来记录参考点位置(遍历完成之后用来放置序列的第一个数)
        var referenceIndex = startIndex
        //参考点的值(序列中第一个数)
        let referencePoint = list[startIndex]
        //遍历序列，与参考点比较
        for compareIndex in startIndex+1 ... endIndex {
            //若小于参考点，就跟referenceIndex后的数交换，referenceIndex前进一位
            if list[compareIndex] < referencePoint {
                (list[referenceIndex], list[compareIndex]) = (list[compareIndex], list[++referenceIndex])
            }
        }
        //将序列第一个数放到参考点位置，它左边的值都比它小，右边的都比他大
        (list[startIndex], list[referenceIndex]) = (list[referenceIndex], list[startIndex])
        //返回参考点位置
        return referenceIndex
    }
    
    //若startIndex<EndIndex则表明序列至少有2个元素，其他情况直接返回
    guard startIndex < endIndex else {
        return
    }
    //排序，并返回参考点(参考点左侧的数都小于参考点，右侧的都大于参考点)
    let referenceIndex = divide()
    //递归对参考点左边部分排序
    customQuickSort(&list, startIndex: startIndex, endIndex: referenceIndex - 1, randomHandler: randomHandler)
    //递归对参考点右边部分排序
    customQuickSort(&list, startIndex: referenceIndex + 1, endIndex: endIndex, randomHandler: randomHandler)
}

//测试数组
var testList = [3, 8, 9, 10, 2, 1]
quickSort(&testList, startIndex: 0, endIndex: testList.count - 1)

var testList2 = [28, 3, 76, 99, 42, 111, 88, 99, 75]
quickSort(&testList2, startIndex: 0, endIndex: testList2.count - 1)
randomQuickSort(&testList2, startIndex: 0, endIndex: testList2.count - 1)

//朴素快排
customQuickSort(&testList2, startIndex: 0, endIndex: testList2.count - 1, randomHandler: nil)
//随机化快排，自己传入一个获取随机数的闭包，我这边调用了原先定义好的那个
customQuickSort(&testList2, startIndex: 0, endIndex: testList2.count - 1) { (range) -> Int in
    return getRandomNumIn(range)
}
