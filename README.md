<img align="center" width="100%" src="https://i.imgur.com/rvGL5jK.gif" />

<img align="center" width="150" src="https://i.imgur.com/Fgolqn1.png" />

![Lang](https://img.shields.io/badge/Language-Ruby-red)
![build](https://travis-ci.com/rokhimin/Atem-yugioh-bot.svg?branch=master)
![Coverage Status](https://img.shields.io/badge/coverage-99%25-green)

# Atem
discord & telegram bot for search yugioh card . written in Ruby.

### Play
> [Discord](https://discordapp.com/api/oauth2/authorize?client_id=617492380710469763&permissions=1074789568&scope=bot) | Telegram(soon..)

### feature
- search card yugioh (one and list)
- get updated deck meta (duel links)

### use
|   Commands    |    Discord    |
| ------------- | ------------- |
|  information  |  ```atem:info```    |
| meta deck (duel links)  | ```atem:dlmeta```  |
|  search card (list card)  |  ```atem:src name_card```    |
| search card (single/one card) | ```::name_card::``` |

### developer tool tasks
install gem :
 ```
 rake gem:install
 ```
create db :
 ```
 rake db:create
 ```
migration db :
 ```
 rake db:migrate
 ```
drop db :
 ```
 rake db:drop
 ```
test :
 ```
 rake run:rspec
 ```
run bot discord :
 ```
 rake run:discord
 ```
run bot telegram :
 ```
 rake run:telegram
 ```


# License
Apache License.
