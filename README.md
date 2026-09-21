Proyecto CI/CD con Maven y GitHub Actions
1. Descripción del proyecto

Este proyecto corresponde a la implementación de un flujo de Integración Continua (CI) y Despliegue Continuo (CD), utilizando Maven, JUnit y GitHub Actions.

El objetivo es automatizar las principales etapas del ciclo de desarrollo de software, incluyendo:

Compilación del proyecto.
Ejecución de pruebas automatizadas.
Pruebas unitarias.
Pruebas de integración.
Pruebas de aceptación.
Generación de artefactos.
Despliegue en un entorno de prueba.
Respaldo de una versión anterior.
Ejecución de rollback ante un fallo.

El proyecto utiliza un flujo de trabajo basado en ramas para separar el desarrollo de las distintas actividades y posteriormente integrar los cambios en las ramas principales.

2. Tecnologías utilizadas
Tecnología	Versión / Uso
Java	26
Maven	3.9.16
JUnit	5.11.0
Git	2.55.0
GitHub	Control de versiones
GitHub Actions	Automatización CI/CD
Maven Surefire	Pruebas unitarias
Maven Failsafe	Pruebas de integración
GitHub Actions Artifacts	Almacenamiento de artefactos
3. Estructura del proyecto

La estructura principal del proyecto es:

proyecto-ci-cd/
│
├── .github/
│   └── workflows/
│       ├── ci.yml
│       └── deploy.yml
│
├── scripts/
│   ├── deploy-test.cmd
│   ├── acceptance-test.cmd
│   └── rollback-test.cmd
│
├── src/
│   ├── main/
│   │   └── java/
│   │       └── com/
│   │           └── ejemplo/
│   │               └── App.java
│   │
│   └── test/
│       └── java/
│           └── com/
│               └── ejemplo/
│                   ├── AppTest.java
│                   ├── AppIntegrationTest.java
│                   └── AppAcceptanceTest.java
│
├── .gitignore
├── pom.xml
└── README.md
4. Flujo de ramas

Para el desarrollo del proyecto se utilizó un flujo basado en ramas.

Las principales ramas utilizadas fueron:

main
│
└── develop
    │
    ├── feature/actividad-1
    ├── feature/actividad-2
    └── feature/actividad-3
Ramas principales
main: contiene las versiones integradas y preparadas para entrega.
develop: rama utilizada para integrar el desarrollo de las actividades.
feature/actividad-1: desarrollo correspondiente a la primera actividad.
feature/actividad-2: desarrollo correspondiente a la segunda actividad.
feature/actividad-3: desarrollo correspondiente a la tercera actividad.

Los cambios realizados en las ramas feature fueron integrados posteriormente en develop y finalmente en main.

5. Actividad 1 - Configuración del proyecto y pruebas
5.1 Creación del proyecto Maven

Se creó un proyecto Maven con la siguiente información:

<groupId>com.ejemplo</groupId>
<artifactId>proyecto-ci-cd</artifactId>
<version>1.0-SNAPSHOT</version>

El proyecto utiliza Java 26:

<maven.compiler.source>26</maven.compiler.source>
<maven.compiler.target>26</maven.compiler.target>

También se configuró JUnit 5 para la ejecución de pruebas automatizadas.

<dependency>
    <groupId>org.junit.jupiter</groupId>
    <artifactId>junit-jupiter</artifactId>
    <version>${junit.version}</version>
    <scope>test</scope>
</dependency>
5.2 Funcionalidad implementada

La aplicación contiene una clase App con una operación básica de suma:

public int sumar(int a, int b) {
    return a + b;
}
5.3 Prueba unitaria

La prueba AppTest verifica que la operación de suma entregue el resultado esperado.

2 + 3 = 5

Esta prueba permite comprobar de forma aislada el comportamiento de la funcionalidad implementada.

6. Actividad 2 - Integración Continua
6.1 Pipeline CI

Se implementó un pipeline de Integración Continua mediante GitHub Actions.

El archivo utilizado es:

.github/workflows/ci.yml

El pipeline se ejecuta cuando se realizan cambios en:

main
develop
ramas feature/**

También se configuró su ejecución mediante Pull Requests dirigidos a main o develop.

6.2 Etapas del pipeline

El pipeline realiza las siguientes actividades:

Checkout del código
        ↓
Configuración de Java 26
        ↓
mvn clean verify
        ↓
Pruebas unitarias
        ↓
Pruebas de integración
        ↓
Generación del JAR
        ↓
Almacenamiento del artefacto
6.3 Pruebas unitarias

Las pruebas unitarias se ejecutan utilizando Maven Surefire.

El proyecto contiene:

AppTest.java

Esta prueba verifica individualmente la operación de suma.

6.4 Pruebas de integración

Las pruebas de integración se ejecutan utilizando Maven Failsafe.

El proyecto contiene:

AppIntegrationTest.java

El archivo utiliza el sufijo:

IntegrationTest

para que Maven Failsafe pueda identificarlo como una prueba de integración.

6.5 Configuración de Surefire y Failsafe

Maven Surefire fue configurado para excluir las pruebas de integración:

<exclude>**/*IntegrationTest.java</exclude>

