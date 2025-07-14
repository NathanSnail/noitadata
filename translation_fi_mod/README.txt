This is an example translation mod for Noita, a work in progress Finnish translation.

- Following lines in mod.xml configure the translation, and make it show up under Languages in the Options menu:
	is_translation="1"
	translation_xml_path="mods/translation_fi/translation.xml"
	translation_csv_path="mods/translation_fi/translation.csv"

- The language key in translation.xml should be set to a unique value, not matching any of the column names in data/translations/common.csv, for example:
	key="ru-2"

- You probably want to configure the following lines in your translation.xml. These affect the rendering of spell (action) and wand info boxes.
	ui_action_info_offset2="X"
	ui_wand_info_offset1="X"
	ui_wand_info_offset2="X"

- See jp.xml, ko.xml, zh-cn.xml in data/translations for examples of translations using CJK fonts.

- In the future new and updated text strings will be added to the bottom of data/translations/common.csv, and marked with the date when they were added/updated.

- The standard mod functionality is not available in translation mods.