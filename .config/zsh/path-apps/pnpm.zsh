# pnpm
export PNPMPATH="$HOME/Library/pnpm"
if [ -d $PNPMPATH ]; then
    [[ :$PATH: == *":$PNPMPATH:"* ]] || PATH+=":$PNPMPATH"
fi

