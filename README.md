# EasyCalls

[![Build Status](https://travis-ci.org/devMEremenko/EasyCalls.svg?branch=master)](https://travis-ci.org/devMEremenko/EasyCalls)
[![Version](https://img.shields.io/cocoapods/v/EasyCalls.svg?style=flat)](http://cocoapods.org/pods/EasyCalls)
[![License](https://img.shields.io/cocoapods/l/EasyCalls.svg?style=flat)](http://cocoapods.org/pods/EasyCalls)
[![Platform](https://img.shields.io/cocoapods/p/EasyCalls.svg?style=flat)](http://cocoapods.org/pods/EasyCalls)

### Hi there,

This repository contains a number of methods over Swift API to use it safely. <br />

#### Contents

- [`DispatchQueue` management ](#Queues)
- [`Swift` errors handling](#Swift)
- [`Realm`. Safe write and read transactions](#Realm)

## Queues

These methods are used to dispatch execution to the specified queue.

```swift
toMain {
    // update UI
}

toBackground {
    // load data
}

runAfter(time: 1) {
    // performs work on the main queue after 1 sec
}
```

And modifications

```swift
toBackground(qos: .utility) { // Separate queue }

toBackground(label: "",
             qos: .background,
             attr: .concurrent,
             frequency: .inherit,
             target: DispatchQueue.global()) { // Separate queue }
```

```swift
runAfter(time: 1) { // Main thread }

runAfter(time: 1, qos: .userInteractive) { // Separate queue }

runAfter(time: 1,
         qos: .userInteractive,
         attr: .concurrent,
         frequency: .inherit,
         target: DispatchQueue.global()) { // Separate queue }
```

#### toMain <br />
The `toMain` call safely dispatches execution to the main queue.<br />
Since being on the main thread does not guarantee to be in the main queue, the `toMain` call checks whether the current queue is main. The operations of the main queue are always executed on the main thread.
As described in the [libdispatch](https://github.com/apple/swift-corelibs-libdispatch/commit/e64e4b962e1f356d7561e7a6103b424f335d85f6), `dispatch_sync` performs work on the current queue. It can cause a situation when the main queue will wait for completion of another sync operation. At this point, the main thread is able to execute operations from other queues.

To sum up, `toMain` guarantees that the passed block will be executed on the main queue and, therefore, on the main thread.
In addition, if the current queue and thread are not main, the operation will be synchronously added to the main queue to prevent a race condition.


#### toBackground
`toBackground` asynchronously dispatches an execution to the separate queue with `default` QoS.

#### runAfter
The `runAfter(time: 1)` call performs a block on the main queue after the passed time.<br />
However, `runAfter(time: qos:)` with specified `QoS` performs the given block on the **separate queue**. Do not update UI on it.

## Swift Errors Handling

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

## Installation


### CocoaPods
EasyCalls is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EasyCalls'
```


