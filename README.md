## Demo Chat App

a simple chat application, containing both a mobile client app in [Flutter](https://github.com/flutter/flutter) and a server-side nodeJS app. This project uses [Socket IO](https://socket.io/) both on the server and [client](https://pub.dev/packages/socket_io_client) side.

[Demo Video](https://github.com/emadghasempour/demo_chat_app/blob/main/demo_video/chat_app_demo.mov)

#### Features:

*   Choosing a username for yourself.
*   See a list of currently available rooms.
*   Create a new room.
*   Join a room and chat with other users in that room.

Notes:

*    Socket URL is statically set to [`http://10.0.2.2:5001`](http://10.0.2.2:5001) to work on emulators. if you need to test somewhere else you can set the URL [here](https://github.com/emadghasempour/demo_chat_app/blob/e365a866e1a42579eea141d0434bd6b1e2a118ac/chat_app_mobile/lib/core/services/chat_service/chat_service.dart#L63)