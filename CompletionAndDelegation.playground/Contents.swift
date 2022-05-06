import Foundation

// MARK: -Completion Block
//func expensiveTask(data: String, completion: @escaping (String) -> Void) {
//  let queue = DispatchQueue(label: "com.dicoding.completionblock")
//
//  queue.async {
//    print("Processing: \(data)")
//    sleep(2)
//    completion("Processing \(data) finished")
//  }
//}
//
//let mainQueue = DispatchQueue(label: "com.dicoding.main", qos: .userInteractive)
//mainQueue.async {
//  expensiveTask(data: "Get Me") { result in
//    print(result)
//  }
//
//  print("Main queue run")
//}


//MARK: -Delegation
protocol TaskDelegate {
  func taskFinished(result: String)
}

struct Task{
  var delegate: TaskDelegate?
  
  func expensiveTask(data: String){
    let queue = DispatchQueue(label: "com.dicoding.completionblock")
    
    queue.async {
      print("Processing: \(data)")
      sleep(2)
      self.delegate?.taskFinished(result: "Processing \(data) finished")
    }
  }
}

struct Main: TaskDelegate {
  func run() {
    let mainQueue = DispatchQueue(label: "com.dicoding.main", qos: .userInteractive)
    
    mainQueue.async {
      var task = Task()
      task.delegate = self
      task.expensiveTask(data: "Get me")
      print("Main queue run")
    }
  }
  
  func taskFinished(result: String) {
    print(result)
  }
}

let main = Main()
main.run()
