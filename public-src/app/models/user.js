import DS from 'ember-data';

export default DS.Model.extend({
	email : DS.attr('string'),
	user_type : DS.attr('string'),
	school : DS.attr('string')
});
