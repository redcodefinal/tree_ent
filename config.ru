require "./lib/tree_ent"

TreeEnt.start do
  switch :light1, 3
  switch :light2, 4
  switch :light3, 5
  switch :light4, 6
  switch :fan1, 7
  switch :fan2, 8
  switch :fan3, 9
end

run TreeEnt::Server