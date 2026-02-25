# Automatización de pruebas API PetStore (Store y User) 

---
**Escuela de Testing NTT DATA**

Miguel Benjamin Gutierrez Gomez  

---
### **1. Contexto**
Se realizó una automatización de pruebas funcionales para los módulos Store y User de la API [Swagger Petstore](https://petstore.swagger.io/#/), para esto se ha utilizado Karate DSL con apoyo del marco BDD 

#### Estructura del Proyecto

```text
└── 📁src
    └── 📁test
        └── 📁java
            └── 📁examples
                ├── 📁jsonData
                │   ├── actualizarUsuario.json
                │   ├── crearOrden.json
                │   ├── crearUsuario.json
                │   └── listaUsuarios.json
                ├── 📁store
                │   ├── store.feature
                │   └── StoreRunner.java
                └── 📁user
                    ├── user.feature
                    └── UserRunner.java
            ├── karate-config.js
            └── logback-test.xml
├── .gitignore
├── pom.xml
└── README.md
```
---

### 2. Módulo Store

#### HappyPath
Se validan los siguientes endpoints:
* **Muestra Inventario:** `GET /store/inventory`
* **Crear ordenes:** `POST /store/order`
* **Buscar orden:** `GET /store/order/{orderId}`
* **Eliminar orden:** `DELETE /store/order/{orderId}`

La data se gestiona a través de crearOrder.json

#### UnhappyPath 
* La API no valida la busqueda de ordenes a solo del 1 - 10 (TEST-5).
* La API valida correctamente la eliminacion de usuarios que no existen (TEST-6).
* La API permite la creacion de ordenes vacias (TEST-7).

#### Ejecución del módulo Store
Para ejecutar todos los tests del módulo Store, utiliza el siguiente comando:
```bash
mvn clean test -Dtest=StoreRunner -Dkarate.options="--tags @Regression" -Dkarate.env=dev
```
---
### 3. Módulo User

#### HappyPath
Se validan los siguientes endpoints:
* **Crear lista de usuarios:** `POST /user/createWithList`
* **Crear usuario individual:** `POST /user` 
* **Buscar usuario:** `GET /user/{username}` 
* **Actualizar usuario:** `PUT /user/{username}`
* **Inicio y Cierre de Sesión:** `GET /user/login` y `GET /user/logout`.
* **Eliminar usuario:** `DELETE /user/{username}`

La data se gestiona a través de: `crearUsuario.json`, `actualizarUsuario.json` y `listaUsuarios.json`.

#### UnhappyPath
* La API valida correctamente la busqueda de usuario que no existe (TEST-8).
* La API valida correctamente la eliminacion de usuario que no existe (TEST-9).
* La API permite el logeo sin credenciales (TEST-10).
* La API permite la creacion de usuario sin datos (TEST-11).

#### Ejecución del modulo User
Para ejecutar todos los tests del módulo User, utiliza el siguiente comando:
```bash
mvn clean test -Dtest=UserRunner -Dkarate.options="--tags @Regression" -Dkarate.env=dev
```
