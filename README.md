# FilmShelf

FilmShelf is a Flutter movie discovery and watchlist application for users who want to follow upcoming releases, browse trending films, and manage a personal movie library.

The current application is an MVP frontend prototype with a dark Material 3 interface, mock movie data, authentication screens, filtering controls, profile settings, and a startup splash screen.

## Features

### Exploration And Discovery

- **Home Dashboard**: Featured movie carousel, genre browsing, search, advanced filters, and a trending movie grid.
- **Coming Soon**: Upcoming movie discovery with planned release tracking.
- **Hot Section**: Browse currently trending releases.
- **Smart Search**: Search movies by title, genre, or release information.

### Personal Collection

- **Library**: Save movies to a personal watchlist.
- **Movie Details**: View ratings, genres, duration, release information, and plot overview.
- **Trailers**: Trailer play button placeholder for future media integration.
- **Where To Watch**: Planned streaming availability by user region.

### User Experience

- **Authentication**: Sign in and sign up flows.
- **Splash Screen**: Displays the FilmShelf brand before entering the app.
- **Settings**: Profile, preferences, notifications, region, language, streaming services, and sign out.
- **Profile Editing**: Edit profile screen for basic user information.

## Tech Stack

- **Frontend**: [Flutter](https://flutter.dev) and Dart
- **State Management**: StatefulWidget and setState for the MVP phase
- **Planned Backend**: [FastAPI](https://fastapi.tiangolo.com/) and Python
- **Design System**: Material 3

## Backend Roadmap

See [BACKEND_ROADMAP.md](BACKEND_ROADMAP.md) for the backend handoff plan, including authentication, movie APIs, watchlists, filters, user preferences, and the "Remind Me" feature for upcoming movies.

## Getting Started

1. Clone the repository:

   ```bash
   git clone https://github.com/buraitodesu-stack/film_Shelf.git
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the app:

   ```bash
   flutter run
   ```

## Screenshots

![FilmShelf logo](assets/images/filmshelf_logo.png)

## Maintainer

Developed by **buraitodesu-stack**.
