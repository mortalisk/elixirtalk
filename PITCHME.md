# Elixir

A language for BEAM
(Bogdan's/Björn's Erlang Abstract Machine)

---

## Why Elixir

 - An alternative language for BEAM
 - Additional libraries
 - Tooling

---

## BEAM

 - A virtual machine for Erlang
 - Developed at Ericsson in 1986
 - Made for running telephone switches

---

## Telephone? What?

 - High number of concurrent events
 - Lot's of IO
 - Fault tolerance
 - High uptime requirements
 - Distributed system
 - Low latency requirements

---

## How BEAM achieves this

 - Lightweight processes
   - Can't block the scheduler
 - Communication by messages
   - each process has a message queue
   - send to abstract PID
 - Isolated processes
   - No shared memory
 - Process monitoring and restarting
   - "Let it crash!"
 - Functional
   - Immutable memory
 - Work stealing scheduler

---

## Why learn Elixir (or any BEAM language)

 - Learn new patterns of programming
 - Bring with you this into other projects you work on
 - Any advanced C program contains a crappy, buggy version of BEAM

---

### Like this
