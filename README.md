# postgresql-pro-1c

## О сборке
postgresql-pro-1c - это docker-контейнер специализированной версии PostgreSQL, собранной компанией [Postgres Professional](https://postgrespro.ru/products/1c_build). В установочные пакеты включены изменения, предоставленные компанией 1C.

За основу данной сборки взят образ [sameersbn/docker-postgresql](https://github.com/sameersbn/docker-postgresql), позволяющий управлять базой данных в контейнере через переменные окружения. Варианты запуска контейнеров см. [здесь](https://github.com/sameersbn/docker-postgresql) (англ.). При работе с 1С новые базы надо создавать средствами 1С:Предприятия, так как базы для 1С должны создаваться с помощью специализированных шаблонов (см. postgrs.dll сервера 1С:Предприятия).

__Особенности:__
- ОС: ubuntu:bionic;
- версия postgreSQL: 9.6.10;
- предназначена для использования с версией технологической платформы 1С:Предприятие 8 не ниже 8.3.10.2580;
- основная локаль: ru_RU.UTF-8;
- дополнительная локаль: en_US.UTF-8;

## Установка

Для установки и начального запуска выполните команды:

Linux (bash):
```bash
git clone https://github.com/strizhhh/postgresql-pro-1c.git
cd postgresql-pro-1c
./build.sh
./run.sh
```

Windows (cmd):
```bash
git clone https://github.com/strizhhh/postgresql-pro-1c.git
cd postgresql-pro-1c
build.bat
run.bat
```
__Внимание:__ Данный способ запуска - это "коробочный" вариант запуска с минимальными настройками и безопасностью.

__Параметры подключения:__
- сервер: localhost или имя (IP) машины, на которой запускается контейнер;
- порт: 5432
- пользователь: postgres
- пароль: (пустой)