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

if [ -d "instances/$1" ] 
then
    echo "Instance already exists!"
    exit 1
fi

mkdir instances/$1
cp -r data/* instances/$1
