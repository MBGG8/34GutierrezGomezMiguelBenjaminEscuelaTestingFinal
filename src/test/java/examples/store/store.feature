@Regression
Feature: Pruebas de la API de Store - PetStore

  Background:
    * url petStore
    * def jsonCrearOrden = read('classpath:examples/jsonData/crearOrden.json')
    * def jsonVacio = {}

  @TEST-1 @InventarioMascotas @happypath
  Scenario: Muestra el inventario de mascotas por su estado - OK
    Given path 'store/inventory'
    When method get
    Then status 200
    And match response == '#object'
    And print response

  @TEST-2 @OrdenCompra @happypath
  Scenario: Crear una orden de compra para una mascota - OK
    Given path 'store/order'
    And request jsonCrearOrden
    When method post
    Then status 200
    And match response.id == jsonCrearOrden.id
    And match response.status == 'placed'
    And match response.complete == true
    And print response

  @TEST-3 @BuscarOrden @happyath
  Scenario Outline: Buscar orden de compra por id - OK
    Given path 'store/order/' + <idOrder>
    When method get
    Then status 200
    And match response == '#object'
    And print mensaje, response

    Examples:
    |idOrder|     mensaje               |
    |1      |'Limite inferior permitido'|
    |5      |'Valor intermedio'         |
    |9      |'Limite superior permitido'|

  @TEST-4 @EliminarOrden @happypath
  Scenario: Eliminar orden de compra por id - OK
    Given path 'store' , 'order' , jsonCrearOrden.id
    When method delete
    Then status 200
    And print response

##################################################################################
  @TEST-5 @BuscarOrdenInvalida @unhappyath
  Scenario Outline: Buscar orden con id inválido (<1 y >10)
    Given path 'store/order/' + <idOrder>
    When method get
    # La API NO VALIDA LAS ID MAYORES A 10
    Then status 404
    And match response.type == 'error'
    And print response

    Examples:
      |idOrder|
      |-1     |
      |11     |
      |9876   |

  @TEST-6 @EliminarOrdenEliminada @unhappypath
  Scenario: Eliminar orden de compra que no existe - OK
    Given path 'store' , 'order' , jsonCrearOrden.id
    When method delete
    Then status 404
    And match response.message == 'Order Not Found'
    And print 'Orden no encontrada', response

  @TEST-7 @OrdenCompraVacia @unhappypath
  Scenario: Crear una orden sin datos - OK
    Given path 'store/order'
    And request jsonVacio
    When method post
    #Se coloca 200 por la falta de validación de la API
    Then status 200
    And match response == '#present'
    And print 'Respuesta Incorrecta de la API(debería salir error):', response