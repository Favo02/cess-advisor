### Commit convention

This project follows the following **commit convention**: `<type>(<part>/<scope>): <summary>`

- **Type**: commit type
  - `feat`: add new feature
  - `fix`: bug fix
  - `refactor`: code refactoring
  - `build`: build system _(dependencies, ...)_
  - `test`: add tests
  - `docs`: documentation changes
  - `ci`: continuous integration _(github actions, ...)_

- **Module**/**Scope**: commit part (mandatory) and scope (optional)
  - `be/`: backend
    - `handlers`: request handlers
    - `middlewares`: middleware functions
    - `utils`: utility module
  - `fe/`: frontend
    - `components`: components
    - `pages`: pages
  - `db/`: database
    - `tables`: tables
  - `repo`: repository _(omit scope)_

- **Summary**: commit summary, present tense, start with lowercase, no period at the end

_Adding new scopes is allowed if necessary, add it to the list above._
