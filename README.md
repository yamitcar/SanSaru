# San-Saru AoC Co 2019

[![Maintainability](https://api.codeclimate.com/v1/badges/e7b16647550a48e4c9a3/maintainability)](https://codeclimate.com/github/yamitcar/SanSaru/maintainability) <a href="https://codeclimate.com/github/yamitcar/SanSaru/test_coverage"><img src="https://api.codeclimate.com/v1/badges/e7b16647550a48e4c9a3/test_coverage" /></a>

## Getting started

Para iniciar la App, clona el repositorio e instala las gemas necesarias:

    $ bundle install --without production
    
### Ambiente de desarrollo

Para configurar el ambiente de desarrollo, instala:

    Postgres
    Ruby
    Rails

Dentro de la raiz del proyecto, ejecuta:

    gem install bundler
    bundle install

Configura los parametros de la base de datos en:

    config/database.yml

Y ejecuta:

    rails db:create
    rails db:migrate

En el archivo _.env_, configura los datos de acceso al email:

    MAIL_DOMAIN=...
    MAIL_USERNAME=...
    MAIL_PASSWORD=...
    SMTP_ADDR=...

En el archivo _db/seeds.rb_, verifica los datos del usuario administrador:

    User.create(name: 'aoc', lastname: 'admin', email: 'yamit.cardenas@gmail.com', password: 'aocAdmin!',
        password_confirmation: 'aocAdmin!', admin: true, terms_of_service: true)

Luego ejecuta:     

    rails db:seed

A la casilla del mail del admin deberá llegar un mail de confirmación de la cuenta.
    
Para que los assets queden disponibles, ejecuta:

    rake assets:precompile

Para iniciar la app, ejecuta:

    rails s

Para personalizar la aplicación según las condiciones específicas de cada edición del AOC:
+ Revisar _app/helpers/application_helper.rb_

### Heroku

Para desplegar en Heroku, sigue estos pasos:

+ Hacer push
+ Agregar cambios en la base de datos:

        heroku run rails db:migrate
        
+ Correr semillas y crear usuarios (verificar el usuario administrador)
        
        heroku run rails db:seed 
        // o 
        heroku run rails console 
        // y ejecutaR cambios desde alli. 
        
+ Agregar variables de entorno, mails y demas:

        heroku config:add MAIL_PASSWORD=password12345 MAIL_USERNAME=support@yoururl.com MAIL_DOMAIN=gmail.com SMTP_ADDR=smtp.gmail.com
        
Para borrar la base de datos de heroku:
     
    heroku pg:reset DATABASE_URL
    
### Invitaciones

Las invitaciones solo se podran activar si desde la interfaz administrativa se crean:
+ Las 3 invitaciones iniciales
+ Se activa el período de invitaciones en las configuraciones

Query para obtener todos los invitados:

    SELECT users.id, users.name, lastname, email, country,state,city,phonenumber, genders.name, sizes.name, payed
      FROM public.users, public.invitations, public.profiles, public.genders,public.sizes
      WHERE users.id = invitations.user_id and users.profile_id = profiles.id 
      and profiles.gender_id = genders.id and profiles.size_id = sizes.id;
