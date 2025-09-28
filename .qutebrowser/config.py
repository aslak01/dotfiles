config.load_autoconfig()

# ============================================================
# THEME & APPEARANCE
# ============================================================

# Dracula theme
import dracula

dracula.blood(c, {"font": {"size": 11}})

# Dark mode preferences
c.colors.webpage.preferred_color_scheme = "auto"
c.colors.webpage.darkmode.enabled = False

# ============================================================
# ALIASES - Command shortcuts
# ============================================================

c.aliases = {
    # Core functionality
    "o": "open",
    "q": "quit",
    "incognito": "open --private",
    # Config management
    "reload-config": "config-source",
    "adblock-toggle": "config-cycle -t content.blocking.enabled",
    "dark": "config-cycle colors.webpage.preferred_color_scheme dark light auto",
    "js-toggle": "config-cycle -t content.javascript.enabled",
    # External browsers
    "chromium": "spawn --detach chromium {url}",
    "throrium": "spawn --detach throrium-browser {url}",
    "firefox": "spawn --detach firefox {url}",
    # Media and utilities
    "mpv": "spawn --detach /opt/homebrew/bin/mpv {url}",
    "qrcode": 'spawn st -e watch --color -t -x qrcode-terminal "{url}"',
    "json": "spawn --userscript ~/.qutebrowser/userscripts/json_format",
    # Authentication
    "lastpass": "hint --first inputs ;; spawn --userscript qute-lastpass",
}

# ============================================================
# CORE SETTINGS - Backend and Qt configuration
# ============================================================

c.backend = "webengine"

# Fix for crashes
c.qt.workarounds.remove_service_workers = True

# Qt/GPU configuration - uncomment if experiencing freezes
# c.qt.force_software_rendering = 'chromium'

# ============================================================
# CONTENT & PRIVACY SETTINGS
# ============================================================

# Cookie management - restrict to same origin for better privacy
c.content.cookies.accept = "no-3rdparty"

# Performance and privacy optimizations
c.content.dns_prefetch = True
c.content.headers.do_not_track = True
c.content.blocking.enabled = True
c.content.blocking.whitelist = []

# JavaScript clipboard access
c.content.javascript.clipboard = "access-paste"

# Disable website notifications
if type(c.content.notifications) == str:
    c.content.notifications = False
else:
    c.content.notifications.enabled = False

# ============================================================
# SECURITY & PRIVACY ENHANCEMENTS
# ============================================================

# Enhanced cookie management - don't persist cookies across sessions
c.content.cookies.store = False

# Better security isolation
c.content.site_isolation = True

# Enhanced blocking method
c.content.blocking.method = "both"

# Disable hyperlink auditing for privacy
c.content.hyperlink_auditing = False

# Set referer policy for better privacy
c.content.headers.referer = "same-domain"

# Disable geolocation by default
c.content.geolocation = "ask"

# Disable desktop capture by default
c.content.desktop_capture = "ask"

# User agent for better privacy (generic Linux)
c.content.headers.user_agent = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"

# ============================================================
# PERFORMANCE OPTIMIZATIONS
# ============================================================

# Set cache size limit (500MB)
c.content.cache.size = 500 * 1024 * 1024

# Maximum pages in memory cache
c.content.cache.maximum_pages = 10

# Prefer reduced motion for better performance
c.content.prefers_reduced_motion = True

# ============================================================
# UI & INTERFACE SETTINGS
# ============================================================

c.downloads.position = "bottom"

# External editor command
c.editor.command = ["st", "-e", "vim", "{file}"]

# Font configuration
c.fonts.default_family = ["Inter"]
c.fonts.default_size = "14pt"

# Hint behavior - auto-follow single hints
c.hints.auto_follow = "always"

# Input mode behavior
c.input.insert_mode.auto_load = True
c.input.insert_mode.leave_on_load = True

# Scrollbar behavior
c.scrolling.bar = "when-searching"

# Spell checking - uncomment to enable
# c.spellcheck.languages = ['en-US']

# Statusbar configuration
c.statusbar.widgets = ["url"]

# Tab behavior
c.tabs.background = True
c.tabs.show = "multiple"
c.tabs.title.format = "{audio} {current_title}"

