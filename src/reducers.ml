open ReducTypedStructs;;

let combine_reducers reducers state action =
  ReducerMap.mapi (fun k reducer ->
    reducer (ReducerMap.find k state) action
  ) reducers;;
