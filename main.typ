#import "@preview/touying:0.6.1": *
#import "ltu_touying.typ": *

#show: ltutheme.with(
  aspect-ratio: "16-9",
  config-colors(
    primary: white,
  ),
)

#title-slide(
  subtitle: [D7020E - Robust and Energy Efficient Real-Time Systems],
  title: [1 - Intro],
  authors: [Pawel Dzialo, Prof. Per Lindgren],
)

== Aims/Content/Outcome
#slide[
  - What we cover today:
    - Course Aims
      - Intended Learning Outcomes
    - Content
      - Topics covered
    - Realization
      - The course format
    - Examination
      - The examination and grading
]
== Course Aims and Content
#slide[
  *The student shall be able to:*
]
== Course Aims and Content
#slide[
  *The student shall be able to:*
  #set text(size: 15pt)
  - Demonstrate the ability to perform *model-based* design of *small footprint* (low-powered, low-memory) distributed embedded real-time systems
    - Modelling and analysis of real-time applications under the RTIC framework
    - Power-profiling down to the micro-second/ampere
    - Validation of embedded software by debugging and tracing
]
== Course Aims and Content
#slide[
  *The student shall be able to:*
  #set text(size: 15pt)
  - Demonstrate the ability to perform *model-based* design of *small footprint* (low-powered, low-memory) distributed embedded real-time systems
    - Modelling and analysis of real-time applications under the RTIC framework
    - Power-profiling down to the micro-second/ampere
    - Validation of embedded software by debugging and tracing
  - Demonstrate the ability to develop *memory-safe* implementations
    - Rust, memory safety, ensuring defined behavior, etc.
    - Rust on bare-metal hardware, abstractions and ecosystem
    - Tooling for stack memory usage analysis
]
== Course Aims and Content
#slide[
  *The student shall be able to:*
  #set text(size: 15pt)
  - Demonstrate the ability to perform *model-based* design of *small footprint* (low-powered, low-memory) distributed embedded real-time systems
    - Modelling and analysis of real-time applications under the RTIC framework
    - Power-profiling down to the micro-second/ampere
    - Validation of embedded software by debugging and tracing
  - Demonstrate the ability to develop *memory-safe* implementations
    - Rust, memory safety, ensuring defined behavior, etc.
    - Rust on bare-metal hardware, abstractions and ecosystem
    - Tooling for stack memory usage analysis
  - Apply *formal methods* for *verification* of *functional* and *non-functional* (e.g. real-time) properties of distributed embedded systems.
    - Functional verification and non-functional analysis using symbolic execution
]
== Course Aims and Content
#slide[
  *The student shall be able to:*
  #set text(size: 15pt)
  - Demonstrate the ability to perform *model-based* design of *small footprint* (low-powered, low-memory) distributed embedded real-time systems
    - Modelling and analysis of real-time applications under the RTIC framework
    - Power-profiling down to the micro-second/ampere
    - Validation of embedded software by debugging and tracing
  - Demonstrate the ability to develop *memory-safe* implementations
    - Rust, memory safety, ensuring defined behavior, etc.
    - Rust on bare-metal hardware, abstractions and ecosystem
    - Tooling for stack memory usage analysis
  - Apply *formal methods* for *verification* of *functional* and *non-functional* (e.g. real-time) properties of distributed embedded systems.
    - Functional verification and non-functional analysis using symbolic execution
  - Demonstrate insight into *current research* and development work in the field of embedded and distributed real-time systems, as well as the ability to orally present this knowledge
    - RTIC and Symex
]
== Course Aims and Content
#slide[
  *The student shall be able to:*
  #set text(size: 15pt)
  - Demonstrate the ability to perform *model-based* design of *small footprint* (low-powered, low-memory) distributed embedded real-time systems
    - Modelling and analysis of real-time applications under the RTIC framework
    - Power-profiling down to the micro-second/ampere
    - Validation of embedded software by debugging and tracing
  - Demonstrate the ability to develop *memory-safe* implementations
    - Rust, memory safety, ensuring defined behavior, etc.
    - Rust on bare-metal hardware, abstractions and ecosystem
    - Tooling for stack memory usage analysis
  - Apply *formal methods* for *verification* of *functional* and *non-functional* (e.g. real-time) properties of distributed embedded systems.
    - Functional verification and non-functional analysis using symbolic execution
  - Demonstrate insight into *current research* and development work in the field of embedded and distributed real-time systems, as well as the ability to orally present this knowledge
    - RTIC and Symex
  - Demonstrate the ability to understand and work with existing source code and *conduct peer-reviews*
    - We conduct peer reviews of each other's lab solutions
]

