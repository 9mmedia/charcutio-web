CharcutioWeb.SignUpRoute = Ember.Route.extend
  model: ->
    CharcutioWeb.User.createRecord()
  actions:
    submitRegistration: (record) ->
      console.log('registration')
      console.log(record.toJSON())
      record.save().then =>
        console.log('saved')
