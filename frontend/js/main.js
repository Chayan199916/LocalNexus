// Enhanced state management
const state = {
    currentSection: 'home',
    user: {
        id: '123',
        role: 'resident',
        name: 'John Doe',
        email: 'john@example.com',
        verified: true,
        permissions: {
            canCreateAnnouncements: false,
            canModerateContent: false,
            canManageUsers: false
        }
    },
    notifications: []
};

// Role-based permissions configuration
const rolePermissions = {
    admin: {
        canCreateAnnouncements: true,
        canModerateContent: true,
        canManageUsers: true
    },
    moderator: {
        canCreateAnnouncements: true,
        canModerateContent: true,
        canManageUsers: false
    },
    resident: {
        canCreateAnnouncements: false,
        canModerateContent: false,
        canManageUsers: false
    }
};

// Feature handlers
const featureHandlers = {
    announcements: () => {
        return `
            <div class="space-y-4">
                <div class="notion-card">
                    <h3 class="font-semibold">📢 Community Updates</h3>
                    <p class="text-gray-600 mt-2">Click + New to create an announcement</p>
                </div>
                <div class="notion-card">
                    <div class="flex justify-between items-start">
                        <div>
                            <h4 class="font-medium">Monthly Community Meeting</h4>
                            <p class="text-gray-600 text-sm mt-1">Join us this Saturday at 10 AM in the community hall.</p>
                        </div>
                        <span class="text-xs text-gray-500">2 hours ago</span>
                    </div>
                </div>
            </div>
        `;
    },

    safety: () => {
        return `
            <div class="space-y-4">
                <div class="notion-card bg-red-50">
                    <button class="btn-primary bg-red-600 hover:bg-red-700">
                        🚨 Report Emergency
                    </button>
                </div>
                <div class="notion-card">
                    <h4 class="font-medium">Recent Alerts</h4>
                    <div class="mt-2 space-y-2">
                        <p class="text-sm text-gray-600">No recent alerts in your area</p>
                    </div>
                </div>
            </div>
        `;
    },

    events: () => {
        return `
            <div class="space-y-4">
                <div class="notion-card">
                    <h3 class="font-semibold">📅 Upcoming Events</h3>
                    <div class="mt-4 space-y-2">
                        <div class="p-3 bg-gray-50 rounded-lg">
                            <div class="flex justify-between items-center">
                                <div>
                                    <h4 class="font-medium">Weekend Cleanup Drive</h4>
                                    <p class="text-sm text-gray-600">Saturday, 10 AM</p>
                                </div>
                                <button class="btn-primary text-sm">RSVP</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        `;
    },

    resources: () => {
        return `
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div class="notion-card">
                    <h3 class="font-semibold">🛠️ Tool Library</h3>
                    <div class="mt-4 space-y-2">
                        <div class="flex justify-between items-center p-2 bg-gray-50 rounded">
                            <span>Ladder</span>
                            <button class="text-blue-600 text-sm">Request</button>
                        </div>
                    </div>
                </div>
                <div class="notion-card">
                    <h3 class="font-semibold">🚗 Carpooling</h3>
                    <div class="mt-4 space-y-2">
                        <div class="flex justify-between items-center p-2 bg-gray-50 rounded">
                            <span>Downtown - 8 AM</span>
                            <button class="text-blue-600 text-sm">Join</button>
                        </div>
                    </div>
                </div>
            </div>
        `;
    }
};

// Initialize the application
document.addEventListener('DOMContentLoaded', () => {
    // First update user interface and permissions
    updateUserInterface();

    // Then set up navigation
    const navContainer = document.getElementById('role-based-nav');
    if (navContainer) {
        navContainer.innerHTML = RoleBasedNav(state.user.role);
        setupNavigationHandlers();
    }

    // Finally load default section
    navigateTo('announcements');
});

function updateUserInterface() {
    // Update user profile section
    document.getElementById('user-name').textContent = state.user.name;
    document.getElementById('user-role').textContent =
        state.user.role.charAt(0).toUpperCase() + state.user.role.slice(1);

    // Update permissions
    state.user.permissions = rolePermissions[state.user.role];
}

// Navigation function
function navigateTo(feature) {
    state.currentSection = feature;

    // Update active state
    document.querySelectorAll('.feature-item').forEach(item => {
        item.classList.remove('active');
        if (item.dataset.feature === feature) {
            item.classList.add('active');
        }
    });

    // Update content
    const contentArea = document.getElementById('content-area');
    const handler = featureHandlers[feature];

    if (handler) {
        contentArea.innerHTML = handler();
    } else {
        contentArea.innerHTML = `<div class="notion-card">Feature "${feature}" coming soon!</div>`;
    }

    // Update section title
    document.getElementById('current-section').textContent =
        feature.charAt(0).toUpperCase() + feature.slice(1);
}

// Handle new item creation
function handleNewItem(section) {
    switch (section) {
        case 'announcements':
            showModal('Create Announcement', `
                <input type="text" class="notion-input" placeholder="Announcement title">
                <textarea class="notion-input" placeholder="Announcement content"></textarea>
            `);
            break;
        case 'events':
            showModal('Create Event', `
                <input type="text" class="notion-input" placeholder="Event title">
                <input type="datetime-local" class="notion-input">
                <textarea class="notion-input" placeholder="Event description"></textarea>
            `);
            break;
        // Add more cases as needed
    }
}

// Simple modal implementation
function showModal(title, content) {
    const modal = document.createElement('div');
    modal.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center';
    modal.innerHTML = `
        <div class="bg-white rounded-lg p-6 w-full max-w-md">
            <h3 class="text-xl font-semibold mb-4">${title}</h3>
            ${content}
            <div class="flex justify-end space-x-2 mt-4">
                <button class="px-4 py-2 text-gray-600" onclick="this.closest('.fixed').remove()">Cancel</button>
                <button class="btn-primary">Save</button>
            </div>
        </div>
    `;
    document.body.appendChild(modal);
}

function setupNavigationHandlers() {
    document.querySelectorAll('.feature-item').forEach(item => {
        item.addEventListener('click', () => {
            const feature = item.dataset.feature;
            navigateTo(feature);
        });
    });

    // Setup new item button
    const newItemBtn = document.getElementById('new-item-btn');
    if (newItemBtn) {
        newItemBtn.addEventListener('click', () => {
            const currentSection = state.currentSection;
            if (state.user.permissions.canCreateAnnouncements ||
                currentSection === 'events' ||
                currentSection === 'resources') {
                handleNewItem(currentSection);
            } else {
                showModal('Permission Denied', `
                    <p class="text-gray-600">You don't have permission to create new items in this section.</p>
                `);
            }
        });
    }
}
