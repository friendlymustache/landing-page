import DS from 'ember-data';
import config from 'startup/config/environment';


export default DS.ActiveModelAdapter.extend({
	host: config.host
});
