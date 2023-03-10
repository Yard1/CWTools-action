if [ -z "$INPUT_GAME" ] || [ "$INPUT_GAME" = "" ]; then
    echo "The required INPUT_GAME enviromental variable is not set!"
    exit 1
fi

if [ -z "$INPUT_CWTOOLSACTIONREF" ] || [ "$INPUT_CWTOOLSACTIONREF" = "" ]; then
    INPUT_CWTOOLSACTIONREF="v1.1.0"
fi

if [ -z "$INPUT_REVIEWDOGREF" ] || [ "$INPUT_REVIEWDOGREF" = "" ]; then
    INPUT_REVIEWDOGREF="master"
fi

apt-get update && apt-get -y install ruby bash git wget p7zip
wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/$INPUT_REVIEWDOGREF/install.sh| sh -s -- -b /usr/local/bin/

git fetch origin $CI_DEFAULT_BRANCH

cd /
git clone --depth=1  --single-branch --branch $INPUT_CWTOOLSACTIONREF https://github.com/cwtools/cwtools-action.git action
chmod +x /action/lib/entrypoint.sh
/action/lib/entrypoint.sh
