launchctl load ~/Library/LaunchAgents/com.lemonade.lemonade.plist
launchctl start com.lemonade.lemonade.plist
launchctl enable "user/$UID/com.lemonade.lemonade.plist"

