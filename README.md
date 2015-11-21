# HarvestKit-Swift
A Swift framework for accessing the harvest time tracking API

[![Build Status](https://travis-ci.org/MattCheetham/HarvestKit-Swift.svg?branch=master)](https://travis-ci.org/MattCheetham/HarvestKit-Swift)

## Features
- Get list of projects
- Get list of clients
- Get list of users
- Get list of timers for a specific user

## Requirements

- iOS 9.1+ / tvOS 9.0+ / OS X 10.10+
- Xcode 7.1+

## Installation

Add this project as a submodule into git repository, drag the project file inside your project. Add “HarvestKitiOS”, “HarvestKittvOS” or “HarvestKitOSX” as an embedded library in project settings.

## CocoaPods / Catharge

Not yet, but I’m working on it

## Usage

### Setup

```swift
import HarvestKit(iOS/tvOS/OSX)

let harvestController = HarvestController(accountName: “mycompanyname”, username: “example@mycompany.com”, password: “1234”)
```

## Documentation

Full documentation is [available here](http://mattcheetham.github.io/HarvestKit-Swift)

## License

HarvestKit is released under the MIT license. See LICENSE for details.