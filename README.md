# og-cracker-fresh
A wrapper for OutGuess to crack passwords but takes into acocunt the -eE option OutGuess has where it can do error correction when embedding files, especially when embedding 2 files into the same image (yes--Outguess is meant to dual-embed files, that's why there are lowercase and UPPERCASE switches)

Obviously, you'll need Outguess installed with command line access.

# USAGE:
1.) make sure Outguess is installed
2.) Clone this repo & cd into the directory where you saved it
3.) chmod +x og-cracker-fresh.sh

./og-cracker-fresh.sh image.jpg pwlist.txt

When you embed files with Outguess, there's a -e and -E option.  Because Outguess allows 2 datastreams to be embedded, if you don't check for ECC, you may be missing files you assumed were "false positives"

