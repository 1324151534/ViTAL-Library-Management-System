# ViTAL-LMS-V2-Rebuilt

由于第一版代码结构过于混乱且难以 Debug，因此决定完全重写代码。

重写版本选择使用 Element-UI 和 Vue2 搭建。

## PostgreSQL setup

```
see ./vitalv2-server/server.sql
```

## Flask setup

```shell
pip install flask, flask_cors, flask_sqlalchemy, flask_bcrypt, psycopg2
cd ./vitalv2-server
python ./app.py
```

## Vue Project setup

```shell
cd ./vitalv2
npm install
```

### Compiles and hot-reloads for development

```shell
npm run serve
```

### Compiles and minifies for production

```shell
npm run build
```

### Lints and fixes files

```shell
npm run lint
```

### Customize configuration

See [Configuration Reference](https://cli.vuejs.org/config/).
