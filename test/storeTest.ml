open OUnit2;;
open Store;;

type operation_action =
  | Add of float
  | Multiply of float;;

let reducer state action = 
  match action with
  | Add x -> state +. x
  | Multiply x -> state *. x;;

let storeCreationTest test_ctxt =
  let store = createStore reducer 0.0 in
  assert_equal (store.get_state ()) 0.0;;

let storeDispatchAndGetTest test_ctxt =
  let store = createStore reducer 0.0 in
  store.dispatch (Add 1.0);
  assert_equal (store.get_state ()) 1.0;
  store.dispatch (Add 1.0);
  store.dispatch (Multiply (-2.0));
  assert_equal (store.get_state ()) (-4.0);;

let storeListeners test_ctxt =
  let listener1_called = ref false
  and listener2_called = ref false
  and listener3_called = ref false
  and store = createStore reducer 0.0 in
  store.subscribe (fun () -> 
    listener1_called := true;
    ();
  );
  store.subscribe (fun () -> 
    listener2_called := true;
    ();
  );
  store.subscribe (fun () -> 
    listener3_called := true;
    ();
  ) ();
  store.dispatch (Add 1.0);
  assert_equal !listener1_called true;
  assert_equal !listener2_called true;
  assert_equal !listener3_called false;
  ;;

let storeSuite = [
  "creation">:: storeCreationTest;
  "dispatch">:: storeDispatchAndGetTest;
  "listeners">:: storeListeners;
];
