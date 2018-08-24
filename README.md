# San-Saru AoC Co 2018

[![Maintainability](https://api.codeclimate.com/v1/badges/e7b16647550a48e4c9a3/maintainability)](https://codeclimate.com/github/yamitcar/SanSaru/maintainability) <a href="https://codeclimate.com/github/yamitcar/SanSaru/test_coverage"><img src="https://api.codeclimate.com/v1/badges/e7b16647550a48e4c9a3/test_coverage" /></a>

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install --without production
```

Next, migrate the database:

```
$ rails db:migrate
```

on heroku:

    heroku run rails db:migrate
    
If the test suite passes, you'll be ready to run the app in a local server:

```
$ foreman start
```
    

    
Para desplegar en Heroku:

    - Hacer push
    - agregar cambios en la db:
        heroku run rails db:migrate
    - correr semillas y crear usuarios (verificar el usuario administrador)
        heroku run rails db:seed 
        o
        heroku run rails console y ejecutar cambios desde alli.
    -agregar variables de entorno:
        mails y demas
        heroku config:add MAIL_PASSWORD=password12345 MAIL_USERNAME=support@yoururl.com MAIL_DOMAIN=gmail.com SMTP_ADDR=smtp.gmail.com
        
to drop heroku db:
            
    heroku pg:reset DATABASE_URL
    
Las invitaciones solo se podran activar si desde la interfaz administrativa se crean:

    las 3 invitaciones iniciales
    se activa el perido de invitaciones en las configuraciones.
    
    
Query for get all the guests

    SELECT users.id, users.name, lastname, email, country,state,city,phonenumber, genders.name, sizes.name, payed
      FROM public.users, public.invitations, public.profiles, public.genders,public.sizes
      WHERE users.id = invitations.user_id and users.profile_id = profiles.id 
      and profiles.gender_id = genders.id and profiles.size_id = sizes.id;