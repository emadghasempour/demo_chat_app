const http = require('http');
const server = http.createServer();
const io = require('socket.io')(server)

let numUsers = 0;

var availableRooms = ['team-frontend', 'team-backend', 'team-mobile'];

io.on('connection', function (client) {
  let addedUser = false;

  let currentRoom;

  //Returns the list of rooms in acknowledge response.
  client.on('get-rooms', function (data, callback) {

    callback({
      rooms: JSON.stringify(availableRooms),
    });
  })

  // Join a room
  client.on('join-room', function (roomName, callback) {
    
    client.join(roomName);
    currentRoom = roomName;
    client.in(currentRoom).emit('new-user-joined',{
      username: client.username,
    })
    callback({
      status: true,
    });

    console.log('new user joined',roomName, client.username);
  })

  // Leave a room.
  client.on('leave-room', function (roomName, callback) {
    
    client.leave(roomName);
    currentRoom = '';
    client.in(roomName).emit('user-left',{
      username: client.username,
    })
    callback({
      status: true,
    });
    console.log('user left',client.username,roomName, client.id);
  });
  
  // Creates a new room.
  client.on('create-room', function (roomName) {
    if(!availableRooms.includes(roomName)){
      availableRooms.push(roomName);
      io.emit('new-room-created',{
        roomName: roomName,
      });
      console.log('new room created:',roomName);
    }
    
  });

  // Add user with [username] to a specific [roomName]
  client.on('add-user', function name(data) {

    let username = data['username'];

    client.username = username;
    numUsers++;
    addedUser = true;
    console.log('client connect...', username, client.id);

    client.emit('login', {
      numUsers: numUsers,
      newUser: username,
    })
  })

  // A message sent
  client.on('message', function name(data) {
    console.log(data);
    io.in(currentRoom).emit('message', {
      message: data,
      username: client.username,
    })
  })

  // User disconnected from socket
  client.on('disconnect', function () {
    if (addedUser) {
      numUsers--;
    }

    console.log('client disconnect...', client.id)
  })
});


var server_port = 5001;
server.listen(server_port, function (err) {
  if (err) throw err
  console.log('Listening on port %d', server_port);
});