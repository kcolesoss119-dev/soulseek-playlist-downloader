# Playlist Downloader

A double-click Windows tool that downloads your Spotify playlists from Soulseek.

You export a playlist to a CSV file with [Exportify](https://exportify.app), drop that file in the `Playlists` folder, and double-click **`Download Playlists.bat`**. It finds and downloads each song using [Sockseek](https://github.com/fiso64/sockseek), prefers FLAC, and saves one folder per playlist inside a `Music` folder. Run it again later and it skips songs you already have.

No command line needed. Everything is double-clicking and editing a text file in Notepad.

---

## Before you start: what you need

> **Read this part first.** The tool won't work without all four of these.

### 1. Windows 10 or 11

It uses `.bat` files and the PowerShell that comes built into Windows. It won't run on Mac or Linux.

### 2. A Soulseek account (use a separate one)

[Soulseek](https://www.slsknet.org/) is a peer-to-peer file sharing network. That's where the music comes from: other people's shared folders.

There's no sign-up page. **You create an account by logging in once** with any Soulseek app, like the [official Soulseek client](https://www.slsknet.org/news/node/1) or [Nicotine+](https://nicotine-plus.org/). Pick a username and password, log in, and the account exists.

> ⚠️ **Use a different account from the one you use in Nicotine+ or any other Soulseek app.** Soulseek only allows one connection per account, so if this tool and your normal app share an account, they'll keep kicking each other offline.

### 3. Sockseek (downloaded separately)

Sockseek is the free command-line Soulseek downloader that does the real work. It's a separate project with its own license, so it's **not included here**. You download it yourself:

1. Go to the **[Sockseek releases page](https://github.com/fiso64/sockseek/releases)**.
2. Under the newest release, open **Assets** and download the Windows file. Its name ends in **`_win-x64.zip`** (for example `sockseek_3.0.6_win-x64.zip`).
3. Open that zip and copy **`sockseek.exe`** into the same folder as `Download Playlists.bat`.

You don't need to install anything else. Sockseek comes with everything it needs.

### 4. Exportify

[Exportify](https://exportify.app) turns your Spotify playlists into CSV files (simple spreadsheet files). It's free and runs in your browser. You'll log in with Spotify there.

---

## Exporting your Spotify playlist with Exportify

1. Go to **[exportify.app](https://exportify.app)** and click **Get Started**.
2. Log in with your Spotify account and click **Agree** to let Exportify read your playlists. (It can only read them. It can't change anything.)
3. You'll see a list of all your playlists, including **Liked Songs**. Click **Export** next to the one you want, and a `.csv` file downloads. You can also click **Export All** at the top to get every playlist at once as a zip. If you do, unzip it first.
4. Move the `.csv` file(s) into the **`Playlists`** folder (or drag them onto `Download Playlists.bat`).
5. The CSV's file name becomes the playlist's folder name inside `Music`, so rename the `.csv` first if you want a different folder name.

**Tips:**

- **Don't open the CSV in Excel and re-save it.** Excel can mess up song names and special characters. Just move the file as-is.
- The tool relies on Exportify's default column names (`Track Name`, `Artist Name(s)`, `Album Name`, and the `Duration` column), so **don't rename or delete columns**.
- **To update a playlist later,** export it again and replace the old CSV. Songs you already downloaded get skipped.

---

## A quick note on sharing and copyright

Soulseek is a **sharing community**. It only works because people share music back. Please share some of your own music folder in a Soulseek app (for example, share your `Music` folder in Nicotine+).

**You're responsible for following the copyright laws where you live.** This tool just automates searching and downloading. What you download, and whether you're allowed to, is up to you.

---

## Setup (one time)

### Step 1: Download this tool

1. On this page, click the green **Code** button, then **Download ZIP**.
2. *(Recommended)* Before opening it: right-click the downloaded zip → **Properties** → check **Unblock** at the bottom (if you see it) → **OK**. This stops Windows from showing a security warning every time you run a `.bat` file.
3. Right-click the zip → **Extract All…** → **Extract**. Put the folder somewhere easy to find, like your Desktop or Documents.

> **Don't run it from inside the zip.** Always extract it first, or it won't be able to save anything.

### Step 2: Add Sockseek

Copy `sockseek.exe` into the extracted folder (see **[What you need → Sockseek](#3-sockseek-downloaded-separately)** above). Your folder should now look like this:

```
📁 Playlist Downloader
   📄 Download Playlists.bat
   📄 Retry Missing (Deep Search).bat
   📄 Fix Windows Connection Limits (run as admin).bat
   📄 Undo Connection Fix (run as admin).bat
   📄 sockseek.exe              ← you added this
   📄 sockseek.conf.example
   📄 prep.ps1
   📄 failed.ps1
   📁 Playlists
```

### Step 3: Put in your Soulseek login

1. Double-click **`Download Playlists.bat`**.
2. The first time, it makes a settings file called `sockseek.conf` and opens it in Notepad for you.
3. Find these two lines:
   ```
   username = YOUR_SOULSEEK_USERNAME
   password = YOUR_SOULSEEK_PASSWORD
   ```
   Replace `YOUR_SOULSEEK_USERNAME` and `YOUR_SOULSEEK_PASSWORD` with your Soulseek username and password (your **separate** account). Keep the `username = ` and `password = ` parts at the start of each line.
4. Save (**Ctrl + S**) and close Notepad. Close the black window too.

The tool won't run until the placeholder login is replaced. Your login only lives in `sockseek.conf` on your own PC; it's never uploaded anywhere (the `.gitignore` file keeps it out of Git).

---

## How to use it

### 1. Export a playlist from Spotify

Export your playlist with Exportify and put the `.csv` file in the **`Playlists`** folder (see **[Exporting your Spotify playlist with Exportify](#exporting-your-spotify-playlist-with-exportify)** above). You can put as many playlists in there as you want.

### 2. Download

Double-click **`Download Playlists.bat`**. A black window opens and shows progress. Leave it open until it says **All done**. Big playlists can take a while.

Your music ends up in the **`Music`** folder, with one folder per playlist:

```
📁 Music
   📁 Road Trip
      🎵 ...songs...
      📄 Failed songs.txt
   📁 Gym
      🎵 ...songs...
```

### 3. Run it again whenever you want

Added songs to a playlist? Export it again from Exportify, replace the old CSV in `Playlists`, and run `Download Playlists.bat` again. **Songs you already have are skipped**, so only new or previously failed songs get downloaded.

### Only want certain playlists?

Drag one or more `.csv` files **onto** `Download Playlists.bat` (drop them right on the file icon). It'll do just those, and they don't even have to be in the `Playlists` folder.

---

## What happens behind the scenes

You don't need to know any of this to use it, but here's what each piece does:

- **First run:** if `sockseek.conf` doesn't exist yet, the launcher copies `sockseek.conf.example` to `sockseek.conf`, opens it in Notepad, and asks for your login. It refuses to run while the placeholder login is still in there.
- **`prep.ps1`** reads each song's real length from Exportify's *Duration* column and passes it to Sockseek, so Sockseek can reject files that are clearly a different version, like live versions, remixes, and extended cuts.
- **Sockseek** searches Soulseek for each song, prefers FLAC, and downloads it into that playlist's folder. It also keeps a small `_index.csv` file in each playlist folder to remember what it already got, which is how songs get skipped on later runs.
- **`failed.ps1`** runs after each playlist. If anything didn't download, it writes **`Failed songs.txt`** in that playlist's folder, listing each song and why (for example `not on Soulseek` or `no matching version`).

---

## Settings

### Main settings (in `Download Playlists.bat`)

Right-click `Download Playlists.bat` → **Edit** (on Windows 11: **Show more options** → **Edit**, or **Open with** → **Notepad**). Near the top you'll see:

```bat
rem ===== Settings =====
rem Where your music gets saved (one folder per playlist)
set "MUSIC_DIR=%HERE%Music"

rem Extra options. If lots of songs come back "not found", add --length-tol 10
set "EXTRA=--concurrent-jobs 3"
rem ====================
```

| Setting | What it does | Default |
|---|---|---|
| `MUSIC_DIR` | Where your music is saved. `%HERE%` means "this folder". To save somewhere else, use a full path, like `set "MUSIC_DIR=D:\My Music"`. | The `Music` folder next to the `.bat` file |
| `EXTRA` | Extra Sockseek options. `--concurrent-jobs 3` means up to 3 songs download at once. Lower it to `2` or `1` if your internet keeps dropping during downloads. | `--concurrent-jobs 3` |

**Tip:** if lots of songs come back "not found", change the `EXTRA` line to:

```bat
set "EXTRA=--concurrent-jobs 3 --length-tol 10"
```

That lets a file's length be up to 10 seconds off from Spotify's (the default is 3), which finds more songs but lets slightly more wrong versions through.

### Audio format (in `sockseek.conf`)

```
pref-format = flac
format = flac,mp3,m4a,wav
```

- `pref-format = flac`: FLAC is preferred whenever someone has it.
- `format = flac,mp3,m4a,wav`: if there's no FLAC, these are the only other formats accepted. This keeps out `.opus` and other unusual formats that some music players can't handle. Remove formats from the list if you don't want them (for example `format = flac` for FLAC only).

---

## Retry Missing (Deep Search)

Double-click **`Retry Missing (Deep Search).bat`** after a normal run. It goes through all your playlists again, but:

- Songs you already have are skipped, so **only the songs that failed get retried**.
- It uses Sockseek's **deeper search** (`-d`), which tries extra search variations to find files that are named oddly or that the normal search missed.
- It's gentler on your connection: **one search at a time, 2 downloads at a time, and a 2-minute break between playlists.**

It's slower, but it's a good next step when a playlist has lots of failed songs. You can drag CSV files onto it too, just like the main script.

---

## Troubleshooting

### Internet drops, "error 10055", or "No buffer space available"

During big downloads you might see your internet cut out, or errors like **`10055`**, **`WSAENOBUFS`**, or **`An operation on a socket could not be performed because the system lacked sufficient buffer space`** / **`No buffer space available`**.

**What's going on:** Soulseek opens a lot of connections to other people, and Windows runs out of connection slots. When that happens, *everything* on your PC loses internet for a bit, not just the downloader.

Try these, in order:

1. **Download fewer songs at once.** Change `--concurrent-jobs 3` to `2` or `1` in `Download Playlists.bat` (see [Settings](#settings)).
2. **Use `Retry Missing (Deep Search).bat`**, which already uses gentler settings and takes breaks between playlists.
3. **Give Windows more connection slots** with the included fix:
   1. Right-click **`Fix Windows Connection Limits (run as admin).bat`** → **Run as administrator** → **Yes**.
   2. **Restart your PC.**

#### What the connection fix actually changes

It's normal to be nervous about running something as administrator, so here's exactly what it does. It's two standard Windows networking settings, nothing else, and it's fully undoable:

| | Windows default | After the fix |
|---|---|---|
| **Ports for outgoing connections** (how many connections your PC can have open at once) | About 16,000 (ports 49152–65535) | About 55,000 (ports 10000–65534) |
| **`TcpTimedWaitDelay`** (how long Windows holds onto a connection after it's closed before reusing the slot) | 2 minutes | 30 seconds |

The first change is made with Windows' built-in `netsh` command. The second is one value in the registry (`HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters`). It doesn't install anything, doesn't touch your firewall or antivirus, and doesn't connect to the internet. You can open the `.bat` file in Notepad to read it; it's short.

One small side effect to know about: with the wider range, Windows may occasionally hand out a port in the 10000–49151 range to a normal outgoing connection. If you run a program that needs one specific port in that range (some game servers do) and it ever says the port is in use, just restart your PC or undo the fix.

**To undo it:** right-click **`Undo Connection Fix (run as admin).bat`** → **Run as administrator**, then restart. This puts both settings back to the Windows defaults. (If it says it couldn't find `TcpTimedWaitDelay`, that just means it was already at the default.)

### "Unknown argument" error

Your copy of Sockseek is too old and doesn't have some option this tool uses. Download the newest Windows release from the [Sockseek releases page](https://github.com/fiso64/sockseek/releases) and replace your `sockseek.exe` with it.

### Lots of songs "not found"

- Add `--length-tol 10` to the `EXTRA` line (see [Settings](#settings)).
- Run **`Retry Missing (Deep Search).bat`**.

### Some songs never download

Some songs just aren't on Soulseek, or nobody sharing them is online right now. Check **`Failed songs.txt`** in that playlist's folder. It lists each missing song and why:

| Reason in the file | What it means |
|---|---|
| `not on Soulseek` | The search found nothing at all. |
| `no matching version` | Files were found, but none matched (wrong length, wrong format, etc.). Try `--length-tol 10`. |
| `downloads failed (try again later)` | Files were found, but the people sharing them were offline or too slow. Try again another time. |
| `ran out of retries` | Several download attempts failed. Try again later. |
| `bad search` | The song's title/artist couldn't be turned into a search. |
| `did not finish` | The run was closed before this song was done. Just run it again. |

Run it again on another day, since different people are online at different times.

### "Couldn't read ... - skipping it"

The CSV file couldn't be read. Make sure it's an unedited file straight from Exportify. Also, if the playlist name has a **`%`** sign in it (like `100% Hits.csv`), rename the file without the `%`, since Windows batch files can't handle that character in file names.

### "Can't find sockseek.exe in this folder"

`sockseek.exe` needs to sit right next to `Download Playlists.bat`, not inside a subfolder and not still inside its zip. See [Step 2](#step-2-add-sockseek).

### It keeps getting kicked offline, or your other Soulseek app does

You're probably using the same Soulseek account in another app (like Nicotine+) at the same time. Only one app can be logged in to an account at once. Use a separate account for this tool. See [What you need](#2-a-soulseek-account-use-a-separate-one).

---

## What's in this folder

| File | What it is |
|---|---|
| `Download Playlists.bat` | The main launcher. Double-click this. |
| `Retry Missing (Deep Search).bat` | Retries only failed songs, with a deeper and gentler search. |
| `Fix Windows Connection Limits (run as admin).bat` | Optional fix for connection errors (see [Troubleshooting](#internet-drops-error-10055-or-no-buffer-space-available)). |
| `Undo Connection Fix (run as admin).bat` | Puts Windows' connection settings back to default. |
| `prep.ps1` | Adds each song's length to the playlist so wrong versions get rejected. |
| `failed.ps1` | Writes `Failed songs.txt` for each playlist. |
| `sockseek.conf.example` | Template for your settings file. Copied to `sockseek.conf` on first run. |
| `Playlists/` | Put your Exportify CSV files here. |

Created when you use it (and never uploaded to Git): `sockseek.conf` (your login), `Music/` (your music), and `.work/` (temporary files).

---

## Credits

- **[Sockseek](https://github.com/fiso64/sockseek)** by fiso64 does all the searching and downloading. It's a separate project with its own license (AGPL-3.0) and isn't included here. Go give it a star.
- **[Exportify](https://exportify.app)** ([source](https://github.com/pavelkomarov/exportify)) exports Spotify playlists to CSV.
- **[Soulseek](https://www.slsknet.org/)** is the file sharing network, and its users are the ones sharing the music.

This project is not affiliated with Spotify, Soulseek, Sockseek, or Exportify.

## License

The scripts in this repository are released under the [MIT License](LICENSE). That license covers **only these scripts**. It does not cover Sockseek, Exportify, or Soulseek, which have their own licenses and terms.
