bank-server
===========

example for bank server authentication and api

# How to run
Please install these global packages

``` bash
[sudo] npm install -g coffee-script mocha 
```

and local packages

``` bash
npm install
```

To start server:

```bash
export PORT=<your_port> && coffee server.coffee
```

# How to test
```bash
mocha --compilers coffee:coffee-script/register -R spec
```
