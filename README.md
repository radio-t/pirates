# Пираты Радио-Т [![Docker Automated build](https://img.shields.io/docker/automated/jrottenberg/ffmpeg.svg)](https://hub.docker.com/r/umputun/pirates/)

Сайт подкаста https://pirates.radio-t.com

## генерация сайта

```
    docker-compose run hugo
```

## дополнительные автоматизации

1. Создание нового эпизода и его доставка на сервер - `make-episode.sh [num] [yyyy-mm-dd]`. Оба параматера опциональны. По умолчанию создаст выпуск с номером+1 от последнего опубликованного выпуска на radio–t.com.
1. Подготовка и публикация mp3 файла - `upload_mp3.sh <filename>`. Добавляет мp3 tags и заливает файл во все места.

_обе автоматизации требуют доверенного доступа и подразумевают наличие ssh ключей и `PODCAST_ARCHIVE_CREDS` в окружении._

## технические детали

1. Статический сайт на hugo
1. RSS строится для FB в atom формате
1. Кастомизации сайта в `themes/pirates-radio-t`
