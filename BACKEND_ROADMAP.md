# FilmShelf Backend Roadmap

This roadmap covers the backend work needed to support the Flutter app with real users, real movie data, watchlists, filters, and reminders.

## Backend Goal

Build a secure API and database layer that lets FilmShelf users discover movies, save movies to their library, set preferences, and receive reminders for upcoming releases they care about.

## Phase 1: Core Setup

- Use FastAPI with Python.
- Use PostgreSQL as the primary database.
- Add environment configs for local, staging, and production.
- Add request validation, structured errors, logging, and CORS config.
- Add OpenAPI/Swagger documentation.
- Add database migrations and seed data.

## Phase 2: Authentication And Users

- User sign up.
- User login.
- Password hashing.
- JWT access tokens and refresh tokens.
- Logout/token invalidation.
- Current user profile endpoint.
- Edit profile endpoint.

Suggested endpoints:

```text
POST /auth/signup
POST /auth/login
POST /auth/logout
POST /auth/refresh
GET  /me
PATCH /me
```

## Phase 3: Movie Data

- Decide whether to seed movies locally or proxy a movie API such as TMDB.
- Keep external API keys on the backend, never in the Flutter app.
- Return consistent movie objects to the frontend.
- Support pagination.
- Support detail pages.

Suggested endpoints:

```text
GET /movies
GET /movies/:id
GET /movies/trending
GET /movies/coming-soon
GET /movies/released
GET /movies/search?q=
GET /genres
```

Supported query filters:

```text
genre
release_status
year
min_rating
streaming_service
sort
page
limit
```

## Phase 4: Watchlist / Library

- Let users save movies to their personal library.
- Let users remove saved movies.
- Track optional personal metadata later: watched status, personal rating, notes, favorites.

Suggested endpoints:

```text
GET    /watchlist
POST   /watchlist/:movieId
DELETE /watchlist/:movieId
PATCH  /watchlist/:movieId
```

## Phase 5: Upcoming Movie Reminders

Users should be able to tap a "Remind Me" option on upcoming movies they want to follow.

Backend responsibilities:

- Store reminder preferences per user and movie.
- Prevent duplicate reminders for the same user/movie pair.
- Support reminder timing, such as on release day, one day before, or one week before.
- Allow users to cancel reminders.
- Return reminder status with movie details and coming-soon lists.
- Send notifications later through push notifications, email, or both.

Suggested endpoints:

```text
GET    /reminders
POST   /reminders/:movieId
PATCH  /reminders/:movieId
DELETE /reminders/:movieId
```

Example reminder payload:

```json
{
  "movieId": "movie_123",
  "remindAt": "one_day_before",
  "channels": ["push"]
}
```

Suggested reminder fields:

```text
id
user_id
movie_id
remind_at
channels
status
created_at
updated_at
```

Suggested reminder statuses:

```text
active
sent
cancelled
failed
```

## Phase 6: User Preferences

- Region/country.
- Language.
- Streaming services.
- Notification settings.
- Reminder defaults for upcoming movies.
- Theme preference.

Suggested endpoints:

```text
GET   /me/preferences
PATCH /me/preferences
```

## Phase 7: Notification Delivery

- Add a scheduled worker for reminder delivery.
- Add push notification token storage.
- Add retry behavior for failed reminder sends.
- Add notification history.
- Respect user notification preferences.

Suggested endpoints:

```text
POST   /devices
DELETE /devices/:deviceId
GET    /notifications
PATCH  /notifications/:notificationId/read
```

## Suggested Database Tables

```text
users
movies
genres
movie_genres
watchlist_items
user_preferences
streaming_services
movie_streaming_services
movie_reminders
user_devices
notifications
```

## First Backend Milestone

The first useful backend version should support:

```text
POST /auth/signup
POST /auth/login
GET  /movies
GET  /movies/:id
GET  /genres
GET  /movies?genre=&min_rating=&release_status=&sort=
GET  /watchlist
POST /watchlist/:movieId
DELETE /watchlist/:movieId
POST /reminders/:movieId
DELETE /reminders/:movieId
```

That gives the Flutter app enough backend support for login, movie discovery, filtering, watchlists, and "Remind Me" for upcoming movies.
