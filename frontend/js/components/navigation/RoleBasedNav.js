function RoleBasedNav(userRole) {
    const navItems = {
        admin: [
            { icon: '📢', label: 'Announcements', feature: 'announcements' },
            { icon: '🚨', label: 'Safety', feature: 'safety' },
            { icon: '📅', label: 'Events', feature: 'events' },
            { icon: '🤝', label: 'Resources', feature: 'resources' },
            { icon: '👥', label: 'Users', feature: 'users' },
            { icon: '⚙️', label: 'Settings', feature: 'settings' }
        ],
        moderator: [
            { icon: '📢', label: 'Announcements', feature: 'announcements' },
            { icon: '🚨', label: 'Safety', feature: 'safety' },
            { icon: '📅', label: 'Events', feature: 'events' },
            { icon: '🤝', label: 'Resources', feature: 'resources' },
            { icon: '✍️', label: 'Moderation', feature: 'moderation' }
        ],
        resident: [
            { icon: '📢', label: 'Announcements', feature: 'announcements' },
            { icon: '🚨', label: 'Safety', feature: 'safety' },
            { icon: '📅', label: 'Events', feature: 'events' },
            { icon: '🤝', label: 'Resources', feature: 'resources' }
        ]
    };

    return `
        <div class="space-y-1">
            ${navItems[userRole].map(item => `
                <div class="feature-item" data-feature="${item.feature}">
                    <span>${item.icon}</span>
                    <span>${item.label}</span>
                </div>
            `).join('')}
        </div>
    `;
}
