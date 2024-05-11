# iOS Gallery App

This repository contains the source code for an iOS gallery application. The app fetches images from a remote API and displays them in a collection view.

## Features

- Fetch images from a remote API.
- Display images in a collection view with lazy loading.
- Error handling for network requests.

## Technologies Used

- Swift
- UIKit
- URLSession

## Folder Structure

- `LazyLoadingImage.swift`: Custom UIImageView subclass for lazy loading images.
- `EndPointType.swift`: Protocol defining endpoint configurations.
- `EndPointItems.swift`: Enum defining different endpoint items/modules.
- `GalleryVC.swift`: View controller for displaying the image gallery.
- `ImageCVCell.swift`: Custom collection view cell for displaying images.
- `GalleryViewModel.swift`: View model for managing gallery data and API requests.
- `APIManager.swift`: Singleton class for making API requests and handling responses.

## Setup Instructions

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the project on a simulator or a physical device.

## How to Use

- Upon launching the app, the gallery of images will be displayed.
- Scroll through the gallery to view all images.
- Images are loaded lazily as you scroll for better performance.

