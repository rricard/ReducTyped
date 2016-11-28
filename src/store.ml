type listener = unit -> unit;;

type ('stateType, 'actionType) store = {
  get_state: unit -> 'stateType;
  dispatch: 'actionType -> unit;
  subscribe: listener -> listener;
};;

let create_store reducer initial_state =
  let state = ref initial_state in
  let listeners = ref [] in
  let get_state = (fun () -> !state)
  and dispatch = (fun action ->
    (* Deref the state, execute the reducer with it, re-assign it *)
    state := reducer !state action;
    (* Call each listener *)
    List.iter (fun l -> l ()) !listeners;
    ();
  )
  and subscribe = (fun listener ->
    (* Cons the listener to the list *)
    listeners := listener :: !listeners;
    (* Return a function to unsubscribe from the listener *)
    (fun () ->
      (* Filter out the listener to unsubscribe *)
      listeners := List.filter (fun l -> l != listener) !listeners;
      ();
    );
  ) in
  { get_state; dispatch; subscribe; };;
