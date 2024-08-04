import socket
from _thread import *
import sys

server = "10.0.0.148"
port = 5555

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

try:
    s.bind((server, port))
except socket.error as e: 
    print(e)

s.listen(2)
print("Waiting for connect, Server Started")

def threaded_client(connection):
    
    reply = ""
    while True:
        try:
            data = connection.recv(2048)
            reply = data.decde("utf-8")
        
            if not data: 
                print("disconneted")
                break
            else:
                print("recieved:", reply)
                print("sending:", reply)

            connection.sendall(str.encode(reply))
        except:
            break

    print("connection lost")
    connection.close()

while True:
    connection, address = s.accept()
    print("Connection to:", address)

    start_new_thread(threaded_client, (connection, ))