Go UUID implementation
========================

[![license](http://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/twinj/uuid/master/LICENSE)
[![GoDoc](http://godoc.org/github.com/twinj/uuid?status.png)](http://godoc.org/github.com/twinj/uuid)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/twinj/uuid?branch=master&svg=true)](https://ci.appveyor.com/project/myesui/uuid)
[![Build Status](https://travis-ci.org/twinj/uuid.png?branch=master)](https://travis-ci.org/twinj/uuid)
[![Coverage Status](https://coveralls.io/repos/github/twinj/uuid/badge.svg?branch=master)](https://coveralls.io/github/twinj/uuid?branch=master)

**This project is currently pre 1.0.0**

This package provides RFC 4122 and DCE 1.1 compliant UUIDs.
It will generate the following:

* Version 1: based on a Timestamp and MAC address as Node id
* Version 2: based on DCE Security - Experimental
* Version 3: based on MD5 hash
* Version 4: based on cryptographically secure random numbers
* Version 5: based on SHA-1 hash

Functions NewV1, NewV2, NewV3, NewV4, NewV5, New, NewHex and Parse() for
generating version 1, 2, 3, 4 and 5 Uuid's

# Requirements

Any supported version of Go.

# Design considerations

* V1 UUIDs should be properly sequential. This can cause the Generator to work
more slowly compared to other implementations. It can however be manually tuned
to have performance that is on par. This is achieved by setting the Timestamp
Resolution. Benchmark tests have been provided to help determine the best
setting for your server

    Proper test coverage has determined thant the UUID timestamp spinner works
    correctly, across multiple clock resolutions. The generator produces
    timestamps that roll out sequentially and will only modify the clock
    sequence on very rare circumstances.

    It is highly recommended that you register a uuid.Saver if you use V1 or V2
    UUIDs as it will ensure a higher probability of uniqueness.

        Example V1 output:
        5fb1a280-30f0-11e6-9614-005056c00001
        5fb1a281-30f0-11e6-9614-005056c00001
        5fb1a282-30f0-11e6-9614-005056c00001
        5fb1a283-30f0-11e6-9614-005056c00001
        5fb1a284-30f0-11e6-9614-005056c00001
        5fb1a285-30f0-11e6-9614-005056c00001
        5fb1a286-30f0-11e6-9614-005056c00001
        5fb1a287-30f0-11e6-9614-005056c00001
        5fb1a288-30f0-11e6-9614-005056c00001
        5fb1a289-30f0-11e6-9614-005056c00001
        5fb1a28a-30f0-11e6-9614-005056c00001
        5fb1a28b-30f0-11e6-9614-005056c00001
        5fb1a28c-30f0-11e6-9614-005056c00001
        5fb1a28d-30f0-11e6-9614-005056c00001
        5fb1a28e-30f0-11e6-9614-005056c00001
        5fb1a28f-30f0-11e6-9614-005056c00001
        5fb1a290-30f0-11e6-9614-005056c00001

* The V1 UUID generator should work on all app servers
    To achieve this there are no Os locking threads or file system dependant
    storage. The uuid.Saver interface exists for the user to provide their own
    storage implementations. The package provides a uuid.Saver
    which works on a standard OS environment.
* The V4 UUID should allow the user to choose how to handle any error that
can occur in the CPRNG. The default is to panic.
* The package should be able to handle multiple instances of Generator's so a
* user can produce UUIDs from multiple sources.

# Recent Changes

* Added ability for user defined Generator's which can be setup with your own
retrieval functions for a Node Id, Timestamp and Random data for a UUID; more
details in docs.
* Now builds in Windows, OsX and Linux, with test coverage checking and code
quality checks.
* Added V2 UUIDs
* Improved builds and 100% test coverage
* Library overhaul to cleanup exports that are not useful for a user
* Improved and fixed file system uuid.Saver interface, breaking changes.
    To use a uuid.Saver make sure you pass it in via the
    uuid.RegisterSaver(Saver) function before a UUID is generated, so as to
    take affect. This is because only one attempt at system initialisation can
    be attempted.

## Installation

Use the `go` tool:

	$ go get github.com/twinj/uuid

# Typical Usage

See [documentation and examples](http://godoc.org/github.com/twinj/uuid)
for more information.

## All UUIDs

    import "github.com/twinj/uuid"

    id, _ := uuid.Parse("6ba7b810-9dad-11d1-80b4-00c04fd430c8")

    if uuid.Equal(id, uuid.NameSpaceDNS) {
        fmt.Println("Alas these are equal")
    }

    if uuid.Compare(id, uuid.NameSpaceDNS) == 0 {
        fmt.Println("They are also equal")
    }

    if uuid.Compare(id, uuid.NameSpaceX500) == -1 {
        fmt.Println("id < uuid.NameSpaceX500")
    }

    if uuid.Compare(uuid.NameSpaceX50, id) == 1 {
        fmt.Println("uuid.NameSpaceX500 > id")
    }

    // Default Format is FormatCanonical
    fmt.Println(uuid.Formatter(id, uuid.FormatCanonicalCurly))

    uuid.SwitchFormat(uuid.FormatCanonicalBracket)


## Version 1 and 2 UUIDs

    import "github.com/twinj/uuid"

    // An uuid.Init or uuid.Register* function must be called before any V1 or
    // V2 UUIDs, only needs 1 call.
    uuid.Init()

    id := uuid.NewV1()
    fmt.Println(id)
    fmt.Printf("version %s variant %x: %s\n", u1.Version(), u1.Variant(), id)

    id = uuid.NewV2(uuid.DomainUser)
    fmt.Println(id)
    fmt.Printf("version %s variant %x: %s\n", u1.Version(), u1.Variant(), id)

    // If you wish to register a saving mechanism to keep track of your UUID
    // It is recommeneded to add a Saver so as to reduce risk in UUID
    // collisions
    saver := new(savers.FileSystemSaver)
    saver.Report = true
    saver.Duration = time.Second * 3

    // Must be called before any V1 or V2 UUIDs. Do not call uuid.Init if
    // registering a Saver
    uuid.RegisterSaver(saver)

## Version 3 and 5 UUIDs

    import "github.com/twinj/uuid"

    // Does not need to be called first but is recommended
    uuid.Init()

    id := uuid.NewV3(uuid.NameSpaceURL, uuid.Name("www.example.com"))
    fmt.Println(id)
    fmt.Printf("version %s variant %x: %s\n", u1.Version(), u1.Variant(), id)

    id := uuid.NewV5(uuid.NameSpaceURL, uuid.Name("www.example.com"))
    fmt.Println(id)
    fmt.Printf("version %s variant %x: %s\n", u1.Version(), u1.Variant(), id)

    id = uuid.NewV5(uuid.NameSpaceURL, id)
    fmt.Println(id)
    fmt.Printf("version %s variant %x: %s\n", u1.Version(), u1.Variant(), id)

## Version 4 UUIDs

    import "github.com/twinj/uuid"

    // Does not need to be called first but is recommended
    uuid.Init()

    // A V4 UUID will panic by default if the systems CPRNG fails - this can
    // be changed by registering your own generator
    u4 := uuid.NewV4()
    fmt.Println(id)
    fmt.Printf("version %d variant %x: %s\n", u4.Version(), u4.Variant(), u4)

## Custom Generators

    import "github.com/twinj/uuid"

    // Improve resolution for V1 and 2 UUIDs
    // The resolution correlates to how many ids can be created before waiting
    // for the next unique timestamp. The default is a low 1024, this equates
    // to Ids that can be created in 100 nanoseconds. It is low to encourage
    // you to set it.
    uuid.RegisterGenerator(GeneratorConfig{Resolution: 18465})

    // Provide your own node Id or MAC address
    uuid.RegisterGenerator(GeneratorConfig{
        Id: func() uuid.Node{
            // My Node Id
            // If this returns nil a random one will be generated
        },
    })

    // Replace the default Timestamp spinner with your own.
    uuid.RegisterGenerator(GeneratorConfig{
        Next: func()(uuid.Timestamp){
            // My own Timestamp function...
            // Resolution will become reduendant if you set this.
            // The package will increment the clock sequence if you produce equal Timestamps
        },
    })

    // Replace the default crypto/rand.Read CPRNG with your own.
    uuid.RegisterGenerator(GeneratorConfig{
        Random: func([]byte)(int, error){
            // My CPRNG function...
        },
    })

    // Replace the default error handler for V4 UUIDs. This function is called
    // when there is an error in the CPRNG. The default function causes a panic.
    // You can change that behaviour and handle the error by checking for nil
    // on a NewV4() call.
    //  id := NewV4()
    //  if id == nil {
    //      err := uuid.Error()
    //      // handle error
    //  }
    // Trying again could fix the problem. Errors could be due to a lack of
    // system entropy or some other serious issue. These issues are rare,
    // however, having the tools to handle such issues is important.
    // This approach was taken as each user of this package will want to handle
    // this differently.
    uuid.RegisterGenerator(GeneratorConfig{
        HandleError: func(error)bool{
            // My HandleError function...
            // If this returns true the V4 generator will try again - if it
            //      fails again the NewV4() function will exit with a nil
            // If this returns false the NewV4() function will exit with a nil
        },
    })
    
    // You can also just manage your own completely.
    gen := NewGenerator(GeneratorConfig{})
    
    id := gen.NewV4()
    

## Coverage

* go test -coverprofile cover.out github.com/twinj/uuid
* go tool cover -html=cover.out -o cover.html

## Links

* [RFC 4122](http://www.ietf.org/rfc/rfc4122.txt)
* [DCE 1.1: Authentication and Security Services](http://pubs.opengroup.org/onlinepubs/9629399/apdxa.htm)

## Copyright

Copyright (C) 2016 twinj@github.com
See [LICENSE](https://github.com/twinj/uuid/tree/master/LICENSE)
file for details.
