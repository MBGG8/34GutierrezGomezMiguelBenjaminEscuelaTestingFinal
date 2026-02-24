@Regression
Feature: Pruebas de la API de Users - PetStore

Background:
  * url petStore
  * def jsonCrearUsuario = read('classpath:examples/jsonData/crearUsuario.json')
  * def jsonActualizarUsuario = read('classpath:examples/jsonData/actualizarUsuario.json')

@CrearUsuario @happypath
Scenario: Creacion de lista de usuarios ingresando un lista - OK
  Given path 'user/createWithList'
  And request jsonCrearUsuario
  When method post
  Then status 200
  And print response

@BuscarUsuario @happypath
Scenario: Buscar un Usuario por su Username - OK
  Given path 'user', 'Lucas'
  When method get
  Then status 200
  And print response

@EliminarUsuario @happypath
Scenario: Elimina un Usuario por su Username - OK
  Given path 'user', 'string'
  When method delete
  Then status 200
  And print response

@ActualizarUsuario @happypath
Scenario: Actualiza los datos de Usuario - OK
  Given path 'user', 'string'
  And request jsonActualizarUsuario.email=
  And request jsonActualizarUsuario
  When method put
  Then status 200
  And print response

