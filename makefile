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
	redis-server $(REDIS_OPTS) > ./log/redis.log & > /dev/null

# >>> make redis-stop

# Stops any Redis instance listening on the default port
# by sending a `SHUTDOWN` command.
redis-stop:
	redis-cli SHUTDOWN &

# Stops any Redis instance listening on the default port
# by sending a `SHUTDOWN` command.
redis-clean:
	redis-cli FLUSHDB &


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
	mongod --shutdown &

mongodb-clean:
	rake db:reset &


#					Sidekiq Controls						#
#############################################################
# >>> make sidekiq-run
#
# Starts a MongoDB daemon instance in current terminal window.
sidekiq-run:
	bundle exec sidekiq $(SDKIQ_OPTS)

# >>> make sidekiq

# Starts a MongoDB daemon instance as a background service.
sidekiq:
	bundle exec sidekiq $(SDKIQ_OPTS) --logfile ./log/sidekiq.log & > /dev/null

# >>> make sidekiq-stop

# Stops the sidekiq daemon
sidekiq-stop:
	sidekiqctl stop ./tmp/pids/server.pid &



#					Rails Controls							#
#############################################################
# >>> make rails-run
#
# Starts a Rails server in current terminal window.
rails-run:
	rails $(RAILS_OPTS)

# >>> make rails

# Starts a MongoDB daemon instance as a background service.
rails:
	rails $(RAILS_OPTS) > ./log/rails.log & > /dev/null

# >>> make rails-stop

# Stops the rails server
rails-stop:
	killall rails &


up: redis sidekiq mongodb rails

out: down

down: rails-stop mongodb-stop sidekiq-stop redis-stop

clean: mongodb-clean redis-clean

routes:
	rake routes

update:
	git pull