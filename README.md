# HarvestKit-Swift
A Swift framework for accessing the harvest time tracking API

[![Build Status](https://travis-ci.org/MattCheetham/HarvestKit-Swift.svg?branch=master)](https://travis-ci.org/MattCheetham/HarvestKit-Swift) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


## Features
- Get projects
- Get clients
- Get users
- Get timers for current or specific user
- Create timers
- Update timers
- Delete timers
- Toggle timers on and off

## Requirements

- iOS 9.0+ / tvOS 9.0+ / OS X 10.10+
- Xcode 7.1+

## Installation

## Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralised dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following commands:

```bash
$ brew update
$ brew install carthage
```

To integrate HarvestKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github “MattCheetham/HarvestKit-Swift” == 1.3
```

Run `carthage bootstrap` to build the framework and drag the built `HarvestKit.framework` for the platform into your Xcode project.
You will also need to the drag the built `ThunderRequest.framework` for the platform into your project.


### Manual
Add this project as a submodule into git repository, drag the project file inside your project. Add `HarvestKitiOS`, `HarvestKittvOS` or `HarvestKitOSX` as an embedded library in project settings. You will also need to add [ThunderRequest](https://github.com/3sidedcube/iOS-ThunderRequest) framework to your project as this is a dependency of HarvestKit

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

## Code of Conduct
Please note that this project is released with a Contributor Code of Conduct. By participating in this project you agree to abide by its terms.
The Code of Conduct can be found [here](CODE_OF_CONDUCT.md)
## License

HarvestKit is released under the MIT license. See LICENSE for details.