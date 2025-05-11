<img align="center" width="150" src="https://i.imgur.com/Fgolqn1.png" />

<a href="https://top.gg/bot/617492380710469763" >
  <img src="https://top.gg/api/widget/status/617492380710469763.svg" alt="Atem" />
</a>

![Lang](https://img.shields.io/badge/language-ruby-red)
![Lang](https://img.shields.io/badge/language-typescript-blue)

# Atem Bot
discord, Telegram, and Whatsapp bot for search yugioh card

<img align="center" width="30%" src="https://i.imgur.com/SS9VM9L.gif" />

## Library
- Discord => Discordrb
- Telegram => Telegram-Bot-Ruby
- Whatsapp => Baileys.js

### Play

> Discord : https://top.gg/bot/617492380710469763

> Telegram : https://t.me/Atem_YugiohBot

> Whatsapp : ???

### Features
- quick search yugioh card 
- list search yugioh card
- tier list deck meta (duel links)

### Prerequisite
- Ruby 2.7.0 up
- Node 18.20.8 up

install all dependency

```
bundle install
```

```
npm i
```

### Usage
|   Commands    |    Discord    |    Telegram    |    Whatsapp    |
| ------------- | ------------- | ------------- | ------------- |
| information  | ```atem:info``` |  |.atem |
| ping | ```atem:ping``` |  |  |
| meta deck (duel links) | ```atem:dlmeta```  | ```/duellinksmeta``` |  |
| random card | ```atem:random``` | ```/random``` |  |
| list search card  |  ```atem:src card_name```    | ```/searchlist``` |  |
| quick search card | ```::card_name::``` | ```::card_name::``` | ```[[card_name]]``` |

### Developer Tool
unit test :
 ```
 rake run:rspec
 ```
run bot discord :
 ```
 rake run:dc
 ```
run bot telegram :
 ```
 rake run:tele
 ```
run bot whatsapp :
 ```
 rake run:wa
 ```
## Contributing

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch`
3. Make your changes and commit them: `git commit -m 'Add new feature'`
4. Push to the branch: `git push origin feature-branch`
5. Create a pull request.

## License

This project is licensed under the Apache License.

## Contact

For any questions or suggestions, feel free to open an issue on GitHub.
