# MAKEFILE

# Makefile define tasks you can do with the db/
# project you've just cloned.


REDIS_OPTS	= ""
MONGO_OPTS	= "--dbpath ./mongodb/"
SDKIQ_OPTS	= ""
RAILS_OPTS	= "s"


#					Redis Controls							#
#############################################################
# >>> make redis-run
#
# Starts a Redis server instance in current terminal window.
redis-run:
	redis-server $(REDIS_OPTS)

# >>> make redis

# Starts a Redis server instance as a background service.
redis:
	redis-server $(REDIS_OPTS) > ./log/mongoDB.log &

# >>> make redis-stop

# Stops any Redis instance listening on the default port
# by sending a `SHUTDOWN` command.
redis-stop:
	redis-cli SHUTDOWN


#					MongoDB Controls						#
#############################################################
# >>> make mongodb-run
#
# Starts a MongoDB daemon instance in current terminal window.
mongodb-run:
	mongod $(MONGO_OPTS)

# >>> make mongodb

# Starts a MongoDB daemon instance as a background service.
mongodb:
	mongod $(MONGO_OPTS) > ./log/mongoDB.log &

# >>> make mongodb-stop

# Stops the mongodb daemon
mongodb-stop:
	mongo --eval "db.getSiblingDB('admin').shutdownServer()"


#					Sidekiq Controls						#
#############################################################
# >>> make mongodb-run
#
# Starts a MongoDB daemon instance in current terminal window.
sidekiq-run:
	bundle exec sidekiq $(SDKIQ_OPTS)

# >>> make mongodb

# Starts a MongoDB daemon instance as a background service.
sidekiq:
	bundle exec sidekiq $(SDKIQ_OPTS) --logfile ./log/sidekiq.log &

# >>> make mongodb-stop

# Stops the mongodb daemon
sidekiq-stop:
	killall sidekicq



#					Rails Controls							#
#############################################################
# >>> make rails-run
#
# Starts a MongoDB daemon instance in current terminal window.
rails-run:
	rails $(RAILS_OPTS)

# >>> make mongodb

# Starts a MongoDB daemon instance as a background service.
rails:
	rails $(RAILS_OPTS) > ./log/sidekiq.log &

# >>> make mongodb-stop

# Stops the mongodb daemon
rails-stop:
	killall -9 ruby Rails


start: redis sidekiq mongodb rails

stop: redis-stop sidekiq-stop mongodb-stop rails-stop

routes:
	rake routes

update:
	git pull