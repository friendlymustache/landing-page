import Ember from 'ember';

export default Ember.Controller.extend({
  signed_up : false,
  invalid_email : false,
  invalid_user_type : false,
  prompt : "I'm a...",
	actions : {
		signup : function() {	
      var email = this.get('email');
      var user_type = this.get('user_type');
      var school = this.get('school');
      // Form validations
      var valid = this.validate(email, user_type);     
      // If form valid, submit
      if (valid) {
        ga('send', 'signup');          
        var record = this.store.createRecord('user', {'email' : email, 'user_type' : user_type, 'school' : school});
        record.save();
        this.set('signed_up', true);
      }
		},

    set_user_type : function(user_type) {
      ga('send', 'changed_user_type');                
      var in_school = (user_type === "High Schooler" || user_type === "College Student");
      this.set('in_school', in_school);      
      this.set('user_type', user_type);
    }
	},

  validate : function(email, user_type) {
      var email_valid = this.isEmailValid(email);
      this.set('invalid_email', !email_valid); 
      var user_type_valid = this.isUserTypeValid(user_type);
      this.set('invalid_user_type', !user_type_valid);
      return email_valid && user_type_valid;

  },

  isUserTypeValid : function(user_type) {
    return (user_type != null && user_type !== undefined);
  },

  isEmailValid : function(email) {
    var regex = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
    return (email !== undefined && email.match(regex) != null);
  }
});