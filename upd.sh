#!/bin/bash
echo "# TeaSpeak Updater"

if [ `getconf LONG_BIT` = "64" ]
then
        echo "# Detected an 64 bit environment"
		echo "# Getting version..."
		version=$(curl -s -S -k https://repo.teaspeak.de/server/linux/amd64_optimized/latest)
		echo "# Newest version is ${version}"
        requesturl="https://repo.teaspeak.de/server/linux/amd64_optimized/TeaSpeak-${version}.tar.gz"
else
        echo "# Detected an 32 bit environment"
		echo "# Getting version..."
		version=$(curl -s -S -k https://repo.teaspeak.de/server/linux/x86/latest)
		echo "# Newest version is ${version}"
        requesturl="https://repo.teaspeak.de/server/linux/x86/TeaSpeak-${version}.tar.gz"
fi

echo "# Downloading ${requesturl}"
curl -s -S "$requesturl" -o updatefile.tar.gz

echo "# Backing up config and database"
cp config.yml config.yml.old
cp TeaData.sqlite TeaData.sqlite.old

echo "# Unpacking and removing .tar.gz"
tar -xzf updatefile.tar.gz
rm updatefile.tar.gz

echo "# Making scripts executable"
chmod u+x *.sh

echo "# TeaSpeak should be now updated to ${version}"

echo "# Restarting TeaSpeak!"
./teastart.sh restart