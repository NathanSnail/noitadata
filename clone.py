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
<<<<<<< HEAD
shutil.rmtree("nightmare_mod")
=======
>>>>>>> parent of 985eb5e (fix bug with deleted content and new update)
shutil.copytree(
	"/home/nathan/.local/share/Steam/steamapps/common/Noita/mods/nightmare/",
	"nightmare_mod",
	dirs_exist_ok=True,
)
<<<<<<< HEAD
shutil.rmtree("daily_practice_mod")
=======
>>>>>>> parent of 985eb5e (fix bug with deleted content and new update)
shutil.copytree(
	"/home/nathan/.local/share/Steam/steamapps/common/Noita/mods/daily_practice/",
	"daily_practice_mod",
	dirs_exist_ok=True,
)
