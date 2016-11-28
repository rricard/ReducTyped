# ReducTyped

Correctly typed state management for OCaml inspired by [Redux](http://redux.js.org/).

## Usage example

First, define your application's state and action type:

```ocaml
type action =
  | Add of float
  | Multiply of float;;

type state = float;;
```

Then, you can define a reducer with the signature `state -> action -> state`:

```ocaml
let reducer state action = 
  match action with
  | Add x -> state +. x
  | Multiply x -> state *. x;;
```

From there, you can initialize a store (you have to provide an initial value):

```ocaml
let store = Store.createStore reducer 0.0;;
```

Finally, you can now dispatch actions into your store:

```ocaml
store.dispatch (Add 1.5);;
store.dispatch (Multiply 2.0);;
assert ((store.get_state ()) = 3.0);;
```

You can also subscribe callbacks to store changes:

```ocaml
let unsubscribe_listener = store.subscribe (fun () ->
  print_string (string_of_float (store.get_state ()))
);;
```

And unsubscribe at any time:

```ocaml
unsubscribe_listener ();;
```

## Installation

You can use [OPAM](https://opam.ocaml.org) to install this package. I'll try to provide a [CommonML](https://github.com/jordwalke/CommonML) vesion soon!

First, you will need to pin the repository:

```sh
opam pin add -y reducTyped git@github.com:rricard/ReducTyped.git
```

And then, you will be able to install it:

```sh
opam install reducTyped
```

## Roadmap

Keep in mind this is for now a toy project with no real-world use yet! I'm just starting with OCaml and implementing a Redux-like system is perfect to understand the key concepts of the language!

However, I think it'll be relevant fast: [Reason](https://facebook.github.io/reason/) will soon be able to support [React](https://facebook.github.io/react/) and having a strongly typed Redux-like setting would be great to code app state management.

That's why I will try to commit to the following roadmap at least:

- [x] Implement the core of the system a "reducable" store
- [ ] Implement reducer utilities such as `combine_reducers`
- [ ] Implement a middleware system

I'm also open to pull requests if you wnat to help, and don't hesitate to post issues if you see something wrong!
