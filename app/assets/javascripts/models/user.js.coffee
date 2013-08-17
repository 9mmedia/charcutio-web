CharcutioWeb.User = DS.Model.extend
  name: DS.attr('string')
  email: DS.attr('string')
  password: DS.attr('string')
  authToken: DS.attr('string')
