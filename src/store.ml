type listener = unit -> unit;;

type ('stateType, 'actionType) store = {
  state: 'stateType option ref;
  listeners: listener list ref;
  get_state: unit -> 'stateType option;
  dispatch: 'actionType -> unit;
  subscribe: listener -> listener;
};;

let createStore reducer =
  let state = ref None
  and listeners = ref [] in
  {
    state;
    listeners;
    get_state=(fun () -> !state);
    dispatch=(fun action -> (
      (* Deref the state, execute the reducer with it, re-assign it *)
      state := reducer action !state;
      (* Call each listener *)
      List.map (fun l -> l ()) !listeners;
      ();
    ));
    subscribe=(fun listener ->
      (* Cons the listener to the list *)
      listeners := listener :: !listeners;
      (* Return a function to unsubscribe from the listener *)
      (fun () ->
        (* Filter out the listener to unsubscribe *)
        listeners := List.filter (fun l -> l != listener) !listeners;
        ();
      );
    );
  };;