Maven Failsafe fue configurado para ejecutar:

<include>**/*IntegrationTest.java</include>

De esta forma se separan las pruebas unitarias de las pruebas de integración.

6.6 Artefacto

Una vez finalizada correctamente la compilación y las pruebas, GitHub Actions almacena el archivo JAR generado como artefacto.

El archivo generado es:

target/proyecto-ci-cd-1.0-SNAPSHOT.jar
7. Actividad 3 - Despliegue Continuo
7.1 Pipeline CD

Para la tercera actividad se creó un segundo workflow:

.github/workflows/deploy.yml

Este workflow utiliza:

workflow_dispatch:

por lo que puede ejecutarse manualmente desde GitHub Actions.

7.2 Flujo del despliegue

El pipeline realiza las siguientes etapas:

Checkout
   ↓
Configuración de Java 26
   ↓
Compilación y pruebas
   ↓
Creación del entorno de prueba
   ↓
Creación de respaldo
   ↓
Despliegue
   ↓
Prueba de aceptación
   ↓
Generación del artefacto
   ↓
Simulación de fallo
   ↓
Rollback
   ↓
Verificación del rollback
7.3 Compilación y pruebas

Antes del despliegue se ejecuta:

mvn clean verify

Esto permite verificar que el proyecto compile correctamente y que las pruebas automatizadas sean ejecutadas antes de realizar el despliegue.

7.4 Entorno de prueba

Para esta actividad se creó un entorno de prueba dentro del espacio de trabajo del pipeline:

deployment/
├── test/
└── backup/

La carpeta test representa el entorno donde se realiza el despliegue.

La carpeta backup contiene una copia de la versión anterior utilizada para realizar el rollback.

7.5 Despliegue

El archivo JAR generado por Maven se copia al entorno de prueba utilizando:

deployment/test/proyecto-ci-cd.jar

El despliegue se considera exitoso cuando el archivo se encuentra correctamente en el directorio correspondiente.

7.6 Prueba de aceptación

Después del despliegue se ejecuta una prueba de aceptación.

Esta prueba verifica que el archivo JAR exista en el entorno de prueba:

test -f deployment/test/proyecto-ci-cd.jar

Si el archivo existe, se muestra:

Prueba de aceptación del despliegue: OK

Esta prueba permite verificar que el artefacto fue efectivamente desplegado en el entorno de prueba.

7.7 Rollback

Como mecanismo de recuperación se implementó un rollback basado en el respaldo de la versión anterior.

Antes del despliegue se crea una copia:

deployment/backup/proyecto-ci-cd.jar

En caso de producirse un error posterior al despliegue, se restaura dicha versión mediante:

cp deployment/backup/proyecto-ci-cd.jar deployment/test/proyecto-ci-cd.jar

De esta manera, el entorno de prueba vuelve a disponer de la versión anterior.

7.8 Simulación de fallo

Para demostrar el funcionamiento del rollback se incorporó un fallo controlado dentro del pipeline:

echo "Simulando un fallo controlado después del despliegue..."
exit 1

Este fallo no representa un error real de la aplicación. Su objetivo es provocar deliberadamente una condición de error después del despliegue para comprobar que el mecanismo de rollback se ejecute correctamente.

Debido a que el fallo utiliza exit 1, GitHub Actions muestra la ejecución general del workflow como Failed.

Sin embargo, los pasos posteriores configurados con:

if: failure()

permiten ejecutar el rollback y verificar que la versión anterior haya sido restaurada.

Por lo tanto, el estado Failed del workflow corresponde al fallo controlado utilizado para demostrar el mecanismo de recuperación.

8. Scripts de despliegue

Además del workflow de GitHub Actions, se crearon scripts para realizar y comprobar las operaciones localmente.

8.1 Despliegue

Archivo:

scripts/deploy-test.cmd

Este script:

Verifica que exista el JAR.
Realiza un respaldo de la versión actualmente desplegada.
Crea el directorio de despliegue.
Copia la nueva versión.
Informa el resultado del despliegue.
8.2 Prueba de aceptación

Archivo:

scripts/acceptance-test.cmd

Este script verifica que el archivo JAR se encuentre en el entorno de prueba.

Resultado esperado:

Prueba de aceptacion del despliegue: OK
8.3 Rollback

Archivo:

scripts/rollback-test.cmd

Este script restaura la versión anterior desde:

deployment/backup/

Resultado esperado:

Rollback realizado correctamente.
Version anterior restaurada.
