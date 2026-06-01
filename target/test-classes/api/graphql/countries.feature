Feature: API GraphQL - Consulta de Paises
  # API publica de prueba: https://countries.trevorblades.com

  Background:
    * url 'https://countries.trevorblades.com/graphql'
    * header Content-Type = 'application/json'

  Scenario: Consultar informacion de un pais
    Given request
    """
    {
      "query": "{ country(code: \"ES\") { name capital currency languages { name } } }"
    }
    """
    When method POST
    Then status 200
    And match response.data.country.name == 'Spain'
    And match response.data.country.capital == 'Madrid'
    And match response.data.country.currency == 'EUR'

  Scenario: Consultar lista de paises por continente
    Given request
    """
    {
      "query": "{ continent(code: \"EU\") { name countries { code name } } }"
    }
    """
    When method POST
    Then status 200
    And match response.data.continent.name == 'Europe'
    And match response.data.continent.countries == '#[] #object'
    And match response.data.continent.countries[0] == { code: '#string', name: '#string' }

  Scenario: Consultar multiples paises con variables GraphQL
    Given request
    """
    {
      "query": "query GetCountry($code: ID!) { country(code: $code) { name capital phone } }",
      "variables": { "code": "US" }
    }
    """
    When method POST
    Then status 200
    And match response.data.country.name == 'United States'
    And match response.data.country.capital == 'Washington D.C.'

  Scenario: Verificar que no existe un pais invalido
    Given request
    """
    {
      "query": "{ country(code: \"XX\") { name } }"
    }
    """
    When method POST
    Then status 200
    And match response.data.country == null
