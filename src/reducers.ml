module ReducerMap = Map.Make(String);;
module StateMap = ReducerMap;;

let combine_reducers reducers state action =
  ReducerMap.mapi (fun k reducer -> reducer (StateMap.find k state) action) reducers;;
