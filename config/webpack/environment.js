const { environment } = require('@rails/webpacker')
const customConfig = require('./alias');

environment.config.merge(customConfig);

module.exports = environment;
