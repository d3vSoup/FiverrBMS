# Google OAuth Setup Instructions

## Update Your .env File

Please update your `.env` file in the `fiverrfront` directory with your new Google OAuth credentials:

```env
VITE_GOOGLE_CLIENT_ID=YOUR_GOOGLE_CLIENT_ID_HERE
```

**Note:** The Client Secret is not needed for frontend Google Sign-In. It's only used for server-side OAuth flows.

**How to get your credentials:**
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select existing one
3. Enable Google+ API
4. Go to "Credentials" > "Create Credentials" > "OAuth client ID"
5. Choose "Web application"
6. Add authorized JavaScript origins and redirect URIs (see below)
7. Copy the Client ID to your `.env` file

## Authorized URLs

Make sure your Google Cloud Console OAuth client has these URLs configured:

### Authorized JavaScript origins:
- `http://localhost:5173` (Vite dev server)
- `http://localhost:3000` (if using different port)
- Your production domain (e.g., `https://yourdomain.com`)

### Authorized redirect URIs:
- `http://localhost:5173` (Vite dev server)
- `http://localhost:3000` (if using different port)
- Your production domain (e.g., `https://yourdomain.com`)

## How It Works

1. **Welcome Modal**: When users visit the sign-in page, a Welcome modal appears (similar to the merch project) with Google Sign-In button
2. **Navbar Button**: The Google Sign-In button also appears in the navbar when not signed in
3. **Database Sync**: All sign-ins automatically sync with Supabase:
   - Creates user if doesn't exist
   - Updates user profile (name, image) if exists
   - Loads cart and wishlist from database
   - Validates email domain (only @bmsce.ac.in, @bmsca.org, @bmscl.ac.in allowed)

## Testing

After updating the `.env` file:
1. Restart your dev server (`npm run dev`)
2. Navigate to `/signin` or click the profile button
3. The Welcome modal should appear with Google Sign-In button
4. Click "Sign in with Google" and authenticate
5. Your user data will be saved to Supabase automatically

