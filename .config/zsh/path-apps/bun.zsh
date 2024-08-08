# bun
export BUNPATH="$HOME/.bun"
if [ -d $BUNPATH ]; then
    [[ :$PATH: == *":$BUNPATH/bin:"* ]] || PATH+=":$BUNPATH/bin"
    # completions
    [[ -s "$BUNPATH/_bun" ]] && source "$BUNPATH/_bun"
fi

