# Simple TCP Chat Server in x86_64 Assembly

A lightweight, multi-process TCP chat server written entirely in **x86_64 Assembly (Linux)** using the Flat Assembler (FASM). 

This project was built to explore low-level network programming. It interacts directly with the Linux kernel via raw system calls, completely bypassing standard C libraries (`libc`). 

## 🚀 Features
* **Zero Dependencies:** No external libraries used. Pure communication with the Linux kernel.
* **Multi-Process Concurrency:** Uses `sys_fork` to clone the process, allowing asynchronous, bidirectional communication between clients without blocking I/O.
* **Tiny Binary Footprint:** The compiled executable is incredibly small (under 1 KB).
* **Direct Syscalls:** Implements raw Linux syscalls for networking (`socket`, `bind`, `listen`, `accept`).

## 🛠️ Under the Hood (System Calls Used)
* `sys_socket` (41) - Creates the IPv4 TCP socket.
* `sys_bind` (49) - Binds the socket to port `8080` (Big-Endian).
* `sys_listen` (50) - Puts the server in listening mode.
* `sys_accept` (43) - Accepts incoming connections (handles two clients).
* `sys_fork` (57) - Forks the server to handle real-time cross-relaying of messages.
* `sys_read` (0) / `sys_write` (1) - Handles the I/O between the clients.

## ⚙️ Prerequisites
* Linux OS (x86_64)
* [FASM](https://flatassembler.net/) (Flat Assembler)

## How to Build and Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Syn4pse773/simple-tcp-server.git
   cd simple-tcp-server
   ```

2. **Compile the source code:**
   ```bash
   fasm server.asm
   chmod +x server
   ```

3. **Start the server:**
   ```bash
   ./server
   ```
   *The server will start and wait for exactly two clients to connect on port 8080.*

## How to Test (Chatting)

Open two new terminal windows to act as clients.

**Terminal 1 (Client 1):**
```bash
nc 127.0.0.1 8080
```

**Terminal 2 (Client 2):**
```bash
nc 127.0.0.1 8080
```

Now you can type a message in Terminal 1, and it will instantly appear in Terminal 2 with the `[CLIENT 1]: ` prefix, and vice versa!

## License
This project is open-source and available under the MIT License.

MIT License

Copyright 2026 Syn4pse773

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

