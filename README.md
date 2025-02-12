# Diseño de alto nivel 


![CleanShot 2025-02-12 at 10 32 15@2x](https://github.com/user-attachments/assets/1391ff99-50cb-4257-8fa0-eff0a40c87c1)


# Consideraciones del Proyecto

## 📌 Arquitectura

- **Enfoque Arquitectónico:** Se utiliza **Domain-Driven Design (DDD)** como base para la organización del dominio de la aplicación.
- **Patrón de Arquitectura en la Capa de Presentación:** Se ha adoptado **MVVM**, el estándar recomendado por Apple.

## 🏷 Lenguaje Ubicuo

- **Feature `Recipes`**: Su función es gestionar todo lo relacionado con las recetas, incluyendo su listado, detalles y ubicación en un mapa.
- **`Recipe`**: Representa una receta individual.
- **`RecipesLocation`**: Indica el origen geográfico de las recetas.

## 🛠 Tecnologías y Herramientas

- **Xcode:** 16.2
- **Swift:** Soporte para Swift 6
- **MockServer:** Se utilza la herramienta mockeable, asi mismo se adjunta en el proyecto el archivo **recipies.json**

## ⚙️ Consideraciones Técnicas

- **Uso de `@MainActor` en ViewModels:**
  - Al estar definidos bajo `@MainActor`, los bindings en los controladores no requieren ser ejecutados explícitamente en el **Main Thread**, ya que ya se encuentran en él.

- **Pruebas Unitarias:**
  - Se han considerado tests para las capas de **Infraestructura**, **Dominio** y la pantalla `RecipesList`.
  - Se utilizo el patrong Given When Then
  - Se considero el uso del patron ObjetMother
  - Quedan pendientes las pruebas para otras pantallas y módulos core.


- **Módulos Core Abstractos:**
  - **`HttpClient`**: Abstrae la capa de red.
  - **`YapeMapView`**: Oculta la implementación del proveedor de mapas (en este caso, Apple Maps), lo que permite cambiar a otro proveedor (como Google Maps) sin afectar a los clientes.

## ⚠️ Limitaciones y Decisiones

- **Variables de Entorno:**
  - No se ha incluido configuración de variables de entorno en este ejemplo.

- **Swift Catalog:**
  - No se ha utilizado por cuestiones de tiempo.

- **Escalabilidad y Modularización:**
  - El módulo está diseñado para ser escalable y puede modularizarse por **feature**, lo que facilita su asignación a diferentes equipos de desarrollo.
