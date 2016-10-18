###Hey this is our very first Ruby on rails app !

#Step to install
of course first clone the project
`git clone https://github.com/lpdw/Grouper.git`

Then ...
##Using Docker  
You need docker-compose
just go in the app folder and do  
`docker-compose build`  
run your containers
`docker-composer up`
then migrate the Database  
`docker-compose run web rake db:migrate`  
Finally  
`docker-compose start`  
And you will have a working app on localhost:3000

## Notes  
Rails & rake commands go like this :
`docker-compose run web [railsCommand]`

##Without docker
...
