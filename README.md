# AutoPrepender

AutoPrepender is a script for automating the creation and connection of prepend objects in Max MSP, useful for creating VST wrappers in Ableton. It requires a .txt file with parameter names as input.

## Usage

Download "AutoPrepender.sh".

### Mac:
Open Terminal and navigate to the script's directory: `cd /path/to/script`

Run this command if needed: `chmod u+x ./AutoPrepender.sh`

Execute the script: `./AutoPrepender.sh input.txt`

### Windows:
Install Git Bash if not already done, navigate to the script's directory: `bash
cd /path/to/script`

Run the script: `bash
./AutoPrepender.sh input.txt`


The script generates a JSON structure to paste into Max MSP. After pasting, select all prepend objects, distribute them vertically, and connect an receive object with the same name as the send object to your vst~.
