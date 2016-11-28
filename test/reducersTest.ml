open OUnit2;;
open ReducTyped.Reducers;;

type action =
  | Increment
  | Decrement;;

let combine_reducers_test test_ctxt =
  let reducers = ReducerMap.empty in
  let reducers = ReducerMap.add "value" (fun value action ->
    match action with
    | Increment -> value + 1
    | Decrement -> value - 1
  ) reducers in
  let reducers = ReducerMap.add "op_count" (fun count action ->
    count + 1
  ) reducers in
  let reducer = combine_reducers reducers in
  let state = StateMap.empty in
  let state = StateMap.add "value" 1 state in
  let state = StateMap.add "op_count" 1 state in
  let newState = reducer state Decrement in
  assert_equal (StateMap.find "value" newState) 0;
  assert_equal (StateMap.find "op_count" newState) 2;;

let reducersSuite = "reducers">:::[
  "combine_reducers">::combine_reducers_test;
];
