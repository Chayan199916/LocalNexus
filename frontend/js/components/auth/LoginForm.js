function LoginForm() {
    return `
        <div class="notion-card max-w-md mx-auto p-6">
            <h2 class="text-2xl font-bold mb-6">Welcome to LocalNexus</h2>
            <form id="login-form" class="space-y-4">
                <div>
                    <label class="block text-sm font-medium mb-1">Email</label>
                    <input 
                        type="email" 
                        class="notion-input" 
                        required
                        placeholder="your@email.com"
                    >
                </div>
                <div>
                    <label class="block text-sm font-medium mb-1">Password</label>
                    <input 
                        type="password" 
                        class="notion-input" 
                        required
                    >
                </div>
                <button type="submit" class="btn-primary w-full">
                    Login
                </button>
            </form>
        </div>
    `;
}
