# Mobile GamePad

Mobile GamePad is an application that turns a mobile phone (Android and iOS) into an input device for a computer (Linux and Windows).

It uses `uinput` on Linux and `ViGEmBus` on Windows to generate virtual controller events from the mobile device.

## Modules

The project is organized into the following modules:

- Core (in development)
- Mobile (in development)
- Server (in development)
- TrayIcon (planned)
- Desktop (planned)
- CLI (planned)

## Core

The Core module defines the necessary infrastructure to communicate between modules and to share the common domain model used across the application.

### Relevant classes

- Event: all information exchanged between the mobile app and the server must be represented as an event, and each event must include its corresponding event code.
- PlayerEvent: events originated on the mobile side.
- ServerEvent: events originated on the server side.
- Heartbeat: automation for ping/pong communication and connection status monitoring.

## Mobile

The mobile app acts as the controller interface. It captures the user's input and sends it to the server so it can be translated into virtual device events.

## Server

The server is the communication bridge between the mobile client and the target computer. It receives input events from the phone, validates them, and forwards them to the virtual device layer.

## Desktop / TrayIcon / CLI

These modules provide the user-facing desktop integration and tools needed to manage the application, monitor connection state, and expose additional controls or automation from the computer side.

## Architecture

The system follows a client-server architecture:

1. The mobile phone captures user input.
2. The input is serialized into events.
3. The server receives and processes those events.
4. The operating system-specific virtual device layer transforms them into native controller input.

This design keeps the controller logic separated from the platform-specific device emulation layer, making the project easier to extend for Linux and Windows.


## Notes

This project is still under active development, and the architecture and modules may evolve as the implementation matures.
