angular.module('PokemonClub').factory('API', ['$http', ($http) ->
    ###
    API Factory:
    This Factory abstracts all interactions with the Pokemon Club API. All
    http calls to the pokemon club API should be routed through this factory,
    and not handled in any controller.
    ###
    self = this
    url = $$url

    object_to_key = (data) ->
        ###
        Django has a particular syntax for handling foreign key relations, if
        you pass just the name of the foreign key, say 'base', Django will
        expect you are giving it an object, not just a key's id. If it is given
        'base_id' however, it will understand you are giving it a key
        reference. This ensures Django understands what it is receiving, that
        is id keys, not actual model objects.
        @data: Expects an object.
        @return: The provided object with existing foreign key fields convered
                 for id based lookup in the API.
        ###
        keys = ['base', 'trainer', 'ball', 'held_item', 'move_1', 'move_2',
                'move_3', 'move_4']
        data["#{k}_id"] = data[k] if data[k] for k in keys
        return data


    return {
        ability_index: () ->
            ###
            Index Ability route hander
            @return: A promise for the index of all abilities.
            ###
            return $http.get(url + 'ability/')


        ability_detail: (id) ->
            ###
            Detail Ability route hander
            @id: The abilities primary key, expects an integer.
            @return: A promise for the detail of the given ability.
            ###
            return $http.get(url + "ability/#{id}/")


        egg_group_index: () ->
            ###
            Index Egg Group index route handler
            @return: A promise for the index of all egg groups.
            ###
            return $http.get(url + 'egg_group/')


        egg_group_detail: (id) ->
            ###
            Egg Group detail route handler
            @id: The egg groups primary key, expects an integer.
            @return: A promise for the detail of the given egg group.
            ###
            return $http.get(url + "egg_group/#{id}/")


        item_index: () ->
            ###
            Item index route hander
            @return: A promise for index of all items.
            ###
            return $http.get(url + 'item/')


        item_detail: (id) ->
            ###
            Item detail route handler
            @id: The item's primary key, expects an integer.
            @return: A promise for the detail of the given item.
            ###
            return $http.get(url + "item/#{id}/")


        location_index: () ->
            ###
            Location index route handler
            @return: A promise for the index of all locations.
            ###
            return $http.get(url + 'location/')


        location_detail: (id) ->
            ###
            Location detail route handler
            @id: The location's primary key, expects an integer.
            @return: A promise for the detail of the given location.
            ###
            return $http.get(url + "location/#{id}/")


        pokemon_in_location: (id) ->
            ###
            Pokemon in location handler
            @id: The location's primary key, expects an integer.
            @return: A promise for a list of all pokemon in the specified area.
            ###
            return $http.get(url + "location/#{id}/pokemon/")


        login: (data) ->
            ###
            Login handler
            @data: Expects an object, the following values are legal
                   user_name: string
                   password: string
            @return: A promise for the user's information on a successful
                     login.
            ###
            if(data.userName != '' && data.password != '')
                return $http
                    .post(url + 'user/sign-in/', data)
            else
                console.log('failed')
                return
            return


        move_index: () ->
            ###
            Move index route handler
            @return: A promise for the index of all moves.
            ###
            return $http.get(url + 'move/')


        move_detail: (id) ->
            ###
            Move detail route handler
            @id: The primary key of the move, expects an integer
            @return: A promise for the detail of the given move.
            ###
            return $http.get(url + "move/#{id}/")


        pokemon_index: () ->
            ###
            Pokemon Base index route handler
            @return: A promise for the index of all pokemon base data.
            ###
            return $http.get(url + 'pokemon/')


        pokemon_detail: (id) ->
            ###
            Pokemon Base detail route handler
            @id: The primary key of the given pokemon base, expects an integer.
            @return: A promise for the detail of the given pokemon base.
            ###
            return $http.get(url + "pokemon/#{id}/")


        pokemon_dex_detail: (dex) ->
            ###
            Pokemon Base detail route by pokedex number
            @dex: The pokedex number of the given pokemon, expects an integer.
            @return: A promise for the detail of the given pokemon base.
            ###
            return $http.get(url + "pokemon/dex/#{dex}/")


        pokemon_evo_detail: (id, method) ->
            ###
            Pokemon evolution detail route handler
            @id: The primary key of the given pokemon, expects an integer.
            @method: The method by which the given pokemon would evolve,
                     expects a string.
            @return: A promise for the list of all possible evolutions the
                     given pokemon has by the specified method.
            ###
            return $http.get(url + "pokemon/#{id}/evo/#{method}/")


        pokemon_learn_set: (id, level) ->
            ###
            Pokemon learnset detail route
            @id: The primary key of the given pokemon, expects an integer.
            @level: The upper bound for what moves the given pokemon could know
                    for the return data.
            @return: A promise for a list of up to four moves that the given
                     pokemon would know at the specified level.
            ###
            return $http.get(url + "pokemon/#{id}/learnset/#{level}/")


        old_pokemon_learn_set: (id, level) ->
            ###
            !!! WARN: DEPRECIATED !!!
            Old pokemon learnset detail route
            @id: The primary key of the given pokemon, expects an integer.
            @level: The upper bound for what moves the given pokemon could know
                    for the return data.
            @return: A promise for a list of up to four moves that the given
                     pokemon would know at the specified level, and it's base
                     data.
            ###
            return $http.get(url + "pokemon/#{id}/level/#{level}/")


        type_index: () ->
            ###
            Type index route handler
            @return: A promise for the index of all types.
            ###
            return $http.get(url + 'type/')


        type_detail: (id) ->
            ###
            Type detail handler
            @id: The primary key of the given type, expects an integer.
            @return: A promise for the detail of the given type.
            ###
            return $http.get(url + "type/#{id}/")


        update_user: (id, data) ->
            ###
            User update route handler
            @id: The primary key of the given user, expects an integer.
            @data: Expects an object. The following fields are valid
                   starts: integer
                   score: integer
                   money: decimal
            @return: A promise for the success state of the update transaction.
            ###
            return $http.patch(url + "user/#{id}/", data)


        user_items: (id) ->
            ###
            User item index route handler
            @id: The primary key of the given user.
            @return: A promise for the index of all the specified users items.
            ###
            return $http.get(url + "user/#{id}/item/")


        user_add_item: (id, data) ->
            ###
            User add item route handler
            @id: The primary key of the given user.
            @data: Expects an object, the following values are legal:
                   count: integer
                   item_id: integer
            @return: A promise for the success or failure of the transaction.
            ###
            return $http.post(url + "user/#{id}/item", data)


        user_item_detail: (id, item_id) ->
            ###
            User item detail route handler
            @id: The primary key of the given user.
            @item_id: The primary key of the given user item.
            @return: A promise for the detail of the specified item.
            ###
            return $http.get(url + "user/#{id}/item/#{item_id}/")


        update_user_item: (id, item_id, data) ->
            ###
            Update user item route handler
            @id: The primary key of the given user.
            @item_id: The primary key of the given user item.
            @data: Expects an objects, the following values are legal:
                   count: integer
            @return: A promise for the success or failure state of the
                     transaction.
            ###
            return $http.patch(url + "user/#{id}/item/#{item_id}/", data)


        delete_user_item: (id, item_id) ->
            ###
            Remove user item route handler
            @id: The primary key of the given user.
            @item_id: The primary key of the given user item.
            @return: A promise for the success or failure state of the
                     transaction.
            ###
            return $http.delete(url + "user/#{id}/item/#{item_id}/")


        user_badge_index: (id) ->
            ###
            User badge index route handler
            @id: The primary key of the given user.
            @return: A promise for the index list of all the specified user's
                     badges.
            ###
            return $http.get(url + "user/#{id}/badge/")


        add_badge: (id, data) ->
            ###
            Badge creation route handler
            @id: The primary key of the given user. Expects an integer.
            @data: Expects an object, the following values are legal:
                   region: integer
                   leader: integer
            @return: A promise for the success or failure state of the
                     transaction.
            ###
            return $http.post(url + "user/#{id}/badge/", data)


        user_pokedex_index: (id) ->
            ###
            User's Pokedex index route handler
            @id: The primary key of the given user. Expects an integer.
            @return: A promise for the index of all the given users pokemon.
            ###
            return $http.get(url + "user/#{id}/pokedex/")


        add_pokedex_entry: (id, data) ->
            ###
            Pokedex entry creation route handler
            @id: The primary key of the given user. Expects an integer.
            @return: A promise for the success or failure state of the
                     transaction.
            ###
            return $http.post(url + "user/#{id}/pokedex/", data)


        user_pokemon_index: (id) ->
            ###
            User Pokemon index route handler
            @id: The primary key of the given user. Expects an integer.
            @return: A promise for the index of all of the specified user's
                     pokemon.
            ###
            return $http.get(url + "user/#{id}/pokemon/")


        user_pokemon_detail: (id, pokemon_id) ->
            ###
            @id: The primary key of the given user. Expects an integer.
            @pokemon_id: The primary key of the users' pokemon.
            @return: A promise for the detail of the specified pokemon of the
                     specified user.
            ###
            return $http.get(url + "user/#{id}/pokemon/#{pokemon_id}/")


        catch_pokemon: (id, data) ->
            ###
            Pokemon catching route handler.
            @id: The primary key of the given user. Expects an integer.
            @data: Expects an object, legal values are:
                   current_hp: integer
                   status: integer
                   hp_IV: integer
                   attack_IV: integer
                   defense_IV: integer
                   sp_attack_IV: integer
                   sp_defense_IV: integer
                   speed_IV: integer
                   hp_EV: integer
                   attack_EV: integer
                   defense_EV: integer
                   sp_attack_EV: integer
                   sp_defense_EV: integer
                   speed_EV: integer
                   nature: string
                   shinyness: integer
                   exp: integer
                   level: integer
                   gender: string
                   happiness: integer
                   storage_location: integer
                   storage_position: integer
                   ball_id: integer
                   base_id: integer
                   nick_name: string
                   form: integer
                   held_item: integer
                   move_1: integer
                   move_2: integer
                   move_3: integer
                   move_4: integer
            @return: A promise for the success for failure state of the
                     transaction.
            ###
            data = object_to_key(data)

            return $http.post(url + "user/#{id}/pokemon/", data)


        update_user_pokemon: (id, pokemon_id, data) ->
            ###
            @id: The primary key of the given user. Expects an integer.
            @pokemon_id: The primary key of the users' pokemon.
            @data: Expects an object, legal values are:
                   current_hp: integer
                   status: integer
                   hp_EV: integer
                   attack_EV: integer
                   defense_EV: integer
                   sp_attack_EV: integer
                   sp_defense_EV: integer
                   speed_EV: integer
                   exp: integer
                   level: integer
                   happiness: integer
                   storage_location: integer
                   storage_position: integer
                   trainer_id: integer
                   held_item: integer
                   move_1: integer
                   move_2: integer
                   move_3: integer
                   move_4: integer
            @return: A promise for the success or failure state of the
                     transaction.
            ###
            data = object_to_key(data)

            return $http.patch(
                url + "user/#{id}/pokemon/#{pokemon_id}/",
                data
            )


        release_user_pokemon: (id, pokemon_id) ->
            ###
            @id: The primary key of the given user. Expects an integer.
            @pokemon_id: The primary key of the users' pokemon.
            @return: A promise for the success or failure state of the
                     transaction.
            ###
            return $http.delete(url + "user/#{id}/pokemon/#{pokemon_id}/")
    }
])
