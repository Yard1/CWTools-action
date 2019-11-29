if [ -z "$INPUT_CWTOOLSACTIONREF" ] || [ "$INPUT_CWTOOLSACTIONREF" = "" ]; then
    INPUT_CWTOOLSACTIONREF="gitlab-integration"
fi

if [ -z "$INPUT_REVIEWDOGREF" ] || [ "$INPUT_REVIEWDOGREF" = "" ]; then
    INPUT_REVIEWDOGREF="master"
fi

apt-get update && apt-get -y install ruby bash git wget p7zip
wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/$INPUT_REVIEWDOGREF/install.sh| sh -s -- -b /usr/local/bin/

cd /
git clone --depth=1  --single-branch --branch $INPUT_CWTOOLSACTIONREF https://github.com/cwtools/cwtools-action.git action
cd action
git fetch
git pull
cd lib
chmod +x entrypoint.sh
./entrypoint.sh