open OUnit2;;
open StoreTest;;

let suite =
"store">:::storeSuite;;

let () = run_test_tt_main suite;;
