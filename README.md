<img align="center" width="100%" src="https://i.imgur.com/rvGL5jK.gif" />

<img align="center" width="150" src="https://i.imgur.com/Fgolqn1.png" />

<a href="https://discordbots.org/bot/617492380710469763" >
  <img src="https://discordbots.org/api/widget/status/617492380710469763.svg" alt="Atem" />
</a>

![Lang](https://img.shields.io/badge/Language-Ruby-red)
![build](https://travis-ci.com/rokhimin/Atem-yugioh-bot.svg?branch=master)
![Coverage Status](https://img.shields.io/badge/coverage-99%25-green)

# Atem
discord & telegram bot for search yugioh card, newst meta deck . written in Ruby.

### Play

> [Discord](https://discordapp.com/api/oauth2/authorize?client_id=617492380710469763&permissions=1074789568&scope=bot) | Telegram(soon..)

### features
- quick search card yugioh 
- list search card yugioh
- get updated deck meta (duel links)

### use
|   Commands    |    Discord    |
| ------------- | ------------- |
|  information  |  ```atem:info```    |
| meta deck (duel links)  | ```atem:dlmeta```  |
| random card | ```atem:random``` |
| list search card  |  ```atem:src card_name```    |
| quick search card | ```::card_name::``` |

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


<a href="https://discordbots.org/bot/617492380710469763" >
  <img src="https://discordbots.org/api/widget/617492380710469763.svg" alt="Atem" />
</a>
