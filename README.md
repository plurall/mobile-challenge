# Mobile Challenge



## 💻 Pré-requisitos

Antes de começar, verifique se você atendeu aos seguintes requisitos:
* Você instalou a versão mais recente de `flutter`
* Você tem uma máquina `Windows`. O código não foi testado em `Linux` e `MacOS`.

## 🚀 Instalando Mobile Challenge

Para instalar o Mobile Challenge, siga estas etapas:

Linux e macOS:
```
flutter pub get
```

Windows:
```
flutter pub get
```


## ☕ Usando Mobile Challenge

Para usar Mobile Challenge, siga estas etapas:

```
flutter run
```


## Arquitetura e pacotes utilizados

- [x] A arquitetura utilizada no projeto foi a MVVM(Model View ViewModel). Para consumir a API do Github foi utilizado o package `Dio`. 
- [x] Para o armazenamento das informações dos usuários do Github de maneira offline foi utilizado o package `sqflite`.
- [x] Para o armazenamento das informações do modo noturno foi utilizado o package `shared_preferences`.
- [x] Para parte de estilo do app foi utilizado os packages `font_awesome_flutter` e `google_fonts`.

## Teste unitário

Foi realizado um teste de verificação de erro no widget ApiGithubViewModel na função findAll.


## Estrutura do app

### AppBar

Todas as AppBar do app permiti alterar o tema do App.


### UsersPage

A UsersPage é onde o usuário pode inserir o nome de usuário que deseja pesquisar.

<img src="https://i.imgur.com/xmSsBrG.jpg" height="400em"> <img src="https://i.imgur.com/SOavOBq.jpg" height="400em"> <img src="https://i.imgur.com/rWlba4M.jpg" height="400em"> <img src="https://i.imgur.com/LtuezW6.jpg" height="400em">

### UserPage

A UserPage é onde é apresentado as demais informações do usuário.

<img src="https://i.imgur.com/0JP5Uzy.jpg" height="400em"> <img src="https://i.imgur.com/sMe8N68.jpg" height="400em">

### FavoritesPage 

A FavoritesPage é onde fica listado os perfis que são favoritados. Cada perfil listado possui um IconButton para deletar o item da lista.

<img src="https://i.imgur.com/0DHqiw5.jpg" height="400em"> <img src="https://i.imgur.com/bq6lqQb.jpg" height="400em">