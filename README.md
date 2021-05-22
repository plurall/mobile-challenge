# Mobile Challenge

[![codecov](https://codecov.io/gh/FabioXimenes/mobile-challenge/branch/master/graph/badge.svg?token=JK8KYXV908)](https://codecov.io/gh/FabioXimenes/mobile-challenge)

Este projeto é uma solução apresentada para o desafio da Somos Educação. A aplicação interage com a API do GitHub permitindo a consulta de usuários, acesso a informações mais detalhadas como nome, localização, bio, avatar e email. O usuário pode ainda salvar perfis para ver depois sem a necessidade de conexão com a internet.

Todo o projeto foi desenvolvido seguindo a metodologia **TDD** e sua estrutura segue a **Clean Architecture**. O projeto conta com um total de **63 testes unitários** e uma cobertura total do código. 


## Get Started

1. Faça o clone do repositório
2. Entre na pasta do projeto e execute os comandos:

```sh
$ flutter pub get
$ flutter pub run build_runner build --delete-conflicting-outputs
$ flutter run
```