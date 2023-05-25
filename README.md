# KanbanApp

## Installation

- Clone repository

    ```sh
    git clone https://github.com/akatsukinoyami/KanbanApp.git
    ```

- Start containers

    ```sh
    docker-compose up
    ```

- Create DBs

    ```sh
    docker-compose run web rails db:create
    ```


- Load schema to DBs OR migrate DBs

    ```sh
    docker-compose run web rails db:schema:load
    ```

    ```sh
    docker-compose run web rails db:migrate
    ```

## Used technologies

- [Ruby](https://www.ruby-lang.org/) 3.2.2
- [Rails](https://rubyonrails.org) 7.0.4.3
- [Docker-compose](https://docs.docker.com/compose/) for deployment
- [PostgreSQL](https://www.postgresql.org) as database
- [Devise](https://github.com/heartcombo/devise) as auth handler
- [Bootstrap](https://github.com/twbs/bootstrap) as CSS framework
- [Hotwire](https://github.com/hotwired) for SPA-like experience
- [Audit](https://github.com/collectiveidea/audited) for version logging