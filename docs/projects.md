# Project inventory

Source material for the portfolio content. Gathered by reading each repository.
Work projects are confidential, so this file stays at architecture/technique
level: no code, internal file names, protocol details, customer names, or links
to private repos. Nothing here is published until it is written into the site.

Open items for the owner are marked **TODO**.

## Owner
- Adrian Pulido, Mexico City. Targeting embedded software positions.
- Site in Spanish and English.
- Work project names may not be publishable: present them under descriptive
  names, decided project by project.

## Work (adrianTelecontrol, TM4C1294 + FT812 platform)

### 1. TeleControl v4: three-board PLC-style control platform (flagship, private)
- Company: Telecontrol, an industrial-grade development company (name may be
  used publicly).
- Replaces the previous Telecontrol controller generation (kept in the repo as
  a behavioral and Modbus-compatibility reference).
- Bare-metal platform for industrial control; reference application is an HVAC
  controller that modernizes the legacy firmware.
- Scope of v4.0: an internal step toward a PLC-like system, used by Telecontrol
  to implement its own HVAC installations, not sold to external users. Frame it
  as a platform that proved the architecture, not as a general PLC.
- Next, v4.1 (planning stage, not implemented): intended as a full PLC
  replacement with product-grade quality. Planned direction: same hardware,
  encapsulated HAL, runtime-loaded reactive GUI, Lua-owned application logic,
  and a desktop Designer (PyQt) that produces one package installed through the
  HMI's USB port. Present on the site as "what's next", without detail.
- Three boards:
  - **HMI**: TM4C1294 + external SDRAM + FT812 touch display. Operator UI,
    USB file loading, visualization.
  - **Controller**: TM4C1294 running an embedded **Lua 5.5** runtime. User
    control logic runs as scripts with an init hook and one bounded scan cycle.
  - **I/O + safety supervisor**: MSP430F248 + ADS1216 24-bit ADC. Final
    authority over physical outputs.
- Safety model: per-output minimum-on, maximum-on and cooldown timing enforced
  in firmware (not in scripts); latched emergency stop; outputs forced safe on
  link loss, stale or invalid acquisition, reset or brownout; timing maps
  staged and committed atomically; outputs stay off until a valid map exists.
- Links: versioned UART protocol (HMI to controller), SPI (controller to I/O),
  RS-485 Modbus RTU.
- Engineering rules: cooperative super-loops, ISRs limited to bounded work,
  static allocation only, protocol changes made on both ends together.
- Production features: Spanish-language production HMI with guided boot,
  operator/developer access control, encrypted script and timing-map storage
  on SD, automatic loading of production assets.
- Quality: host-side C unit tests with mocks (Modbus RTU, configuration), a
  PyQt HVAC plant simulator connected to the real board over UART,
  architecture decision records, documented safety model.
- Early prototype: first port of the Lua interpreter to TM4C1294 with SD, USB,
  EEPROM and SDRAM drivers (`ccs_new_platform_dev_workpace`, private).
- Role: sole software developer and tester. All firmware, tools, tests and docs
  in the repo are Adrian's.
- **TODO**: dates, deployment status, measurable results.

### 2. TeleGUI: reusable embedded graphics engine (private)
- Hybrid renderer for TM4C1294 + FT812: widgets composed into an RGB565
  software framebuffer in SDRAM and sent over DMA/SPI, while fast-refresh
  content such as graph traces uses FT812 display-list primitives.
- Widgets, themes with semantic palettes, BDF font rasterization, bitmap
  decoding, gesture recognition, video, FatFs storage port.
- Single product-to-engine adapter contract; engine never depends on product
  code. Versioned releases consumed as a git submodule by three products.
- Role: sole developer and tester.
- **TODO**: frame rates, memory footprint, or other numbers if measured.