== Realization
#slide[
  #set text(size: 18pt)
  - In other words: Lots to do!

  - Teaching consists of lectures and laboratory work
    - Laboratory work done through
      - Practical demonstrations
      - Answering questions
      - Conducting peer reviews
      - Because of peer reviews, labs have a pretty hard deadline - please turn in on time!
    - Lectures
      - 9 slide sets
      - I'm taking over lectures for this year, lesser revamp of the slides, released as we go
      - We follow the general outline from previous years, check old slides to see the future
      - Typically 1-2 lectures per week, 1 lab session per week
      - We aim to get through the lectures by early December
      - This is to allow exchange students to finish in time, also to give you time for the labs (these will take time)
]

== Realization
#slide[
  - We aim for lectures on Mondays and Thursdays
    - Check your schedules for collisions
    - Later down the line, we use all the available class time for lectures until we have gotten through the slides
  - We use Discord for course communication
    - This is to keep information public, and enable us to message in real-time
    - I'm available 24/7 (except before noon)
]

== Examination
#slide[
  - Continuous examination through git peer reviews (similar to D0011E, D0013E)
    - Turn in lab on Wednesday, get assigned peer reviews
    - Turn in peer reviews on Friday
    - Address peer reviews, final submission Monday(recommended)

  - Grade 3 if passing all mandatory labs

  - Further grades - home examination
    - Pick a topic of interest within scope of the course, develop a demonstrator
]

== Why? The automotive perspective
#slide[
  - Combustion engines require 3 things
    - Air, Fuel, Spark
  - The better we time the spark, the more of of power stroke actually produces power
  - Let's control the spark with a computer
  - 80's Electronic Ignition Control
  - Controls timing of spark relative to piston Top Dead Center
  - Best case: improved power efficiency
  - Worst case: engine knock, premature wear and failure
]

== Why? The automotive perspective
#slide[
  #set align(center)
  #image("img/ignition_ctl_240.png", height: 100%)
]

== Why? The automotive perspective
#slide(composer: (1fr, 1fr))[
  #set text(size: 19pt)
  - That went well, 240 engines are famous for being generally bulletproof.
    - What's next? Let's try fuel
  - End of 80's-beginning of 90's - lambdasond
  - Computer controls fuel injection relative to oxygen ratio in exhaust gas (measured by lambdasond)
  - Prevents running rich/lean, improving efficiency, exhaust emissions profile
  - Worst case: the benefits, but the opposite
][
  #image("img/240.png")
]

== Why? The automotive perspective
#slide[
  #set text(size: 19pt)
  - So far so good, last step is air
  - Originally, gas pedal is mechanically coupled to the throttle
  - Electronic Throttle Control System(ETCS)
    - Gas pedal is now a position sensor
    - ETCS takes input from multiple sensors  and tries to decide on actual driver intention, and controls the throttle accordingly
  - Simplifies driver assist e.g. traction control
  - What's the worst case?

][
  #set align(horizon)
  #image("img/etcs.png")
]

== Why? The automotive perspective
#slide[
  #set text(size: 19pt)
  - The computer can hold the throttle open *against driver intention*
  - Toyota Unintended Acceleration(UA) kills 89+
  - ETCS never definitively proven to be the culprit
    - *Many* issues were discovered in investigation
  - More on this in lecture by Prof. Koopman https://www.youtube.com/watch?v=DKHa7rxkvK8

][]

== Why? The automotive perspective
#slide[
  #set text(size: 19pt)
  - Now what? Surely we reevaluate?
]

== Why? The automotive perspective
#slide[
  #set text(size: 18pt)
  - Now what? Surely we reevaluate?
    - Yes and no...

  - Standards e.g., ISO 26262 define concrete processes for developing (safe) automotive software.

  - Modern cars consist of 100's of Electronic Control Units(ECUs)
    - Everything from throttle control to infotainment
    - This increases room for error

  - The amount of safety critical safety systems is growing
    - So is the demand for competent engineers (this is you guys)
][
  #image("img/volvo_arch.png")
]

