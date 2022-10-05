## SwapRepos

Running into issues with installing gufw or snort? This script will help!

### Installation

Clone the repo into any directory:

`git clone https://github.com/ordsec/swaprepos.git`

Go into the directory:

`cd swaprepos`

Make sure the script is executable:

`chmod 777 swaprepos.sh`

Run it as root or as sudo!

`sudo ./swaprepos.sh [-uk] [--ubuntu --kali]`

### Flags

#### `-u` or `--ubuntu`

Use this flag if this is your first time running this script. This will download the Ubuntu repo list, make a back-up copy of the original `/etc/apt/sources.list` file, and swap the original sources file for Ubuntu repos. `apt-get update` will run automatically.

#### `-k` or `--kali`

Use this flag once you're done installing what you needed from Ubuntu repos (gufw, snort). It will save Ubuntu repos in a separate file and move default Kali repos from the back-up file to the original `sources.list` file as if nothing has happened. Then the script will run `apt-get-update`.

### Example use

While in the folder with the script, type:

`sudo ./swaprepos.sh -u`

`sudo apt-get install -y gufw` (or `snort` depending on your situation)

`sudo ./swaprepos.sh -k`
