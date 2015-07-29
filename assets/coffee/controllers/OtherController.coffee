angular.module('PokemonClub').controller('OtherController', () ->
  self = this
  self.tip = 'this should be in the console!'

  self.test = () ->
    console.log(self.tip)
  return
)
