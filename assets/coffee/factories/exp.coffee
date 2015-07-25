angular.module('PokemonClub').factory('Exp', [() ->
    ###
    Exp Factory:
    This factory abstracts the math surrounding Pokémon leveling up.
    This is very prototypal and it's API points might change drastically in
    the future.
    ###
    self = this
    self.groups = {
        'erratic': (level) ->
            if(level == 1)
                return 0
            else if(level <= 50)
                return Math.floor((Math.pow(level, 3) * (100 - level)) / 50)
            else if(level <= 68)
                return Math.floor((Math.pow(level, 3) * (150 - level)) / 100)
            else if(level <= 98)
                return Math.floor(
                    Math.pow(level, 3) * (Math.floor(
                        ((1911 - (10 * level)) / 3)
                    ) / 500)
                )
            else
                return Math.floor((Math.pow(level, 3) * (160 - level)) / 100)

        ,'fast': (level) ->
            return Math.floor((4 * Math.pow(i, level)) / 5)

        ,'medium_fast': (level) ->
            if(level == 1)
                return 0
            else
                return Math.pow(level, 3)

        ,'medium_slow': (level) ->
            if(level == 1)
                return 0
            else
                return Math.floor(
                    ((6 / 5) * Math.pow(level, 3)) - (15 * Math.pow(level, 2) +
                    (100 * level) - 140)
                )

        ,'slow': (level) ->
            if(level == 1)
                return 0
            else
                return Math.floor((5 * Math.pow(level, 3)) / 4)

        ,'fluctuating': (level) ->
            if(level == 0)
                return 0
            else if(level <= 15)
                return Math.floor(
                    Math.pow(level, 3) * (
                        Math.floor((((level + 1) / 3) + 24)) / 50
                    )
                )
            else if(level <= 36)
                return Math.floor(Math.pow(level, 3) * ((level + 14) / 50))
            else
                return Math.floor(
                    Math.pow(level, 3) * (((level / 2) + 32) / 50)
                )

    }

    return {
        get_level_exp: (pokemon) ->
            return self.groups[pokemon.exp_group](pokemon.level)
    }
])
