upper
=====

Never ever update all your stuff on your own again.

*WARNING*: All this stuff is expiremental and has only very rudimentary functionality. Use at your own risk!


Installation
------------
```bash
git clone git@github.com:fstoerkle/upper.git
cd upper
rake install
```


Configuration
-------------
upper puts all its configuration into the `$HOME/.upper` directory.
Place a file for each update task you want upper to perform.
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
MIT license, see [LICENSE.md](https://github.com/fstoerkle/upper/blob/master/LICENSE.md)