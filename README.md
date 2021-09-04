# README

Dummy Hotel reservation app which shows advantages and disadvantages of using Hotwire.

## How to run
```bash
cp .env.example .env
bundle install
yarn install
rake db:create db:migrate db:seed
```
Double check that db variables are properly setup at your `.env` file.
