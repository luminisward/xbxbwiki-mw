## Dependency install

`docker run --rm -it --volume $PWD/mediawiki:/app composer bash`

```
composer config -g repo.packagist composer https://packagist.laravel-china.org
composer install --no-dev
```
