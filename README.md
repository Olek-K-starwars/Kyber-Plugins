# Kyber-Plugins
Kyber Plugins, for Armchair Developer's Kyber for Star Wars Battlefront II: https://github.com/ArmchairDevelopers/Kyber
Kyber Plugins can only be used on Kyber Dedicated Servers.


# Galactic Co-Op
Tranforms Galactic Assault into a fully automated Co-Op mode.

* Requirements: [**IOI by Mophead**](https://www.nexusmods.com/starwarsbattlefront22017/mods/3658), I suggest version V7 or newer, to include full bot support. The mod is already included in [**Battlefront Plus**](https://www.nexusmods.com/starwarsbattlefront22017/mods/7592). Battlefront Expanded also includes IOI, but an older version; which doesn't guarantee full bot support on all maps.

* Features:
  + User-friendly cofiguration:
    - **Customisable Automatic Bot Spawning**: bot counts can be customised in the config, with multiple bot balancing methods.
    - **Customisable Automatic Game Starting**: configurable messages, delays. Auto starting can also be disabled completly.
    - **Bot Difficulty Fix**: allows for customisable difficulties on bots, allowing you to tweak the challange to your liking
    - ***Custom Weapon lists (NOT AVILABLE YET)***: the plugin has a ready custom weapon list function, but it's not working with the current release of Kyber. If you want to see this feature added one day, consider upvoting my post on the Kyber Feedback hub: [https://feedback.kyber.gg/p/setweapon-for-autoplayers](https://feedback.kyber.gg/p/setweapon-for-autoplayers)
  + **Custom In-Game Commands**: runnable from the Kyber Launcher on your server:
    - `Galactic.EnemyBotCount` - Allows you to change the max enemy bot count mid-game.
    - `AimNoiseScale` - Allows you to change the AimNoiseScale while the server is running. The plugin already calls `Kyber.AimNoiseScale`, overriding it if you change it manually. That's why you need to use the plugin's command.
    - `PlayerTeam` - Changes the teams that players are in.
    - `HeroSpawnPercentage` - Changes the Hero Spawn Percentage for bots, saves in between matches
    *Note that all changes made using commands don't save between server restarts. If you want your changes to stay in between restarts, you need to modify the config itself.* 
  - **Well Explained Code**: with comments on practically every function, a great way to learn about plugins
  - **Optimisation**: I put some work into optimising the script; the plugin doesn't run any loops, tries it best to call commands only when they're needed

The plugin should work for other gamemodes than Galactic Assault, but it was made with that mode in mind specifically.
