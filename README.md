## Features

- Send and receive text messages in real-time
- Create and join chat rooms
- Share images and other media files
- View online/offline status of other users
- Push notifications for new messages
- User authentication and secure login [Done]
- User profile customization

## Technologies Used

- Firebase Realtime Database
- Firebase Authentication
- Firebase Storage
- Swift programming language

## Installation

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Run the app on a simulator or on a physical iOS device.

## Known Issues
- 

# Developer Notes

### Schemes Objects vs Presentation Objects
Schemas are representations of documents stored in Firebase. They are objects that comply with the 'Codable' protocol and are used exclusively for data transfer.

On the other hand, views use presentation objects. Although these objects are similar to Schemas, their use is limited to the presentation layer of the application. This strict division between layers contributes to better organization and maintenance of the code.

### Firebase and Data Services
Although data service protocols are available, it has been decided to completely replace them with Firebase. This solution allows for data exchange with the server and local storage, which has motivated the omission of data services.

In case a custom backend is desired to replace Firebase, simply remove all Firebase libraries and implement the corresponding data services.

## Credits

SwitChat was created by Max Ward (ward.maximiliano@gmail.com).

- Firebase Documentation
- Swift Programming Guide

## License

SwitChat is licensed under the [MIT License](https://opensource.org/licenses/MIT).