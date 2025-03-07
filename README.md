# 🎬 Movie Surf: A Flutter Application

**Movie Surf** is a Flutter application that provides users with a seamless Movie and TV show browsing experience using **The Movie Database (TMDb) API**. The app allows users to discover Movies and TV shows, view detailed information, and explore popular, upcoming, and top-rated content.

---

## ✨ Features:
- Fetch and display **popular, top-rated, and upcoming Movies and Tv Shows**.  
- Search for movies and TV shows using **Search with Query Submission**. 
- View detailed information, including **poster, release date, overview, ratings, and recommendations**.  
- Browse and view **similar and recommended Movies and TV shows**.  
- Attractive and **user-friendly UI** for smooth navigation. 

---

## 📱 Technologies Used:
- **Flutter** (for building the UI)  
- **Dart** (for application logic and API handling)  
- **HTTP Package** (for making API requests)
- **Shared Preferences** (for storing user preferences locally)  
- **Google Fonts & Lottie** (for improved UI/UX)  

---

## 📌 Dependencies:
The following dependencies are used in this project:

```yaml
    http: ^1.3.0
    flutter_dotenv: ^5.2.1
    google_fonts: ^6.2.1
    flutter_svg: ^2.0.17
    image_picker: ^1.1.2
    shared_preferences: ^2.5.2
    lottie: ^3.3.1
```

---

## 🔗 API Integration:
The app integrates with **The Movie Database (TMDb) API** to fetch real-time movie and TV show data. More details about the API can be found [here](https://developer.themoviedb.org/reference/intro/getting-started). and, 
The following APIs are used in this project:

### 🎥 Movie APIs:
#### Upcoming Movies:
```bash
https://api.themoviedb.org/3/movie/upcoming?api_key=[Your-API-Key]&page=[PageNumber]
```
#### Now Playing Movies:
```bash
https://api.themoviedb.org/3/movie/now_playing?api_key=[Your-API-Key]&page=[PageNumber]
```
#### Movie Images:
```bash
https://api.themoviedb.org/3/movie/[MovieID]/images?api_key=[Your-API-Key]
```
#### Similar Movies:
```bash
https://api.themoviedb.org/3/movie/[MovieID]/similar?api_key=[Your-API-Key]
```
#### Recommended Movies:
```bash
https://api.themoviedb.org/3/movie/[MovieID]/recommendations?api_key=[Your-API-Key]
```
#### Search Movie:
```bash
https://api.themoviedb.org/3/search/movie?query=[MovieName]&api_key=[Your-API-Key]
```

### 📺 TV Show APIs:
#### Popular TV Shows:
```bash
https://api.themoviedb.org/3/tv/popular?api_key=[Your-API-Key]
```
#### Top Rated TV Shows:
```bash
https://api.themoviedb.org/3/tv/top_rated?api_key=[Your-API-Key]
```
#### Airing Today TV Shows:
```bash
https://api.themoviedb.org/3/tv/airing_today?api_key=[Your-API-Key]
```
#### TV Show Images:
```bash
https://api.themoviedb.org/3/tv/[TvShowID]/images?api_key=[Your-API-Key]
```
#### Similar TV Shows:
```bash
https://api.themoviedb.org/3/tv/[TvShowID]/similar?api_key=[Your-API-Key]
```
#### Recommended TV Shows:
```bash
https://api.themoviedb.org/3/tv/[TvShowID]/recommendations?api_key=[Your-API-Key]
```
#### Search TV Show:
```bash
https://api.themoviedb.org/3/search/tv?query=[TvShowName]&api_key=[Your-API-Key]
```

### 🖼️ Image Base URL:
```bash
https://image.tmdb.org/t/p/w500/[ImageName]
```

---

## 📌 Setup Instructions:
1. Clone the Repository: 
   ```bash
   https://github.com/PAIshanMadusha/MovieSurf-Application.git
   ```
   
2. Install Dependencies: 
   ```bash
   flutter pub get
   ```
   
3. Setting Up the TMDb API Key:

- **Obtain an API key** from [TMDb](https://developer.themoviedb.org/).  
- **Create a `.env` file** in the root of project.
- **Add your API key** to the `.env` file:  

   ```env
   MY_MOVIE_API_KEY = [Your-API-Key]
   ```
- Replace `[Your-API-Key]` with your actual API key from TMDb.

5. Run the App:

   ```bash
   flutter run
   ```

---

## 📸 System Screenshots:

<p align="center">
  <img src="https://github.com/user-attachments/assets/3ab53844-2e11-45cf-b511-b2a2cb9ec04f" alt="Screenshot 1" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/4468a250-4a7f-4b3d-80d2-a74ce3d80d8e" alt="Screenshot 2" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/55505eb7-b01e-48a2-b539-eaf33b4fdb81" alt="Screenshot 3" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/d79e8565-d661-40b7-a9e0-36b20c0948d4" alt="Screenshot 1" width="175">&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/f1520180-e8e7-4d3a-9769-b1abfba0b21c" alt="Screenshot 2" width="175">&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/682fc3b2-7c9a-4dd7-8c3e-e0f3b19b5457" alt="Screenshot 3" width="175">&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/ebcc12da-4c34-4b42-946d-47b699dde1c1" alt="Screenshot 4" width="175">&nbsp;&nbsp;&nbsp;
</p>
<br>
<p align="center">
  <img src="https://github.com/user-attachments/assets/75643b5e-2b56-4fb7-9d9c-e043a2e14e54" alt="Screenshot 1" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/72e0189c-15cf-4e6f-83da-f60806cd616f" alt="Screenshot 2" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://github.com/user-attachments/assets/4010552d-d698-4412-ae5d-6468df3b64d6" alt="Screenshot 3" width="175">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</p>

---

## 👤 About This Project:

Movie Surf is a Flutter app that allows users to explore movies and TV shows using the TMDb API. It lets users browse upcoming movies, now-playing films, popular TV shows, and search for specific titles. Also, Movie Surf aims to provide an enjoyable and efficient way for users to stay updated with their favorite movies and TV shows.

### 👨‍💻 Created by: 
**Ishan Madhusha**  
GitHub: [PAIshanMadusha](https://github.com/PAIshanMadusha)

Feel free to explore my work and get in touch if you'd like to collaborate! 🚀

---

## 📝 License  
This project is open-source and available under the MIT License.
