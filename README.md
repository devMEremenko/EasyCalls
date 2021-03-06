# EasyCalls

![Build Status](https://travis-ci.org/devMEremenko/EasyCalls.svg?branch=master)
[![codecov.io](https://codecov.io/github/devmeremenko/EasyCalls/coverage.svg?branch=master)](https://codecov.io/github/devmeremenko/EasyCalls?branch=master)
[![codebeat badge](https://codebeat.co/badges/9a996a4d-e42e-43b7-ba9a-d18c4d361409)](https://codebeat.co/projects/github-com-devmeremenko-easycalls-master)
[![Version](https://img.shields.io/cocoapods/v/EasyCalls.svg?style=flat)](http://cocoapods.org/pods/EasyCalls)
[![Platform](https://img.shields.io/cocoapods/p/EasyCalls.svg?style=flat)](http://cocoapods.org/pods/EasyCalls)
[![GitHub license](https://img.shields.io/github/license/devmeremenko/EasyCalls.svg)](https://github.com/devMEremenko/EasyCalls/blob/master/LICENSE)
[![GitHub forks](https://img.shields.io/github/forks/devmeremenko/EasyCalls.svg)](https://github.com/devmeremenko/EasyCalls/network)
[![GitHub stars](https://img.shields.io/github/stars/devmeremenko/EasyCalls.svg)](https://github.com/devmeremenko/EasyCalls/stargazers)


### Hi there,

This repository contains a number of methods over Swift API to use it safely. <br />

#### Contents

- [`DispatchQueue` management ](#queues)
- [`Swift` errors handling](#swift-errors-handling)
- [`Realm`. Safe write and read transactions](#realm)
- [`UIAlertController` easiest presentation](#uialertcontroller)

## Queues

These methods are used to dispatch execution to the specified queue.

```swift
DispatchQueue.toMain {
    // update UI
}

DispatchQueue.toBackground {
    // load data
}

DispatchQueue.runAfter(time: 1) {
    // performs work on the main queue after 1 sec
}
```

Customization

```swift
DispatchQueue.toBackground(qos: .utility) { // Separate queue }

DispatchQueue.toBackground(label: "",
              qos: .background,
              attr: .concurrent,
              frequency: .inherit,
              target: DispatchQueue.global()) { // Separate queue }
```

```swift
DispatchQueue.runAfter(time: 1) { // Main thread }

DispatchQueue.runAfter(time: 1, qos: .userInteractive) { // Separate queue }

DispatchQueue.runAfter(time: 1,
              qos: .userInteractive,
              attr: .concurrent,
              frequency: .inherit,
              target: DispatchQueue.global()) { // Separate queue }
```

## DispatchQueue.toMain <br />
`DispatchQueue.toMain` call safely dispatches execution to the main queue.<br /><br />
Since being on the main thread does not guarantee to be on the main queue, the `DispatchQueue.toMain` call checks whether the current queue is main. The operations of the main queue are always executed on the main thread.<br />
As described in the [libdispatch](https://github.com/apple/swift-corelibs-libdispatch/commit/e64e4b962e1f356d7561e7a6103b424f335d85f6), `dispatch_sync` performs work on the current queue. It can cause a situation when the main queue will wait for completion of another sync operation.

Here is an example when the main thread is able to execute operations **from other queues**:

```swift
DispatchQueue.main.async {
    // Main Queue
    DispatchQueue(label: "").sync {
        // Background Queue
        
        if Thread.isMainThread {
            // The thread is Main, but the current queue is NOT Main.
            // UI should NOT be updated here.
            
            // The 'DispatchQueue.toMain' call prevents this situation.
        }
    }
}
```

To sum up, `DispatchQueue.toMain` guarantees that the passed block will be executed on the main queue and, therefore, on the main thread.
In addition, if the current queue and thread are not main, the operation will be synchronously added to the main queue to prevent a race condition.


## DispatchQueue.toBackground
`DispatchQueue.toBackground` asynchronously dispatches an execution to the separate queue with `default` QoS.

## DispatchQueue.runAfter
The `DispatchQueue.runAfter(time: 1)` call performs a block on the main queue after the passed time.<br />
However, `runAfter(time: qos:)` with specified `QoS` performs the given block on the **separate queue**. Do not update UI on it.

## Swift Errors Handling

The syntactic sugar methods help to make the code more clear.

```swift
tryCatch({
    try call()
})
```

```swift
tryCatch({
    try call()
    try anotherCall()
}) { error in
    // handle an error
}
```

These are simple wrappers over the Optional type.

```swift
if error.isExist {
    // handle
}

if error.isNil {
    // success
}
```

## Realm

```swift
Realm.read(transaction: { realm in
    // use realm
})

Realm.write(transaction: { realm in
    // use realm
})
```
The safe write transaction:
- returns the default realm instance
- contains an **autorelease pool** to prevent an uncontrolled increase of the file size of database.
It might happen if objects are created inside of a GCD operation. The GCD only drains the queue-level autorelease pools relatively infrequently which can result in the lifetimes of Realm objects being significantly longer.
- updates Realm objects to the most recent data at the end of transaction.

The *error handling* is also supported by attaching an `error` closure.

## UIAlertController

There is a number of calls to present `UIAlertController` (including `ActionSheet`)<br />
* it is implemented as an extension for `UIViewController`
* uses `DispatchQueue.toMain` under the hood to guarantee a presentation on the main queue
* parameters of the `show()` method can be combined in different ways

```swift
// Alert
show(title: "Title", actions: Action.ok)

// ActionSheet
show(title: "Action Sheet", style: .actionSheet, actions: Action.ok)
```

```swift
// Alert with Message
show(message: "Message", actions: Action.ok, Action.cancel)

// Alert with Title and Message, Ok and Cancel buttons
show(title: "Title", message: "Message", actions: Action.ok, Action.cancel)
```

**Actions Handling**

```swift
let ok = Action.ok { _ in
    // handle ok
}

let cancel = Action.cancel { _ in
    // handle cancel
}

show(title: "Alert with ok/cancel buttons", actions: cancel, ok)
```

The `Action` factory can be used to create a `UIAlertAction` or you can pass your own.

```swift
let next = Action.with(title: "Next") { action in
    // handle
}

let delete = UIAlertAction(title: "Delete", style: .destructive) { _ in
    // handle
}

show(title: "Are you sure?", actions: next, delete)
```

**Full control on the alert presentation**
```swift
show(title: "Title", message: "Message", style: .actionSheet, completion: {
    // That is called when the alert has been presented
}, actions: [action])
```

Please note, the `actions` parameter **takes *Array* of actions instead of a variadic function**


Presentation of the custom alert
```swift
let alert = UIAlertController()

// configure

show(alert: , {
    /* handle */
})
```

The `Configuration` model provides an ability to override defaults for localization or other reasons.

```swift
public struct Configuration {
    public static var ok: String = "OK"
    public static var cancel: String = "Cancel"

    public struct Action {
        public static var defaultStyle = UIAlertActionStyle.default
        public static var cancelStyle = UIAlertActionStyle.cancel
    }
    public struct Alert {
        public static var style = UIAlertControllerStyle.alert
    }
}
```


## Installation

**Do not forget to import the module**
```swift
import EasyCalls
```


### CocoaPods
EasyCalls is available through [CocoaPods](http://cocoapods.org).

Each module works independently so you can install the modules you need right now

```ruby

pod 'EasyCalls/TryCatch'
pod 'EasyCalls/Queues'
pod 'EasyCalls/Realm'
pod 'EasyCalls/Alert'


pod 'EasyCalls' # contains 'TryCatch' and 'Queues' by default
```

### Manually

* Open up Terminal, `cd` into your top-level project directory, and run the following command *if* your project is not initialized as a git repository:

```
$ git init
```

* Add EasyCalls as a git [submodule](http://git-scm.com/docs/git-submodule) by running the following commands:

```
$ git submodule add https://github.com/devmeremenko/EasyCalls.git
```

* Open the new EasyCalls folder, and drag the necessary sources into the Project Navigator of your project.

## Change Log

`Version` is the same for **CocoaPods** and **GitTag**.

|  Version  | Function |             Description            |              Migration               |
| ---------- | ---------- | -----------------------------  | -------------------------------|
|    1.2.1    |  Queues  | **Extensions** for `DispatchQueue` were used instead of **global functions**.<br /><br /> The `SpecificKey` for the main queue is set **only once** now. | Please add `DispatchQueue.` expression before all `toMain`, `toBackground`, and `runAfter`  calls.|
|    1.1.1    |  Alert  | `EasyCalls/Alert` were added |                                |


## Author
 
[Maksym Eremenko](https://www.linkedin.com/in/maxim-eremenko/), devmeremenko@gmail.com

## License

EasyCalls is available under the MIT license.

```
# Copyright (c) 2018 Maxim Eremenko <devmeremenko@gmail.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
```
