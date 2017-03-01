##################################################################
#### Development Commands
##################################################################

up:
		docker-compose up -d web

restart.web:
		docker-compose restart web

stop.web:
		docker-compose stop web

stop.db:
		docker-compose stop postgres

logs:
		docker-compose logs -f web

shell:
		docker-compose exec web sh


##################################################################
#### Bootstrap Commands
##################################################################

new:
		docker-compose run --rm web mix phoenix.new . --module App --app app

bootstrap:
		docker-compose run --rm web mix deps.get \
		&& docker-compose run --rm web mix deps.clean --unused \
		&& docker-compose run --rm web npm install \
		&& docker-compose run --rm web mix ecto.setup


##################################################################
#### Deploy Commands
##################################################################

release:
		MIX_ENV=prod docker-compose run --rm web mix compile \
				&& docker-compose run --rm web /app/node_modules/brunch/bin/brunch build --production \
				&& MIX_ENV=prod docker-compose run --rm web mix phoenix.digest \
				&& MIX_ENV=prod docker-compose run --rm web mix release --no-tar --env=prod
