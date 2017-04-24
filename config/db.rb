Mongoid.load!(File.expand_path('../mongoid.yml', __FILE__))

Mongoid.raise_not_found_error = false

Mongoid.logger.level = Logger::ERROR
Mongo::Logger.logger.level = Logger::ERROR
