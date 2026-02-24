@Regression
Feature: Pruebas de la API de Store - PetStore

  Background:
    * url petStore
    * def jsonCrearOrden = read('classpath:examples/jsonData/crearOrden.json')

  @InventarioMascotas @happypath
  Scenario: Muestra el inventario de mascotas por su estado - OK
    Given path 'store/inventory'
    When method get
    Then status 200
    And print response

  @OrdenCompra @happypath
  Scenario: Crear una orden de compra para una mascota - OK
    Given path 'store/order'
    And request jsonCrearOrden
    When method post
    Then status 200
    And print response

  @BuscarOrden @happyath
  Scenario Outline: Buscar orden de compra por id - OK
    Given path 'store/order/' + <idOrder>
    When method get
    Then status 200
    And print response

    Examples:
    |idOrder|
    |2      |
    |10     |

  @EliminarOrden @happypath
  Scenario Outline: Eliminar orden de compra por id - OK
    Given path 'store/order/' + <idOrder>
    When method delete
    Then status 200
    And print response

    Examples:
    |idOrder|
    |20     |
    |30     |







