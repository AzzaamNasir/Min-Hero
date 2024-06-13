@tool
@export_dir var search_path : String

@export var rename_anim_sprites : bool:
	set(value):
		_rename_anim_sprites()

func _rename_anim_sprites():
	var access = DirAccess.open(search_path)
	var items = access.get_files()
	for item in items:
		if not item.ends_with(".import") and item.find("_") != -1:
			var tex : Texture2D = load(search_path + "/" + item)
			var tex_img = tex.get_image()
			var idx = item.length() - item.rfind("_") - 1
			var filename = item.right(idx)
			var filepath = search_path + "/" + filename
			tex_img.save_png(filepath)
