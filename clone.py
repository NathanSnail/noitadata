import shutil

shutil.copytree(
	"/home/nathan/.local/share/Steam/steamapps/compatdata/881100/pfx/drive_c/users/steamuser/AppData/LocalLow/Nolla_Games_Noita/data",
	"data",
	dirs_exist_ok=True,
)
shutil.copytree(
	"/home/nathan/.local/share/Steam/steamapps/common/Noita/data",
	"data",
	dirs_exist_ok=True,
)
shutil.copytree(
	"/home/nathan/.local/share/Steam/steamapps/common/Noita/mods/example/",
	"example_mod",
	dirs_exist_ok=True,
)
shutil.copytree(
	"/home/nathan/.local/share/Steam/steamapps/common/Noita/mods/nightmare/",
	"nightmare_mod",
	dirs_exist_ok=True,
)
shutil.copytree(
	"/home/nathan/.local/share/Steam/steamapps/common/Noita/mods/daily_practice/",
	"daily_practice_mod",
	dirs_exist_ok=True,
)
