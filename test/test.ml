open OUnit2;;
open StoreTest;;
open ReducersTest;;

let suite =
  "reducTyped">::: [
    storeSuite;
    reducersSuite;
  ];;

let () = run_test_tt_main suite;;
