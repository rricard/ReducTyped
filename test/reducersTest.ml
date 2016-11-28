open OUnit2;;
open ReducTypedStructs;;
open ReducTyped.Reducers;;

type action =
  | Increment
  | Decrement;;

let combine_reducers_test test_ctxt =
  let reducers = ReducerMap.(
    empty |>
    add "value" (fun value action ->
      match action with
      | Increment -> value + 1
      | Decrement -> value - 1
    ) |>
    add "op_count" (fun count action ->
      count + 1
    )
  ) in
  let reducer = combine_reducers reducers in
  let state = ReducerMap.(
    empty |>
    add "value" 1 |>
    add "op_count" 1
  ) in
  let newState = reducer state Decrement in
  ReducerMap.(
    assert_equal (find "value" newState) 0;
    assert_equal (find "op_count" newState) 2
  );;

let reducersSuite = "reducers">:::[
  "combine_reducers">::combine_reducers_test;
];
