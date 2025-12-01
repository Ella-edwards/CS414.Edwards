(* ocaml/monads.ml *)

module type MONAD = sig
  type 'a t
  val return : 'a -> 'a t
  val bind   : 'a t -> ('a -> 'b t) -> 'b t
  val map    : ('a -> 'b) -> 'a t -> 'b t
end

module Make_infix (M : MONAD) = struct
  let ( >>= ) = M.bind
  let ( let* ) = M.bind      (* for let-operators *)
  let ( >|= ) m f = M.map f m
end

(* Option monad *)
module OptionM : MONAD = struct
  type 'a t = 'a option
  let return x = Some x
  let bind m f = match m with None -> None | Some x -> f x
  let map f m = match m with None -> None | Some x -> Some (f x)
end
module O = Make_infix(OptionM)

(* Result monad with string errors *)
module ResultM : MONAD = struct
  type 'a t = ('a, string) result
  let return x = Ok x
  let bind m f = match m with Error e -> Error e | Ok x -> f x
  let map f m = match m with Error e -> Error e | Ok x -> Ok (f x)
end
module R = Make_infix(ResultM)

(* List monad (nondeterminism) *)
module ListM : MONAD = struct
  type 'a t = 'a list
  let return x = [x]
  let bind xs f = List.concat (List.map f xs)
  let map f xs = List.map f xs
end
module L = Make_infix(ListM)

(* Helpers used in examples *)
let safe_div_opt a b =
  if b = 0 then None else Some (a / b)

let safe_div_result a b =
  if b = 0 then Error "division by zero" else Ok (a / b)

(* Compose three divisions (((x / y) / z) / 2) -- returns option *)
let triple_div_opt x y z =
  (* using let* (bind) from Option *)
let safe_div3 x y z =
  let open O in
  let* a = safe_div_opt x y in
  let* b = safe_div_opt a z in
  let* c = safe_div_opt b 2 in
  return c

(* Same with result monad reporting string error *)
let triple_div_result x y z =
  let open R in
  let* a = safe_div_res x y in
  let* b = safe_div_res a z in
  let* c = safe_div_res b 2 in
  return c

(* A small pythagorean triple generator (naive) *)
let pythagorean_loops n =
  let triples = ref [] in
  for a = 1 to n do
    for b = a to n do
      for c = b to n do
        if a*a + b*b = c*c then triples := (a,b,c) :: !triples
      done
    done
  done;
  !triples
(* ocaml/monads.ml *)

module type MONAD = sig
  type 'a t
  val return : 'a -> 'a t
  val bind   : 'a t -> ('a -> 'b t) -> 'b t
  val map    : ('a -> 'b) -> 'a t -> 'b t
end

module Make_infix (M : MONAD) = struct
  let ( >>= ) = M.bind
  let ( let* ) = M.bind      (* for let-operators *)
  let ( >|= ) m f = M.map f m
end

(* Option monad *)
module OptionM : MONAD = struct
  type 'a t = 'a option
  let return x = Some x
  let bind m f = match m with None -> None | Some x -> f x
  let map f m = match m with None -> None | Some x -> Some (f x)
end
module O = Make_infix(OptionM)

(* Result monad with string errors *)
module ResultM : MONAD = struct
  type 'a t = ('a, string) result
  let return x = Ok x
  let bind m f = match m with Error e -> Error e | Ok x -> f x
  let map f m = match m with Error e -> Error e | Ok x -> Ok (f x)
end
module R = Make_infix(ResultM)

(* List monad (nondeterminism) *)
module ListM : MONAD = struct
  type 'a t = 'a list
  let return x = [x]
  let bind xs f = List.concat (List.map f xs)
  let map f xs = List.map f xs
end
module L = Make_infix(ListM)

(* Helpers used in examples *)
let safe_div_opt a b =
  if b = 0 then None else Some (a / b)

let safe_div_result a b =
  if b = 0 then Error "division by zero" else Ok (a / b)

(* Compose three divisions (((x / y) / z) / 2) -- returns option *)
let triple_div_opt x y z =
  (* using let* (bind) from Option *)
  let open O in
  let* a = safe_div_opt x y in
  let* b = safe_div_opt a z in
  let* c = safe_div_opt b 2 in
  return c

(* Same with result monad reporting string error *)
let triple_div_result x y z =
  let open R in
  let* a = safe_div_result x y in
  let* b = safe_div_result a z in
  let* c = safe_div_result b 2 in
  return c

(* A small pythagorean triple generator (naive) *)
let pythagorean_loops n =
  let triples = ref [] in
  for a = 1 to n do
    for b = a to n do
      for c = b to n do
        if a*a + b*b = c*c then triples := (a,b,c) :: !triples
      done
    done
  done;
  !triples
