if [ ! -d ".svcache" ] 
then
    mkdir .svcache
fi

if ! [[ "$1" =~ 1\.[0-9]{2}\.[0-9]{1,2} ]]; then
    echo "Invalid version number"
    exit 1
fi

if [ ! -d ".svcache/$1" ] 
then
    mkdir .svcache/$1
    wget "http://serverjars.com/api/fetchJar/servers/paper/1.12.2" -O .svcache/$1/paper-$1.jar & 
else
    echo "Version already exists! Skipping download"
fi

if [ ! -d "instances" ] 
then
    mkdir instances
fi

if [ -d "instances/$1" ] 
then
    echo "Instance already exists!"
    exit 1
fi

mkdir instances/$1
cp -rv data/* instances/$1
cp -v .svcache/$1/paper-$1.jar instances/$1
chmod +x instances/$1/start.sh

if [ -d "plugins" ]
then
    mkdir instances/$1/plugins
    cp -rv plugins/* instances/$1/plugins
fi

echo "Done! To start the server, run ./start.sh in the instances/$1 directory"
