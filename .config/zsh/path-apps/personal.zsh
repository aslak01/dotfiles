# custom bin
export PERSONALBIN="$HOME/bin"
if [ -d "$PERSONALBIN" ]; then
    [[ :$PATH: == *":$PERSONALBIN:"* ]] || PATH+=":$PERSONALBIN"
fi
