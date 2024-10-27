const contentHandlers = {
    announcements: {
        view: (role) => {
            const canCreate = rolePermissions[role].canCreateAnnouncements;
            return `
                <div class="space-y-4">
                    ${canCreate ? `
                        <button class="btn-primary" onclick="handleNewAnnouncement()">
                            + New Announcement
                        </button>
                    ` : ''}
                    <div id="announcements-list" class="space-y-4">
                        <!-- Announcements will be loaded here -->
                    </div>
                </div>
            `;
        },
        create: () => showModal('Create Announcement', `
            <form id="announcement-form" class="space-y-4">
                <input type="text" 
                       class="notion-input" 
                       placeholder="Announcement title"
                       required
                >
                <textarea class="notion-input" 
                          placeholder="Announcement content"
                          rows="4"
                          required
                ></textarea>
                <div class="flex justify-end space-x-2">
                    <button type="button" 
                            class="btn-secondary" 
                            onclick="closeModal()"
                    >Cancel</button>
                    <button type="submit" 
                            class="btn-primary"
                    >Post Announcement</button>
                </div>
            </form>
        `)
    }
};
