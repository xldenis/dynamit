# MAKEFILE

# Makefile define tasks you can do with the dynamit
# The commands that you will run the most often are :
# 


REDIS_OPTS	= 
MONGO_OPTS	= 
SDKIQ_OPTS	= 
RAILS_OPTS	= s


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
	redis-server $(REDIS_OPTS) > ./log/mongoDB.log & > /dev/null

# >>> make redis-stop

# Stops any Redis instance listening on the default port
# by sending a `SHUTDOWN` command.
redis-stop:
	redis-cli SHUTDOWN > /dev/null


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
	mongod $(MONGO_OPTS) > ./log/mongoDB.log & > /dev/null

# >>> make mongodb-stop

# Stops the mongodb daemon
mongodb-stop:
	mongod --shutdown > /dev/null


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
	bundle exec sidekiq $(SDKIQ_OPTS) --logfile ./log/sidekiq.log & > /dev/null

# >>> make mongodb-stop

# Stops the mongodb daemon
sidekiq-stop:
	sidekiqctl stop ./tmp/pids/server.pid > /dev/null



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
	rails $(RAILS_OPTS) > ./log/sidekiq.log & > /dev/null

# >>> make mongodb-stop

# Stops the mongodb daemon
rails-stop:
	killall ruby Rails


up: redis sidekiq mongodb rails

down: rails-stop mongodb-stop sidekiq-stop redis-stop

routes:
	rake routes

update:
	git pull