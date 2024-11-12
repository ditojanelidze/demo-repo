fishing_methods = [
  {id: 1, name: "სპინინგი"},
  {id: 2, name: 'დომკა'}
]

fish_species = [
  {id: 1, name: 'ქორჭილა'},
  {id: 2, name: 'შამაია'}
]

fishing_methods.each do |method|
  FishingMethod.find_or_initialize_by(id: method[:id]).update(name: method[:name])
end

fish_species.each do |specie|
  FishSpecie.find_or_initialize_by(id: specie[:id]).update(name: specie[:name])
end