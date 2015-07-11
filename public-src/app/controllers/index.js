import Ember from 'ember';

export default Ember.Controller.extend({
  signed_up : false,
  invalid_email : false,
	actions : {
		signup : function(email) {	
      var valid = this.isValid(email);
      this.set('invalid_email', !valid);      
      if (valid) {
        var record = this.store.createRecord('user', {'email' : email});
        record.save();
        this.set('signed_up', true);
      }
		}
	},

  isValid : function(email) {
    var regex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
    return (email.match(regex) != null);
  }
});