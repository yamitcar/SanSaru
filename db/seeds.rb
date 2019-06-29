# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
User.create(name: 'aoc', lastname: 'admin', email: 'yamit.cardenas@gmail.com', password: 'aocAdmin!',
            password_confirmation: 'aocAdmin!', admin: true, terms_of_service: true)

Agile.create(name: 'Individuos e interacciones sobre procesos y herramientas')
Agile.create(name: 'Software funcionando sobre documentación extensiva')
Agile.create(name: 'Colaboración con el cliente sobre negociación contractual')
Agile.create(name: 'Respuesta ante el cambio sobre seguir un plan')

AgileRelation.create(name: 'Como hermanos')
AgileRelation.create(name: 'Mejores amigos')
AgileRelation.create(name: 'Buenos amigos')
AgileRelation.create(name: 'Conocidos personalmente')
AgileRelation.create(name: 'Nos conocemos de nombre')
AgileRelation.create(name: 'No nos conocemos')

Gender.create(name: 'Hombre')
Gender.create(name: 'Mujer')

Size.create(name: 'XS')
Size.create(name: 'S')
Size.create(name: 'M')
Size.create(name: 'L')
Size.create(name: 'XL')
Size.create(name: 'XXL')

Config.create(name: :invitaciones, value: 75)
Config.create(name: :eleccion, value: 'false')
