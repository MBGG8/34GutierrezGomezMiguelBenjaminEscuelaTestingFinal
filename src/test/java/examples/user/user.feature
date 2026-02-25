@Regression
Feature: Pruebas de la API de Users - PetStore

Background:
  * url petStore
  * def jsonCrearUsuario = read('classpath:examples/jsonData/crearUsuario.json')
  * def jsonActualizarUsuario = read('classpath:examples/jsonData/actualizarUsuario.json')
  * def jsonListaUsuarios = read('classpath:examples/jsonData/listaUsuarios.json')

@TEST-1 @CrearUsuarios @happypath
Scenario: Creacion de lista de usuarios ingresando un lista - OK
  Given path 'user/createWithList'
  And request jsonListaUsuario
  When method post
  Then status 200
  And print response

@TEST-2 @BuscarUsuario @happypath
Scenario: Buscar un Usuario por su Username - OK
  Given path 'user', 'String'
  When method get
  Then status 200
  And print response

@TEST-3 @EliminarUsuario @happypath
Scenario: Elimina un Usuario por su Username - OK
  Given path 'user', 'Lucas'
  When method delete
  Then status 200
  And print response

@TEST-4 @ActualizarUsuario @happypath
Scenario: Actualiza los datos de Usuario - OK
  Given path 'user', 'String'
  And request jsonActualizarUsuario.email = 'mbgg@gmail.com'
  And request jsonActualizarUsuario.password = 'contraseña'
  And request jsonActualizarUsuario
  When method put
  Then status 200
  And print response

@TEST-5 @InicioSesion @happypath
Scenario: Inicio de sesion del sistema - OK
  Given path 'user/login'
  * def login = read('classpath:examples/jsonData/credenciales.json')
  And param username = login.username
  And param password = login.password
  When method get
  Then status 200
  And print response

@TEST-6 @CerrarSesion @happypath
Scenario: Cerrar Sesion del sistema - OK
  Given path 'user/logout'
  When method get
  Then status 200
  And print response

@TEST-7 @CrearUsuario @happypath
Scenario: Creacion de usuario - OK
  Given path 'user'
  And request jsonCrearUsuario
  When method post
  Then status 200
  And print response