== Why? The automotive perspective
#slide[
  #set text(size: 19pt)
  - Volvo 240 is relatively *secure*
    - Malicious actors require physical access to the vehicle to cause harm
  - As of 2018, eCall is *required* for _type approval_
    - Type approval is required for a car to be considered road-legal (at least in EU)
    - eCall piggybacks off the cellular network
    - This opens potential attack surface, means we need mechanisms for deploying patches etc.
  - Whether we like it or not, cars are now IoT devices, and cybersecurity is an issue
    - Further standards related cybersecurity, e.g. IEC 21434, now more or less required for type approval
      - This means more competence demand within this field is incoming
]
== Grand Scheme of Things
#slide[
  #image("img/iot_old.png")
][
  #image("img/iot_new.png")
]

== Grand Scheme of Things
#slide[
  By the year 2035, spending on IoT hardware and services will reach a trillion dollars per annum.

  This level of investment supports our view
  that a trillion IoT devices will be produced
  within the next twenty years.

  Source: ARM
][
  #image("img/arm_softbank.png")
]

== Memory Safety and Security
#slide[
  #image("img/microsoft.png")
  Microsoft Security Response Center
]
== Known Exploited Vulnerabilities
#slide[
  #set align(center)
  #image("img/KEV.png")
]
== Why?
#slide[
  - Memory safe languages around for 20+ years
    - Java
    - Golang
  - Operating Systems (Linux, Windows) also ensure some separation
    - Recall segfault
    - This means our memory unsafety is (to some extent) contained to our process
  - Not applicable in some contexts
    - Performance critical, systems level (OS or bare-metal embedded)
  #image("img/segfault.png")
]
== Why?
#slide[
  #set text(size: 19pt)
  - Rust - memory safety with no OS or Garbage Collection(GC)
    - This means, applicable to systems-level context

  - Around in some form since 2015

  - Ten years is a mighty short time
    - Official guidelines are recent (e.g. Biden admin in 2024)
    - C/C++ have been around since 1980's
    - Pushback from C developers - memory safety is a skill issue (see Linux kernel)

  - Barrier of entry to Rust is tricky
    - It's easier to write *safe* implementations
    - It's harder to write *any* implementations
    - One might *trick* themselves their C/C++ program is safe, in Rust this is *impossible*
    - Bottom-line, again, this is a question of competence (*you*)
]

== Rust
#slide[
  - Catches most *undefined behavior* (*UB*) at compile-time
    - Memory unsafety is a member of this set
    - Ownership and borrowing (more on this later)
  - In cases where this is hard to decide at compile-time, inject run-time checks
    - Indexing an array with a variable index, e.g. a[i], where i is unknown
    - Division by zero, e.g. a/b where b is unknown
  - Run-time errors lead to *panic*
    - Through this, Rust ensures *defined behavior* for (_safe_) code (more on _unsafe Rust_ later)
]

== Program Correctness
#slide[
  - Think about input/output relationship of our program
  - *Total correctness* *iff* this relationship *always holds*
  - Really relates to two properties
    - *Safety*, i.e. nothing bad will happen (we never get incorrect output given defined input)
    - *Liveness*, i.e. _something_ will _eventually_ happen
    - These two together - something good will eventually happen
  - Rust makes sure _some_ input/output relationship is defined for a program, already at the language level
  - It is up to us to ensure the *functional safety* of this relationship (e.g. the throttle follows the position of the gas pedal)
  - What about liveness? (recall *panic*)
]

== Liveness ruined by panic
#slide[
  - *Availability*, i.e. mean time between failures

  - Panic may be hard/impossible to recover from
    - If condition causing panic is external/doesn't change
    - Panic - reboot - panic again - reboot ...

  - Safety critical applications require high *availability*
    - It doesn't help us that brakes failed due to panic and not undefined behaviour
    - So what can we do?
]

== Mitigating risk for panic
#slide[
  #set raw(theme: "halcyon.tmTheme")
  - Rust panic is *last resort* for avoiding UB
  - The developer(programmer) may resort to:
    - *Abstractions*, i.e. iterators instead of raw array indexing
    - Guards around dangerous operations, e.g.
      - ```Rust let b = if a != 0 {100/a} else {100}```
  - These reduce the risk, however *no guarantees*
    - How do we *know* we've covered *all* dangerous operations?
    - So what do we do?
]

