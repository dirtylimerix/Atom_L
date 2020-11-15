export SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# add Android SDK platform tools to path
if [ -d "$SCRIPT_DIR/tools/platform-tools" ] ; then
  PATH="$SCRIPT_DIR/tools/platform-tools:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$SCRIPT_DIR/tools/bin" ] ; then
  PATH="$SCRIPT_DIR/tools/bin:$PATH"
fi

export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_COMPRESS=1

