CharcutioWeb.SignInRoute = Ember.Route.extend
  events: 
    submitLogin: (event) ->
      form = $('#login-form')
      email = form.find('input[name="email"]').val()
      password = form.find('input[name="password"]').val()

      CharcutioWeb.Auth.signIn
        data:
          email: email
          password: password
