type 'a rose = Node of 'a * 'a rose list

let rec size (Node (_, children)) =
  1 + List.fold_left (fun acc child -> acc + size child) 0 children

let rec map f (Node (value, children)) =
  Node (f value, List.map (map f) children)

let rec fold f (Node (value, children)) =
  let folded_children = List.map (fold f) children in
  f value folded_children