### 3. UL overcurrent tester firmware (public: `UL-Overcurrent-AI`)
- TM4C1294 + external SDRAM over EPI + gen4-FT812-50T display over QuadSPI.
- Test modes: fault current, crush, sequence/profile tests, voltage presets.
- CAN link to an instrumentation board, including file transfer with checksum.
- RTC, logging, EEPROM configuration, file browser, runtime theme switching.
- First product built on TeleGUI.
- **TODO**: confirm the public repo may be linked from the portfolio.

### 4. TeleGUI Studio: desktop HMI designer (public: `telegui-studio`)
- PyQt6 app, "Qt Designer for the embedded engine": visual form editor that
  generates C form files.
- Pure-Python mirror of the engine's C API; Qt-free pixel-faithful RGB565
  renderer using the device's BDF fonts; importer for hand-written C forms;
  opens a whole product repo (events, display size, forms).
- unittest suite including conformance against the UL tester repo.

### 5. FT8x framework: R&D sandbox (public: `FT8x_Framework_v01`)
- About 20 experiments that led to TeleGUI: SPI with uDMA scatter-gather,
  SD-to-SDRAM image loading, FT812 bitmap loading, Adafruit-GFX port, SDL2
  desktop simulation, successive engine-layer prototypes.
- Shows a prototype, measure, extract workflow.

### Optional: AI-assisted development supervisor (private: `deepseek-supervisor`)
- Codex plugin + MCP server: one model plans and reviews, another implements.
  Frozen per-repo quality gates, bounded remediation rounds, local-only
  commits with audit trailers, never marks hardware-untested work deployable.
- **TODO**: decide whether to include.

## Personal (audience6killer; commits also appear as `vill4in`)

### 6. Cornelio: autonomous seed-planting robot, master controller (`Cornelio_Master_v1`)
- ESP32 firmware (ESP-IDF + FreeRTOS, Arduino as a component, C/C++),
  Oct 2024 to Jun 2025, 66 commits. README is still the ESP-IDF template.
- Modular component architecture: each subsystem is a FreeRTOS task pinned to
  a core with its own command/data queues and event-driven state:
  - traction control: dual DC motors, PCNT quadrature encoders, PID loop
    driven by a hardware gptimer ISR (moved there to fix timer jitter);
  - odometry at 10 ms;
  - pose estimation (Kalman filter task, currently fed by odometry only);
  - differential-drive controller with separate position/orientation PID
    and 20 cm / 5 deg arrival thresholds;
  - waypoint follower;
  - top-level navigation state machine (start/stop/add waypoint);
  - LoRa telemetry/command link with JSON (ArduinoJson) data center;
  - UART link with a second ESP32;
  - seed-planter mechanism: cutter disc and seed dispenser motors with
    encoders, 25 kHz MCPWM, 10 ms PID.
- Unit test tasks for traction, seed planter, data center, waypoint follower.
  Docker devcontainer for reproducible builds.
- Context: undergraduate thesis, team of four; Adrian wrote almost all the
  firmware.
- **TODO**: read the thesis for goals, hardware, results; photos or video.

### 7. qtAmberol: desktop music player (`qtAmberol_v0`)
- PyQt5 reimplementation of the GNOME player Amberol with a reworked UI,
  Apr to Sep 2024 (last touched Oct 2025), 33 commits.
- Album-art color extraction (colorthief) for a contrast-aware adaptive
  palette; waveform seek bar computed in a background thread
  (pydub/numpy/scipy); playlist; marquee titles; theme switching; frameless
  window; QSS styling. README has screenshots.

### 8. Hearil: mobile music player (`hearil`)
- Flutter (Dart), BLoC state management, `just_audio` with background
  playback, device library via `on_audio_query`, library and player views
  with custom transitions. Early stage: Mar to May 2026, 4 commits.

## Positioning notes
- Core identity: embedded engineer on ARM Cortex-M (TM4C1294) plus MSP430
  and ESP32, with safety-critical supervision, custom protocols
  (UART/SPI/CAN/RS-485 Modbus/LoRa), an embedded scripting runtime, a full
  graphics stack, and robotics control loops.
- Secondary: builds the desktop/mobile tools around firmware (PyQt, Flutter).
