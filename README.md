# Soundscape: Escape from Worldly Worries

Soundscape is a Flutter music player app designed to help users escape from worldly worries and relax with calming music suited for all moods. The app features Firebase authentication for seamless login and signup experiences, as well as a variety of audio playback functionalities, including playlists and customizable sound effects.

## Features

- Splash screen with app logo
- Onboarding screens with swipe and button navigation
- Authentication screens (Login, Sign Up, Forgot Password) using Firebase Email and Password authentication
- Playlist page for audio playback with Play All, Shuffle, and Loop functionalities
- Effects audio page to add sound effects to the playing audio
- Background audio playback with lock screen controls
- Simultaneous playback of two different audio tracks (main audio and effect audio)

## Dependencies

- `flutter`: SDK for building the app
- `firebase_auth`: For Firebase authentication
- `just_audio`: For audio playback
- `just_audio_background`: For background audio playback
- `audioplayers`: For managing audio players

## API Endpoints

- Get songs of tired category: `http://soundscape.boostproductivity.online/api/getSongs/tired`
- Get sound effects:
  - Nature: `http://soundscape.boostproductivity.online/api/getSongs/SENature`
  - Instrumental: `http://soundscape.boostproductivity.online/api/getSongs/SEInstrumental`
  - ASMR: `http://soundscape.boostproductivity.online/api/getSongs/SEAsmr`

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/soundscape-music-player.git
   cd soundscape-music-player

2. Install dependencies:
    flutter pub get
   
3. Set up Firebase for your project and update 'google-services.json' for Android.
   
4.Run the app:
  flutter run
