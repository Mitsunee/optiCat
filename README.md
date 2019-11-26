# optiCat

optiCat helps you manage a queue for optipng, a great piece of software that tests a bunch of fancy combinations for how to save a PNG file with the least space possible.

# Installation

First install optipng with your package manager of choice (pictured: apt)

```bash
sudo apt install optipng
```

`cd` to wherever you keep your stuff and download the script and make it executable (pictured using wget)

```bash
wget https://raw.githubusercontent.com/Mitsunee/optiCat/master/optiCat.sh
chmod +x optiCat.sh
```

# Configuration

Use your text editor of choice to edit line 11 to 13 as you desire:  
![config](https://raw.githubusercontent.com/Mitsunee/optiCat/master/.guide/config.png)

*Note:* Don't edit the script while it's running. This might lead to random errors.

# Usage

Simply running the script without arguments will enter interactive mode. If enabled in the configuration you will see a list of all available commands here. If not type `help`  
![help](https://raw.githubusercontent.com/Mitsunee/optiCat/master/.guide/help.png)

You can also use any of these commands as arguments:  
![args](https://raw.githubusercontent.com/Mitsunee/optiCat/master/.guide/args.png)

In addition using `add` as an argument allows you to add the desired filename as further arguments. If you don't specify a filename it will temporarily enter interactive mode.
![add](https://raw.githubusercontent.com/Mitsunee/optiCat/master/.guide/add.png)

# License

See [LICENSE](LICENSE) or visit  
[![WTFPL](http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-1.png).net](http://www.wtfpl.net/)
