open OUnit2;;
open ReducTyped.Store;;

type operation_action =
  | Add of float
  | Multiply of float;;

let reducer state action = 
  match action with
  | Add x -> state +. x
  | Multiply x -> state *. x;;

let creation_test test_ctxt =
  let store = create_store reducer 0.0 in
  assert_equal (store.get_state ()) 0.0;;

let dispatch_and_get_test test_ctxt =
  let store = create_store reducer 0.0 in
  store.dispatch (Add 1.0);
  assert_equal (store.get_state ()) 1.0;
  store.dispatch (Add 1.0);
  store.dispatch (Multiply (-2.0));
  assert_equal (store.get_state ()) (-4.0);;

let store_listeners test_ctxt =
  let listener1_called = ref false
  and listener2_called = ref false
  and listener3_called = ref false
  and store = create_store reducer 0.0 in
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

let storeSuite = "store">:::[
  "creation">:: creation_test;
  "dispatch and get_state">:: dispatch_and_get_test;
  "subscribe and unsubscribe">:: store_listeners;
];
