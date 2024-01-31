<img src="https://github.com/Favo02/cess-advisor/assets/59796435/f71a96e5-5769-46e4-a547-93cff46b1b7b" width="100" align="right" alt="Logo" />

## Cess Advisor

Cess Advisor is a **stupid** yet really **useful** web app that helps you decide whether a _decent toilet_ is available or you _should suffer_.

> [!CAUTION]
> The app is still in early development, it is not yet ready for production use.
> _In other words you could be able to do something bad, but I trust you will not do it._

### Tech stack

- Backend: **OCaml** _(I decided to suffer too building this thing, but in the end I enjoyed OCaml really much)_
  - [Sihl](https://github.com/oxidizing/sihl): OCaml framework for building web apps
  - [Caqti](https://github.com/paurkedal/ocaml-caqti): OCaml library for interacting with databases
  - [Yojson](https://github.com/ocaml-community/yojson): OCaml library for JSON serialization
  - [Validate](https://github.com/Axot017/validate): OCaml library for validating schemas

- ~~Frontend: **JavaScript** _(much much much much worse than OCaml)_~~
  - ~~[React](https://reactjs.org/): JavaScript framework for frontend web development~~
  - ~~[Vite](https://vitejs.dev/): React build tool~~
  - ~~[Tailwind CSS](https://tailwindcss.com/): CSS framework~~
  - ~~[Shadcn-ui](https://ui.shadcn.com/): React components library~~

- Database:
  - [PostgreSQL](https://www.postgresql.org/): relational database

- Deployment:
  - [Docker](https://www.docker.com/): containerization
  - [GitHub Actions](https://docs.github.com/en/actions): CI/CD


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
  - ~~`fe/`: frontend~~
    - ~~`components`: components~~
    - ~~`pages`: pages _(routing)_~~
    - ~~`services`: interaction with backend API~~
    - ~~`validators`: form validators~~
  - `db/`: database
    - `tables`: tables
  - `repo`: repository _(omit scope)_

- **Summary**: commit summary, present tense, start with lowercase, no period at the end

_Adding new scopes is allowed if necessary, add it to the list above._