# URL handling
c.url.default_page = "about:blank"
c.url.open_base_url = True

# ============================================================
# SEARCH ENGINES - Organized by category
# ============================================================

SEARCH_ENGINES = {
    # General search
    "g": "https://google.com/search?q={}",
    "dd": "https://duckduckgo.com/?q={}",
    # Development & Code
    "gh": "https://github.com/search?type=Repositories&q={}",
    "ghc": "https://github.com/search?type=Code&q={}",
    "npm": "https://www.npmjs.com/search?q={}",
    "nix": "https://search.nixos.org/packages?query={}",
    "aur": "https://aur.archlinux.org/packages/?SB=p&SO=d&O=0&K={}",
    # Language-specific
    "hs": "https://hoogle.haskell.org/?hoogle={}",
    "hackage": "https://hackage.haskell.org/packages/search?terms={}",
    "purs": "https://pursuit.purescript.org/search?q={}",
    "ghhs": "https://github.com/search?l=haskell&type=Code&q={}",
    "ghps": "https://github.com/search?l=purescript&type=Code&q={}",
    # Work-specific (DBM)
    "dbg": "https://github.com/dbmedialab/{}",
    "dbr": "https://github.com/search?q=org%3Adbmedialab+{}&type=repositories",
    "dbc": "https://github.com/search?q=org%3Adbmedialab+{}&type=code",
    # Entertainment & Media
    "yt": "https://www.youtube.com/results?search_query={}",
    "giphy": "https://giphy.com/search/{}",
    # Shopping
    "amazon": "https://www.amazon.com/s?k={}",
    # Legacy aliases
    "?": "https://google.com/search?q={}",
    "?dd": "https://duckduckgo.com/?q={}",
    "?github": "https://github.com/search?type=Repositories&q={}",
    "?youtube": "https://www.youtube.com/results?search_query={}",
    "DEFAULT": "https://google.com/search?q={}",
}

c.url.searchengines = SEARCH_ENGINES

# Startup and window configuration
c.url.start_pages = ["about:blank"]
c.window.hide_decoration = True

# ============================================================
# KEY BINDINGS
# ============================================================

c.bindings.commands = {
    "normal": {
        "+": "zoom-in",
        ",<Space>": "search",
        ",C": "tab-only",
        ",M": "hint links spawn --detach /opt/homebrew/bin/mpv {hint-url}",
        ",b": "set-cmd-text -s :buffer",
        ",c": "tab-close",
        ",e": "set-cmd-text -s :open",
        ",h": "history",
        ",m": "spawn --detach /opt/homebrew/bin/mpv {url}",
        ",q": "tab-prev",
        ",w": "tab-next",
        "-": "zoom-out",
        "<Alt-D>": "edit-url",
        "<Ctrl-+>": "zoom-in",
        "<Ctrl-->": "zoom-out",
        "<Ctrl-0>": "zoom",
        "<Ctrl-Shift-Tab>": "tab-prev",
        "<Ctrl-Tab>": "tab-next",
        "<Ctrl-f>": "set-cmd-text /",
        "<Ctrl-i>": "forward",
        "<Ctrl-o>": "back",
        "<Ctrl-p>": "lastpass",
        "<Ctrl-a>": "mode-enter passthrough",
        "=": "zoom",
        "?": "set-cmd-text :open -t ?",
        "F": "hint links tab-bg",
        "gi": "hint inputs",
        "<cmd-1>": "tab-focus 1",
        "<cmd-2>": "tab-focus 2",
        "<cmd-3>": "tab-focus 3",
        "<cmd-4>": "tab-focus 4",
        "<cmd-5>": "tab-focus 5",
        "<cmd-6>": "tab-focus 6",
        "<cmd-7>": "tab-focus 7",
        "<cmd-8>": "tab-focus 8",
        "<cmd-9>": "tab-focus 9",
    },
    "insert": {
        "<Ctrl-+>": "zoom-in",
        "<Ctrl-->": "zoom-out",
        "<Ctrl-0>": "zoom",
        "<Ctrl-e>": "edit-text",
        "<Ctrl-i>": "edit-text",
        "<Escape>": "mode-leave ;; jseval -q document.activeElement.blur()",
    },
}

