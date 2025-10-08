# 🎧 Audiobook App

A simple **Audiobook / Podcast listing app** built with **Swift 6** and **SwiftUI**, following the **MVVM architecture pattern**.  
The app fetches podcasts from the [ListenNotes API](https://www.listennotes.com/api/docs/) and supports pagination, favorites, and cached image loading for performance.

---

## 🚀 Features

- ✅ Fetch and display a list of podcasts from ListenNotes API  
- ✅ Pagination (loads 10 items at a time)  
- ✅ Favorite podcasts (persisted locally by ID)  
- ✅ Cached image loading using a custom `ImageCache` and `CachedAsyncImage`  
- ✅ MVVM + Repository + Service architecture  
- ✅ Async/Await networking with `URLSession`  
- ✅ SwiftUI declarative UI  
- ✅ Dependency composition via `AppComposer`

---

## 🧩 Architecture Overview

- **View (SwiftUI)** → Displays data and observes the ViewModel  
- **ViewModel (MVVM)** → Contains presentation logic and handles pagination & favorite state  
- **Repository** → Abstracts data sources (API / local cache)  
- **Service** → Handles network requests and decoding  
- **AppComposer** → Injects dependencies cleanly  

---

## 📡 API Used

- **Endpoint:** `GET https://listen-api-test.listennotes.com/api/v2/best_podcasts`
- **Parameters:**  
  - `page` → used for pagination  
- **Docs:** [ListenNotes API Docs](https://www.listennotes.com/api/docs/)

---

## 🧠 Key Components

### 🔹 Networking Layer
- `Endpoint` protocol defines request configuration.
- `PodcastService` performs async requests with `URLSession`.

### 🔹 Repository
- `PodcastRepository` acts as the data provider for the ViewModel.

### 🔹 ViewModel
- `PodcastListViewModel` manages pagination, favorites, and state updates.

### 🔹 Image Caching
- `ImageCache` (singleton using `NSCache`)
- `CachedAsyncImage` (SwiftUI wrapper for loading images with caching)

### 🔹 Dependency Injection
- `AppComposer` creates and wires dependencies for the first screen.

---


### 🧪 Future Improvements
Offline support using SwiftData or CoreData
Unit tests for ViewModel and Repository
Add search functionality
Improved UI/UX with animations


👩‍💻 Author
Samuel Pinheiro Junior
iOS Developer — Swift | SwiftUI | MVVM
