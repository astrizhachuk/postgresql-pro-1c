# postgresql-pro-1c

## О сборке
postgresql-pro-1c - это docker-контейнер специализированной версии PostgreSQL, собранной компанией [Postgres Professional](https://postgrespro.ru/products/1c_build). В установочные пакеты включены изменения, предоставленные компанией 1C.

За основу данной сборки взят образ [sameersbn/docker-postgresql](https://github.com/sameersbn/docker-postgresql), позволяющий управлять базой данных в контейнере через переменные окружения. Варианты запуска контейнеров см. [здесь](https://github.com/sameersbn/docker-postgresql) (англ.). При работе с 1С новые базы надо создавать средствами 1С:Предприятия, так как базы для 1С должны генерироваться с помощью специализированных шаблонов (см. postgrs.dll сервера 1С:Предприятия).

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
git clone https://github.com/AlexStrizh/postgresql-pro-1c.git
cd postgresql-pro-1c
./build.sh
./run.sh
```

Windows (cmd):
```bash
git clone https://github.com/AlexStrizh/postgresql-pro-1c.git
cd postgresql-pro-1c
build.bat
run.bat
```
**Внимание:** Данный способ запуска - это "коробочный" вариант запуска с минимальными настройками и безопасностью.

**Получение готового образа:**

```bash
docker pull strizhhh/postgresql-pro-1c:9.6
```

**Параметры подключения:**
- сервер: localhost или имя (IP) машины, на которой запускается контейнер;
- порт: 5432
- пользователь: postgres
- пароль: (пустой)

**Пример запуска:**

Создание контейнера с монтированным томом **postgresql-pro-1c-data**.
```bash
docker run --name postgresql-pro-1c \
  -d \
  -p 5432:5432 \
  -v postgresql-pro-1c-data:/var/lib/postgresql \
  strizhhh/postgresql-pro-1c:latest
```

# Возможные проблемы

- Файлы с расширением **.sh** и в папке **runtime** предназначены для linux, поэтому при сборке образов обращайте внимание на LF и CRLF файлов. Ошибочная конвертация файлов может привести к неработоспособности образа: ошибка "файл не найден".
- Монтирование файлов с данными непосредственно к каталогам файловых систем windows может вызывать проблемы. Рекомендуется создавать docker-managed volumes (тома в контейнерах под управлением docker).