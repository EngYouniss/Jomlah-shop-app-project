# 🛍️ Flutter E-Commerce App

A simple mobile application built using Flutter that serves as the foundation of a full-featured e-commerce marketplace. The app includes product categories, user authentication, organized file structure, and more.

> ⚠️ **Note:** This project is currently **on hold** and not in active development.

---

## 📱 Project Idea

The goal of this project is to provide a clean and modular foundation for an e-commerce app. It displays product categories, uses real-time image loading from an API, supports authentication, and handles connectivity status.

---

## ✅ Implemented Features

- 🔐 User authentication with **Firebase Authentication**
- 🖼️ Dynamic image slider using `ImageSlideshow` with images fetched from API
- 🗃️ Product categories such as: Canned Food, Dairy, Oils, Drinks, Baked Goods, etc.
- 💾 Local data storage using `SharedPreferences`
- 🌐 Data fetching from REST API using `Dio`
- 📷 Image selection from gallery using `Image Picker`
- 🔄 State management using `Provider`
- 🌍 Internet connection checking using `Internet Connection Checker`
- 🧱 Well-structured project folders for scalability

---

## 🛠️ Technologies & Packages Used

| Technology / Package          | Purpose                          |
|-------------------------------|----------------------------------|
| Flutter                       | Mobile app development           |
| Firebase Auth                 | User authentication              |
| Dio                           | REST API communication           |
| Provider                      | State management                 |
| Image Picker                  | Pick images from gallery         |
| Shared Preferences            | Local data storage               |
| Image Slideshow               | Image carousel / slideshow       |
| Internet Connection Checker   | Network connectivity check       |
| Structured File Architecture  | Clean code organization          |

---

## 📁 Folder Structure


├── core/
│ ├── views/
│ │ ├── screens/
│ │ └── widgets/
│ ├── models/
│ ├── viewmodels/
│ ├── constants/
│ └── helpers/
├── main.dart

