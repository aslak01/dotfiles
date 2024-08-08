# yarn
export YARNPATH="$HOME/yarn"
if [ -d $YARNPATH ]; then
    [[ :$PATH: == *":$YARNPATH/bin:"* ]] || PATH+=":$YARNPATH/bin"
fi

export YARNGLOBALSPATH="$HOME/.config/yarn/global/node_modules/"
if [ -d $YARNGLOBALSPATH ]; then
    [[ :$PATH: == *":$YARNGLOBALSPATH/bin:"* ]] || PATH+=":$YARNGLOBALSPATH/bin"
fi
