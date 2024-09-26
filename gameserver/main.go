package main

import (
    "log"
    "net"
    "sync"
)

const DEFAULT_PORT = "9999"

var (
    connections = make([]net.Conn, 0)
    mu            sync.Mutex
)

type Message struct {
    content   []byte
    broadcast bool
}

func readMessages(conn net.Conn, writeChan chan Message, username string) {
    buffer := make([]byte, 1024)
    for {
        n, err := conn.Read(buffer)
        if err != nil {
            log.Printf("Could not read from %s: %s\n", conn.RemoteAddr(), err)
            return
        }
        log.Printf("Recieved from %s: %s", conn.RemoteAddr(), string(buffer[:n]))

        response := []byte("Broadcasting to everyone.\n")
        writeChan <- Message{response, false}

        broadcastMessage := append([]byte(username+": "), buffer[:n]...)
        writeChan <- Message{broadcastMessage, true}
    }
}

func writeMessages(conn net.Conn, writeChan chan Message) {
    for message := range writeChan {
        mu.Lock()
        if (message.broadcast) {
            for _, c := range connections {
                if c != conn { // Don't broadcast to self.
                    _, err := c.Write(message.content)
                    if err != nil {
                        log.Printf("Could not broadcast to %s: %s\n", c.RemoteAddr(), err)
                    }
                }
            }
        } else {
            _, err := conn.Write(message.content)
            if err != nil {
                log.Printf("Could not write to %s: %s\n", conn.RemoteAddr(), err)
            }
        }
        mu.Unlock()
    }
}

func handleConnection(conn net.Conn) {
    defer conn.Close()

    // Add the connection.
    mu.Lock()
    username := "User" + string(len(connections)+'A')
    connections = append(connections, conn)
    mu.Unlock()

    message := append(append([]byte("Wellcome "), []byte(username)...), []byte(".\n")...)
    _, err := conn.Write(message)
    if err != nil {
        log.Printf("Could not write greeting message to %s: %s\n", conn.RemoteAddr(), err)
        return
    }

    var wg sync.WaitGroup
    writeChan := make(chan Message)

    // Write
    wg.Add(1)
    go func() {
        defer wg.Done()
        writeMessages(conn, writeChan)
    }()
    // Read
    wg.Add(1)
    go func() {
        defer wg.Done()
        readMessages(conn, writeChan, username)
    }()

    wg.Wait()
    close(writeChan)

    // Remove the connection.
    mu.Lock()
    for i, c := range connections {
        if c == conn {
            connections = append(connections[:i], connections[i+1:]...)
            break
        }
    }
    mu.Unlock()

    log.Printf("Closing connection to %s\n", conn.RemoteAddr())
}

func startServer(port string) {
    ln, err := net.Listen("tcp", ":"+port)
    if err != nil {
        log.Fatalf("Could not open a TCP listener on port %s: %s\n", port, err)
    }
    log.Printf("Started game server on port %s.\n", port)
    for {
        conn, err := ln.Accept()
        if err != nil {
            log.Printf("Could not accept connection: %s\n", err)
            continue
        }
        log.Printf("Accepted connection from %s\n", conn.RemoteAddr())
        go handleConnection(conn)
    }
}

func main() {
    startServer(DEFAULT_PORT)
}
