angular.module('PokemonClub').factory('Exp', [() ->
  ###
  Exp Factory:
  This factory abstracts the math surrounding Pokemon leveling up.
  This is very prototypal and it's API points might change drastically in
  the future.
  ###

  pow = Math.pow
  floor = Math.floor

  @groups = {
    'erratic': (l) ->
      ###
      l <= 50:
      l^3 (100 - l) / 50
      50 <= l <= 68:
      l^3 (150 - l) / 100
      68 <= l <= 98:
      l^3 [(1911 - 10l / 3)] / 500
      98 <= l <= 100:
      l^3 (160 - l) / 100
      ###
      if(l == 1)
        0
      else if(l <= 50)
        floor((pow(l, 3) * (100 - l)) / 50)
      else if(l <= 68)
        floor((pow(l, 3) * (150 - l)) / 100)
      else if(l <= 98)
        floor(pow(l, 3) * (floor(((1911 - (10 * l)) / 3)) / 500))
      else
        floor((pow(l, 3) * (160 - l)) / 100)

    ,'fast': (l) ->
      ###
      4l^3 / 5
      ###
      floor((4 * pow(l, 3)) / 5)

    ,'medium_fast': (l) ->
      ###
      l^3
      ###
      if(l == 1)
        0
      else
        pow(l, 3)

    ,'medium_slow': (l) ->
      ###
      (6/3)l^3 - 15l^2 + 100l - 140
      ###
      if(l == 1)
        0
      else
        floor((((6 / 5) * pow(l, 3)) - (15 * pow(l, 2)) + (100 * l) - 140))

    ,'slow': (l) ->
      ###
      5l^3 / 4
      ###
      if(l == 1)
        0
      else
        floor((5 * pow(l, 3)) / 4)

    ,'fluctuating': (l) ->
      ###
      l <= 15:
      l^3 ((l + 1) / 3) + 24 / 50)
      15 <= l <= 36:
      l^3 (l + 14 / 50)
      36 <= l <= 100:
      l^3 ((l / 2) + 32 / 50)
      ###
      if(l == 0)
        0
      else if(l <= 15)
        floor(pow(l, 3) * (floor((((l + 1) / 3) + 24)) / 50))
      else if(l <= 36)
        floor(pow(l, 3) * ((l + 14) / 50))
      else
        floor(pow(l, 3) * (((l / 2) + 32) / 50))

  }

  return {
    get_next_level_exp: (pokemon) =>
      ###
      @pokemon: Expects an object. That object should be the data of
                a full pokemon object, not just the base data.
      @return: An integer value, representing the amount of exp that
               would be required to get the given pokemon to the next
               level.
      ###
      @groups[pokemon.exp_group](pokemon.level)
  }
])