== Traditional testing
#slide[
  #set text(size: 18pt)
  - The developer may manually write:
    - *Unit* tests, for individual units of code
    - *Integration* tests, for composition of these units
    - *Fail* tests, for handling of expected errors
  - Rust offers a _batteries included_ testing framework
  - Tests quality is typically measured by _coverage_
    - Percentage of lines of code covered by the tests
][
  #set raw(theme: "halcyon.tmTheme")
  ```rs
  #[test]
  fn my_test() {
    assert_eq!(my_func(4), 3);
  }
  ```
  ```bash
  $> cargo test
  ```
]

== Traditional testing
#slide[
  - Pros:
    - Well understood approach
    - Easily integrated into automatic workflows, e.g. CI
  - Cons:
    - Only *reduces* the risk
    - Hard to know whether the test cases are actually covering all relevant paths and states
    - Even 100% code coverage may not be enough
]

== Fuzzing and prop-test
#slide[
  #set text(size: 23pt)
  - Libraries and tools for test generation
    - Automatic approach, quite exhaustive testing with low developer effort
  - Fuzzing
    - "Smart" test randomization
  - Property based testing
    - Similar to fuzzing, here we may give some constraints from which random input should be pulled
  - No way of distinguishing *unreachable* code from *insufficient* testing
    - Not touching a line of code may mean it is unreachable, may also mean we aren't trying hard enough
    - Again, no way of knowing
]

== Symbolic execution
#slide[
  - Dynamic analysis based on formal methods (Satisfiability theory)
    - Dynamic here means we actually run the code
  - We avoid explicitly enumerating input values
    - Instead we introduce constraints on them according to path constraints
    - Symbolic executor (more on this later)
  - Using symbolic execution we can *prove* the absence of *panic*
  - A program free of panics has well-defined behavior
    - Recall, we dodge undefined behavior by instead panicking
    - If there is no panic, we know no such case exists
    - Huge improvement to *trust*, *safety* and *liveness*
]

== Functional correctness via symbolic execution
#slide[
  - We can introduce bounds on input/output/variable state through *assertions*
  #set raw(theme: "halcyon.tmTheme")
  - E.g. ```rust assert!(x < 255) ```
  - Assertions panic whenever broken
  - By proving no panic we can show that assserted properties will *always* hold
  - This is similar to how Rust ensures defined behavior at run-time (injected assertions)
    - By showing no panic, we can omit these checks, improving performance
]

== Symbolic execution
#slide[
  - Is this too good to be true?

  - Complexity means analysis is harder
    - Logical expressions may end up too difficult to solve
    - Exponential growth of paths through code

  - Bare-metal embedded is typically simple
    - Control flow complexity is generally seen as anti-pattern

  - Symbolic execution failed?
    - Back to the drawing board...
]

== Symbolic execution
#slide[
  - We will later discuss
    - The theory behind this
      - First-order logic, Satisfiability Modulo Theories(SMT)
    - Practical implementations
      - Symex(thesis work, LTU)
      - KLEE(part of the LLVM project)
    - Get some hands-on experience
]

== Stack
#slide[
  - Rust comes with the guarantee to either
    - Run with defined behavior
    - Panic
  - This does *not* include overrunning the allocated stack memory (stack overflow)
    - In a pathological case we may start overwriting our heap
    - This leads to *undefined behavior*, breaking the Rust guarantees
]

== Stack
#slide[
  - In this course we will look at:
    - Run-time stack usage analysis
    - Static (compile-time) analysis
      - Numbers reported by LLVM and call graph analysis, or
      - Execution analysis through symbolic execution
]

== Todo now!
#slide[
  - Join the course Discord
    - We use this for *all* communication related to the course
    - Link in Canvas

  - Check your schedule for collisions
]

== Todo until next session
#slide[
  - Recommended:
    - Prepare a Linux installation
      - I use Arch, so if you expect needing help, this is the easiest option

  - Required:
    - Install Rust toolchain
      - Running through chapter 1 of Rust book results in a set up and tested Rust development environment
      - https://doc.rust-lang.org/book/ch01-01-installation.html
      - Do not use your system package manager for this, it complicates things later down the line

]
