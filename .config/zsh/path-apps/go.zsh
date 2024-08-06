# go
export GOPATH="$HOME/go"
if [ -d $GOPATH ]; then
    [[ :$PATH: == *":$GOPATH/bin:"* ]] || PATH+=":$GOPATH/bin"
fi

export GOROOT="$(brew --prefix golang)/libexec"
if [ -d "$GOROOT" ]; then
    [[ :$PATH: == *":$GOROOT/bin:"* ]] || PATH+=":$GOROOT/bin"
fi
