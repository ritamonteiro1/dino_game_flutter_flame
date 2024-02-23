# Dino Game

Este projeto replica o jogo [Dino](https://github.com/ufrshubham/dino_run) e tem como objetivo ser uma base de estudo para o [Flutter Flame](https://docs.flame-engine.org)

<img src="assets/read_me/dino_games_coordinates.png>

## Instalar dependências e rodar o projeto

```bash

# Na raiz do repositório instale a dependência [Melos](https://melos.invertase.dev/):
$ dart pub global activate melos

# Inicialize a dependência:
$ melos bootstrap

# Instale as dependências do projeto:
$ melos pub:get

# Acesse a pasta game:
$ cd game

# Rode o projeto:
$ flutter run

```

## Visualizar componentes do design system através do widgetbook

```bash

# Acesse a pasta widgetbook dentro da pasta design_system e execute o comando:
$ flutter run

# Ainda no terminal, escolha o device de preferência (Chrome ou Edge) e aguarde

```

## Adicionar strings no projeto

```bash

# Adicione o texto desejado no arquivo intl_pt.arb que está no pacote localizations

# Acesse o pacote:
$ cd localizations

# Execute o seguinte comando e aguarde:
$ flutter gen-l10n

```