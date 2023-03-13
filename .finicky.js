module.exports = {
	defaultBrowser: 'Safari',
	handlers: [
		{
			match: ['*.labdevs.com/*', '*.trello.com/*', '*.monday.com/*', 'monday.com/*', '*.serif.com/*', 'serif.com/*', '*.basecamp.com/*', 'basecamp.com/*', '*.cloudflare.com/*', 'cloudflare.com/*', '*.google.com/*', 'google.com/*', '*.atlassian.com/*', 'atlassian.com/*', '*.figma.com/*', 'figma.com/*', '*.folq.com/*', 'folq.com/*', 'notion.so', '*.notion.so/*', 'teams.microsoft.com/*'],
			browser: '/Applications/Google Chrome.app',
		},
	],
	options: { logRequests: true },
};
