Feature: API REST - Gestion de Usuarios con JSONPlaceholder
  # API publica gratuita: https://jsonplaceholder.typicode.com

  Background:
    * url 'https://jsonplaceholder.typicode.com'
    * header Content-Type = 'application/json'

  Scenario: Obtener lista de usuarios
    Given path '/users'
    When method GET
    Then status 200
    And match response == '#[] #object'
    And match response[0] == { id: '#number', name: '#string', username: '#string', email: '#string', address: '#object', phone: '#string', website: '#string', company: '#object' }
    And assert response.length == 10

  Scenario: Obtener usuario por ID
    Given path '/users/1'
    When method GET
    Then status 200
    And match response.id == 1
    And match response.name == 'Leanne Graham'
    And match response.email == '#string'
    And match response.username == '#string'

  Scenario: Usuario no encontrado devuelve 404
    Given path '/users/999'
    When method GET
    Then status 404
    And match response == {}

  Scenario: Crear usuario nuevo
    Given path '/users'
    And request { name: 'Henry QA', username: 'henryqa', email: 'henry@qa.com' }
    When method POST
    Then status 201
    And match response.name == 'Henry QA'
    And match response.username == 'henryqa'
    And match response.id == '#number'

  Scenario: Actualizar usuario
    Given path '/users/1'
    And request { name: 'Henry Updated', username: 'henryupdated', email: 'updated@qa.com' }
    When method PUT
    Then status 200
    And match response.name == 'Henry Updated'
    And match response.id == 1

  Scenario: Eliminar usuario
    Given path '/users/1'
    When method DELETE
    Then status 200
