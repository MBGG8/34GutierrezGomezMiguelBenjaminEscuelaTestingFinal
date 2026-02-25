@Regression
Feature: Pruebas de la API de Users - PetStore

Background:
  * url petStore
  * def jsonCrearUsuario = read('classpath:examples/jsonData/crearUsuario.json')
  * def jsonActualizarUsuario = read('classpath:examples/jsonData/actualizarUsuario.json')
  * def jsonListaUsuarios = read('classpath:examples/jsonData/listaUsuarios.json')
  * def jsonVacio = {}

@TEST-1 @CrearUsuarios @happypath
Scenario: Creacion de lista de usuarios ingresando un lista - OK
  Given path 'user/createWithList'
  And request jsonListaUsuarios
  When method post
  Then status 200
  And print response

@TEST-2 @CrearUsuario @happypath
Scenario: Creacion de usuario - OK
  Given path 'user'
  And request jsonCrearUsuario
  When method post
  Then status 200
  And print response

@TEST-3 @BuscarUsuario @happypath
Scenario Outline: Buscar un Usuario por su Username - OK
  Given path 'user', '<username>'
  When method get
  Then status 200
  And match response.username == '<username>'
  And print response

  Examples:
  |   username      |
  |tester_Lopez     |
  |tester_carranza  |
  |tester_gutierrez |

@TEST-4 @ActualizarUsuario @happypath
Scenario: Actualiza los datos de Usuario - OK

  * set jsonActualizarUsuario.email = 'mbgg@gmail.com'
  * set jsonActualizarUsuario.password = 'newpass'

  Given path 'user', jsonActualizarUsuario.username
  And request jsonActualizarUsuario
  When method put
  Then status 200
  And print response

@TEST-5 @InicioSesion @happypath
Scenario: Inicio de sesion del sistema - OK
  Given path 'user/login'
  And param username = jsonCrearUsuario.username
  And param password = jsonCrearUsuario.password
  When method get
  Then status 200
  And print response

@TEST-6 @CerrarSesion @happypath
Scenario: Cerrar Sesion del sistema - OK
  Given path 'user/logout'
  When method get
  Then status 200
  And print response

@TEST-7 @EliminarUsuario @happypath
Scenario: Elimina un Usuario por su Username - OK
  Given path 'user', jsonCrearUsuario.username
  When method delete
  Then status 200
  And print 'Eliminacion correcta de', response.message
  And print response

#####################################################################################
@TEST-8 @BuscarUsuarioInexistente @unhappypath
Scenario: Buscar un Usuario que no exista
  Given path 'user', jsonCrearUsuario.username
  When method get
  Then status 404
  And match response.message == 'User not found'
  And print response

@TEST-9 @EliminarUsuarioInexistente @unhappypath
Scenario: Elimina un Usuario que no existe
  Given path 'user', jsonCrearUsuario.username
  When method delete
  Then status 404
  And print response

@TEST-10 @LoginSinCredenciales @unhappypath
Scenario: Intentar iniciar sesión sin pasar parametros
  Given path 'user/login'
  When method get
  Then status 200
  Then match response.message != 'logged in user session'
  * print 'BUG: La API accede al sistema sin credenciales'

@TEST-11 @CrearUsuarioSinDatos @unhappypath
Scenario: Creacion de usuario sin datos json
  Given path 'user'
  And request jsonVacio
  When method post
  Then status 200
  * print 'BUG: La Api permite crear un usuario con body vacío'
  And print response





