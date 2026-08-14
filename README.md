<div align="center">

<a href="https://www.roblox.com/games/93978595733734/Violence-District">
  <img src="https://i.ibb.co.com/mVxPwkN4/no-Filter.webp" width="240" alt="Violence District Banner">
</a>

# Violence District — Auto Farm

Automated Lua script for **Roblox Violence District** featuring Survivor auto farming, low-population server hopping, Discord webhook integration, and automatic re-execution.

💳 **Credits:** Original source and core code developed by **[@Rzor731](https://github.com/Rzor731)** ([Rzor731/VD-AUTO-FARM](https://github.com/Rzor731/VD-AUTO-FARM)).

![Lua](https://img.shields.io/badge/Language-Lua-2C2D72?style=for-the-badge&logo=lua)
![Roblox](https://img.shields.io/badge/Platform-Roblox-E2231A?style=for-the-badge&logo=roblox)
![Status](https://img.shields.io/badge/Status-Active-22C55E?style=for-the-badge)
![Version](https://img.shields.io/badge/Version-v1.0-blue?style=for-the-badge)

</div>

### 📥 One-Liner Execution
Copy and paste this line into your executor and run it:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/zaerrruwww/zaerytta/refs/heads/main/zaer.lua"))()
```

---

## ✨ Features

- **Auto Farm (Survivor)**  
  - Detects the finish line on supported maps (Rooftop, HooksMeat, Church, etc.)  
  - Teleports the player to the finish after a short delay  
  - Automatically resets on each round  

- **Server Hop**  
  - Hops to servers with **1–3 players** when a round is active and you are a **Spectator** or **Killer**  
  - Blacklists failed servers (10 minutes) and temporary reserves candidates  
  - Native teleport failure handling with fallback JobId detection  

- **Discord Webhook**  
  - Sends detailed progress reports after each completed round  
  - Tracks **KillerChance**, **EXP**, **Screws**, **Gears**, and **Level**  
  - Calculates **delta** (changes) from the previous session  
  - Persists attribute snapshots locally to avoid duplicate reporting  
  - Includes a **Test Webhook** button for easy configuration  

- **Auto Execute**  
  - Queues the script to re‑execute automatically after teleporting (uses `queue_on_teleport` if available)  

- **Customizable UI**  
  - DPI scaling, corner radius, notification side, custom cursor  
  - Keybind menu (default: `RightShift`)  
  - All settings are saved and loaded automatically  

---

## 🛠️ Installation & Usage

1. **Get the script**  
   - Copy the raw content of `zaer.lua` from this repository.

2. **Inject with a Roblox executor**  
   - Use any modern executor (Synapse Z, Krnl, Fluxus, etc.) that supports `loadstring` and HTTP requests.

3. **Paste and execute**  
   - Paste the script into your executor and run it.

4. **Configure the GUI**  
   - Open the menu with **RightShift** (or your custom keybind).  
   - Enable **Auto Farm** and **Server Hop** as needed.  
   - Set your **Webhook URL** and enable Webhook if you want Discord notifications.

5. **Let it run**  
   - The script will automatically farm Survivor rounds, hop servers when idle, and send webhook updates.

---
