angular.module('PokemonClub').controller('HomeController', ['API', (API) ->
  self = this
  self.form = {userName: '', password: ''}

  self.test = () ->
    console.log(self.form)

  self.login = () ->
    if(self.form.userName != '' && self.form.password != '')
      console.log('this should login')
      API.login(self.form).then(
        (response) ->
          console.log(response.data)
        ,(error) ->
          console.log(error)
      )
    else
      console.log('failed')
  return
])
