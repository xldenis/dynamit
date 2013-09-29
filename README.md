# Dynamit

----------------------

A simple web interface that combines your favourites online feeds,
and present only what you want to see.

* Mongo
* Rails JSON API
* Sidekiq
* Redis
* Facebook
* Twitter
* RSS feeds
* AngularJS

# Vagrant VM (Simple Install)

Get the latest version of Vagrant for your system on the [download page](http://downloads.vagrantup.com/).
Just download the VM from the [link]() (currently offline) and execute the following commands in the 
folder of your choice :

> mkdir dynamit-box
> cd dynamit-box
> vagrant init dynamit-vm [link]()
> vagrant up
> vagrant ssh

Now follow the instructions to register your application, and you will then be able to access the website bygoing to the default [Dynamit URL](http://localhost:3000/ "Default port");


# Manual Installation

This guide assumes you already have ruby 2.0.0 installed.

If you are on Ubuntu, you can follow this [guide](http://stackoverflow.com/questions/9056008/installed-ruby-1-9-3-with-rvm-but-command-line-doesnt-show-ruby-v/9056395#9056395 "Ruby fix on Ubuntu"). 

clone the repo in the folder of your choice whith this command :

	git clone https://github.com/xldenis/dynamit/

Because Dynamit is using MongoDB to store the posts, you will have to install it with.
Also, If you don't have any JavaScript runtime you are better off installing Node.js along :

	sudo apt-get install mongodb nodejs

Run bundle to install the missing gems:

	bundle install

Now to run the server, just use the makefile :

	make up

You can then access the website going to the default [URL](http://localhost:3000/ "Default port")

To kill the server :

	make down

# Application Registration
----------------

To register your app to access Twitter and Facebook, you will need to register them.
Once you have the KEY and the secret, you should add it to your envirinment variables.
On Ubuntu, open your *.bash_profile* file, and apend the 4 keys to the file. It should
look like this :

> export FACEBOOK_KEY="329487526874344"
> export FACEBOOK_SECRET="478n54tv7bw765849cb55w43vt6r7t59"
> export TWITTER_KEY="UGT6vfdtyRb6bfTRYVd6"
> export TWITTER_SECRET="gKG69fyRBcbHVcgV65v456Bvd5vd56DVgv546DVY4y"


# Dependencies

Be careful, The curb gem uses the dev version of libcurl.
If you are on Ubuntu, run this command to install it:

	sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev

# Administration

To have acces to the Sidekiq internals for debugging, go to the [Sidekick Dashboard](http://localhost:3000/sidekiq/)

	