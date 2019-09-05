## Dependency install

`docker run --rm -it --volume $PWD/mediawiki:/app composer bash`

```
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
composer install --no-dev
```
