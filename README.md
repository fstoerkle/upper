upper ^
=======

Never ever update all your stuff on your own again.

*WARNING*: All this stuff is expiremental and has only very rudimentary functionality. Use at your own risk!


Installation
------------
```bash
git clone git@github.com:fstoerkle/upper.git
cd upper
script/install
```

(The setup script and the whole setup process is heavily inspired by [Zach Holman](https://github.com/holman) and his creation [play](https://github.com/play/play)).

Configuration
-------------
upper puts all its configuration into the `$HOME/.upper` directory.
Place a file for each update task you want upper to perform into that directory.
A sample configuration looks like follows:
```json
{
    "cmd": "npm update",
    "hosts": [ "example.org", "example.com" ]
}
```
The `cmd` key is required while the `hosts` key is optional – if it is not provided, the command while be executed on your local machine.


License
-------
[MIT License](https://github.com/fstoerkle/upper/blob/master/LICENSE.md)