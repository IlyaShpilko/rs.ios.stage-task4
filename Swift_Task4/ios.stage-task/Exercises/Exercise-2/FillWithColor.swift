import Foundation

final class FillWithColor {
        
    struct CounterElement: Equatable {
        var elementOne: Int
        var elementTwo: Int
    }
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        
            var newImage = image
            var counter = [CounterElement(elementOne: row, elementTwo: column)]
            var helpingArray = Array<CounterElement>()
                
            while counter.count > 0 {
                let element = counter.remove(at: 0)
                helpingArray.append(element)
                    
                if (image[element.elementOne][element.elementTwo] == image[row][column]) {
                    newImage[element.elementOne][element.elementTwo] = newColor
                } else {
                    continue
                }
                    
                if (element.elementOne - 1) >= 0 {
                    let element = CounterElement(elementOne: element.elementOne - 1, elementTwo: element.elementTwo)
                    if !helpingArray.contains(element) {
                        counter.append(element)
                    }
                }
                
                if (element.elementOne + 1) < image.count {
                    let element = CounterElement(elementOne: element.elementOne + 1, elementTwo: element.elementTwo)
                    if !helpingArray.contains(element) {
                        counter.append(element)
                    }
                }
                
                if (element.elementTwo - 1) >= 0 {
                    let element = CounterElement(elementOne: element.elementOne, elementTwo: element.elementTwo - 1)
                    if !helpingArray.contains(element) {
                        counter.append(element)
                    }
                }
                
                if (element.elementTwo + 1) < image[row].count {
                    let element = CounterElement(elementOne: element.elementOne, elementTwo: element.elementTwo + 1)
                    if !helpingArray.contains(element) {
                        counter.append(element)
                    }
                }
            }
        
            return newImage
    }
}
