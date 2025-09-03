(* Peano addition *)
let rec add x y =
  match x with
  | Z -> y
  | S x_prev -> S (add x_prev y)


(* Peano multiplication *)
let rec mul x y =
  match x with
  | Z -> Z
  | S x_prev -> add y (mul x_prev y)


(* Subtraction: x - y, but clamp to Z if result < 0 *)
let rec sub x y =
  match x, y with
  | x, Z -> x
  | Z, _ -> Z
  | S x_prev, S y_prev -> sub x_prev y_prev


(* Division: x / y (integer division) *)
let rec div x y =
  match x, y with
  | _, Z -> failwith "Division by zero"
  | Z, _ -> Z
  | _, _ ->
      if to_int x < to_int y then Z
      else S (div (sub x y) y)


(*--test--*)
let two = of_int 2
let three = of_int 3
let six = mul two three      (* 2 * 3 = 6 *)
let q = div (of_int 7) (of_int 2)  (* 7 / 2 = 3 *)

let () =
  Printf.printf "2 + 3 = %d\n" (to_int (add two three));
  Printf.printf "2 * 3 = %d\n" (to_int six);
  Printf.printf "7 / 2 = %d\n" (to_int q);
