<img src="https://github.com/Favo02/cess-advisor/assets/59796435/f71a96e5-5769-46e4-a547-93cff46b1b7b" width="150" align="right" alt="Logo" />

# Cess Advisor

**Cess Advisor** 🐪🚽 is a _stupid_ yet really _useful_ web app that helps you find a _suitable toilet_ when you are in a hurry.


## Tech stack

In short: **OCaml** 🐪 (Sihl) + **JavaScript** 🤢 (Svelte) + **PostgreSQL** 🐘 + Docker 🐳 + GitHub Actions 🚀

> [!TIP]
> If you want to preserve your mental health, you should **NOT** write JavaScript code _(and frontends in general)_. OCaml is just better.

<details>
<summary>Detailed tech stack</summary>

- Backend: **OCaml** 🐪
  - [Sihl](https://github.com/oxidizing/sihl): OCaml framework for building web apps
  - [Opium](https://github.com/rgrinberg/opium/): OCaml framework for managing HTTP requests
  - [Caqti](https://github.com/paurkedal/ocaml-caqti): OCaml library for interacting with databases
  - [Yojson](https://github.com/ocaml-community/yojson): OCaml library for JSON serialization
  - [Validate](https://github.com/Axot017/validate): OCaml library for validating schemas

- Frontend: **JavaScript** ⚛️
  - [Sveltekit](https://kit.svelte.dev/): JavaScript framework for frontend web development
  - [Tailwind CSS](https://tailwindcss.com/): CSS framework
  - [DaisyUI](https://daisyui.com/): Tailwind components library

- Database: 🐘
  - [PostgreSQL](https://www.postgresql.org/): relational database

- Deployment: 🐳
  - [Docker](https://www.docker.com/): containerization
  - [GitHub Actions](https://docs.github.com/en/actions): CI/CD

</details>

## Conventions

<details>
<summary>Commit convention</summary>

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
    - `pages`: pages _(routing)_
    - `services`: interaction with backend API
    - `validators`: form validators
  - `db/`: database
    - `tables`: tables
  - `repo`: repository _(omit scope)_

- **Summary**: commit summary, present tense, start with lowercase, no period at the end

_Adding new scopes is allowed if necessary, just add it to the list above._

</details>
