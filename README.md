# HarvestKit-Swift
A Swift framework for accessing the harvest time tracking API

[![Build Status](https://travis-ci.org/MattCheetham/HarvestKit-Swift.svg?branch=master)](https://travis-ci.org/MattCheetham/HarvestKit-Swift) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


## Features
- Get list of projects
- Get list of clients
- Get list of users
- Get list of timers for a specific user

## Requirements

- iOS 9.0+ / tvOS 9.0+ / OS X 10.10+
- Xcode 7.1+

## Installation

## Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate HarvestKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github “MattCheetham/HarvestKit-Swift” ~> 1.1
```

Run `carthage bootstrap` to build the framework and drag the built `HarvestKit.framework` into your Xcode project.


### Manual
Add this project as a submodule into git repository, drag the project file inside your project. Add “HarvestKitiOS”, “HarvestKittvOS” or “HarvestKitOSX” as an embedded library in project settings.

### CocoaPods

Not yet, but I’m working on it

## Usage

### Setup

```swift
import HarvestKitiOS / import HarvestKittvOS / import HarvestKitOSX

let harvestController = HarvestController(accountName: “mycompanyname”, username: “example@mycompany.com”, password: “1234”)
```

## Documentation

Full documentation is [available here](http://mattcheetham.github.io/HarvestKit-Swift)

## License

HarvestKit is released under the MIT license. See LICENSE for details.