--Made by GhostOne
--v1.1.2

if GhostsHeadBlendLoaded then
	menu.notify("Cancelling", "Head Blend LUA Already Loaded", 3, 255)
	return HANDLER_POP
end
if not menu.is_trusted_mode_enabled() then
	menu.notify("Trusted Mode is not enabled, stat Head Blends will not be an option and hair decorations won't apply.\nEnable Trusted Mode then execute the script again if you want those features.", "Head Blend Profiles", 9, 0xff0000)
end

-- Locals
local HBstats = {
	int = {
		{"MESH_HEAD0", "shape_first"},
		{"MESH_HEAD1", "shape_second"},
		{"MESH_HEAD2", "shape_third"},
		{"MESH_TEX0", "skin_first"},
		{"MESH_TEX1", "skin_second"},
		{"MESH_TEX2", "skin_third"},
		{"HEADBLEND_DAD_BEARD", nil},
		{"HEADBLEND_DAD_BEARD_TEX", nil},
		{"HEADBLEND_DAD_EYEB", nil},
		{"HEADBLEND_DAD_HAIR", nil},
		{"HEADBLEND_DAD_HAIR_TEX", nil},
		{"HEADBLEND_MUM_EYEB", nil},
		{"HEADBLEND_MUM_HAIR", nil},
		{"HEADBLEND_MUM_HAIR_TEX", nil},
		{"HEADBLEND_MUM_MAKEUP", nil},
		{"HEADBLEND_MUM_MAKEUP_TEX", nil},
		{"HAIR_TINT", "HairColor"},
		{"EYEBROW_TINT", "Eyebrows_highlight_color"},
		{"FACIALHAIR_TINT", "FacialHair_highlight_color"},
		{"BLUSHER_TINT", "Blush_color_type"},
		{"LIPSTICK_TINT", nil},
		{"OVERLAY_BODY_1_TINT", nil},
		{"SEC_OVERLAY_BODY_1_TINT", nil},
		{"SEC_HAIR_TINT", "HairHighlightColor"},
		{"SEC_EYEBROW_TINT", "Eyebrows_color"},
		{"SEC_FACIALHAIR_TINT", "FacialHair_color"},
		{"SEC_BLUSHER_TINT", "Blush_color"},
		{"SEC_LIPSTICK_TINT", "Lipstick_color"},
	},
	bool = {
		{"MESH_ISPARENT", nil}
	},
	float = {
		{"MESH_HEADBLEND", "mix_shape"},
		{"MESH_TEXBLEND", "mix_skin"},
		{"MESH_VARBLEND", "mix_third"},
		{"HEADBLEND_DOM", nil},
		{"HEADBLEND_GEOM_BLEND", "mix_shape"},
		{"HEADBLEND_OVER_BLEMISH_PC", "Blemish_opactiy"},
		{"HEADBLEND_OVERLAY_BASE_PC", "SunDamage_opactiy"},
		{"HEADBLEND_OVERLAY_BEARD_PC", "FacialHair_opactiy"},
		{"HEADBLEND_OVERLAY_BLUSHER", "Blush_opactiy"},
		{"HEADBLEND_OVERLAY_DAMAGE_PC", "Complexion_opactiy"},
		{"HEADBLEND_OVERLAY_EYEBRW_PC", "Eyebrows_opactiy"},
		{"HEADBLEND_OVERLAY_MAKEUP_PC", "Makeup_opactiy"},
		{"HEADBLEND_OVERLAY_WETHR_PC", "Age_opactiy"},
		{"HEADBLEND_TEX_BLEND", "mix_skin"},
		{"HEADBLEND_VAR_BLEND", nil},
		{"HEADBLENDOVERLAYCUTS_PC", "Lipstick_opactiy"},
		{"HEADBLENDOVERLAYMOLES_PC", "Freckles_opactiy"},
		{"OVERLAY_BODY_2", "BodyBlemish_opactiy"},
		{"OVERLAY_BODY_3", "BodyBlemish_opactiy"},
		{"OVERLAY_BODY_1", nil},
		{"FEATURE_0", "Nose_width"},
		{"FEATURE_1", "Nose_height"},
		{"FEATURE_2", "Nose_length"},
		{"FEATURE_3", "Nose_bridge_curveness"},
		{"FEATURE_4", "Nose_tip"},
		{"FEATURE_5", "Nose_bridge"},
		{"FEATURE_6", "Brow_height"},
		{"FEATURE_7", "Brow_width"},
		{"FEATURE_8", "Cheekbone_height"},
		{"FEATURE_9", "Cheekbone_width"},
		{"FEATURE_10", "Cheeks_width"},
		{"FEATURE_11", "Eyes"},
		{"FEATURE_12", "Lips"},
		{"FEATURE_13", "Jaw_width"},
		{"FEATURE_14", "Jaw_height"},
		{"FEATURE_15", "Chin_length"},
		{"FEATURE_16", "Chin_position"},
		{"FEATURE_17", "Chin_width"},
		{"FEATURE_18", "Chin_shape"},
		{"FEATURE_19", "Neck_width"},
		{"FEATURE_20", nil}
	}
}

local parent_id_to_name = {
	"Benjamin",
	"Daniel",
	"Joshua",
	"Noah",
	"Andrew",
	"Juan",
	"Alex",
	"Isaac",
	"Evan",
	"Ethan",
	"Vincent",
	"Angel",
	"Diego",
	"Adrian",
	"Gabriel",
	"Michael",
	"Santiago",
	"Kevin",
	"Louis",
	"Samuel",
	"Anthony",
	"Hannah",
	"Audrey",
	"Jasmine",
	"Giselle",
	"Amelia",
	"Isabella",
	"Zoe",
	"Ava",
	"Camila",
	"Violet",
	"Sophia",
	"Evelyn",
	"Nicole",
	"Ashley",
	"Grace",
	"Brianna",
	"Natalie",
	"Olivia",
	"Elizabeth",
	"Charlotte",
	"Emma",
	"Claude",
	"Niko",
	"John",
	"Misty"
}

local featTable = {
	"Parent",
	"savePreset",
	headblends = {}
}
local funcTable = {}

-- credit goes to https://github.com/Stuyk for this list
local hairOverlays = {
	male = {
		[0] = {collection = 'mpbeach_overlays', overlay = 'FM_Hair_Fuzz'},
		[1] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_001'},
		[2] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_002'},
		[3] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_003'},
		[4] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_004'},
		[5] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_005'},
		[6] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_006'},
		[7] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_007'},
		[8] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_008'},
		[9] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_009'},
		[10] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_013'},
		[11] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_002'},
		[12] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_011'},
		[13] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_012'},
		[14] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_014'},
		[15] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_015'},
		[16] = {collection = 'multiplayer_overlays', overlay = 'NGBea_M_Hair_000'},
		[17] = {collection = 'multiplayer_overlays', overlay = 'NGBea_M_Hair_001'},
		[18] = {collection = 'multiplayer_overlays', overlay = 'NGBus_M_Hair_000'},
		[19] = {collection = 'multiplayer_overlays', overlay = 'NGBus_M_Hair_001'},
		[20] = {collection = 'multiplayer_overlays', overlay = 'NGHip_M_Hair_000'},
		[21] = {collection = 'multiplayer_overlays', overlay = 'NGHip_M_Hair_001'},
		[22] = {collection = 'multiplayer_overlays', overlay = 'NGInd_M_Hair_000'},
		[24] = {collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_000'},
		[25] = {collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_001'},
		[26] = {collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_002'},
		[27] = {collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_003'},
		[28] = {collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_004'},
		[29] = {collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_005'},
		[30] = {collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_006'},
		[31] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_000_M'},
		[32] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_001_M'},
		[33] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_002_M'},
		[34] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_003_M'},
		[35] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_004_M'},
		[36] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_005_M'},
		[37] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_001'},
		[38] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_002'},
		[39] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_003'},
		[40] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_004'},
		[41] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_005'},
		[42] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_006'},
		[43] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_007'},
		[44] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_008'},
		[45] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_009'},
		[46] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_013'},
		[47] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_002'},
		[48] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_011'},
		[49] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_012'},
		[50] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_014'},
		[51] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_015'},
		[52] = {collection = 'multiplayer_overlays', overlay = 'NGBea_M_Hair_000'},
		[53] = {collection = 'multiplayer_overlays', overlay = 'NGBea_M_Hair_001'},
		[54] = {collection = 'multiplayer_overlays', overlay = 'NGBus_M_Hair_000'},
		[55] = {collection = 'multiplayer_overlays', overlay = 'NGBus_M_Hair_001'},
		[56] = {collection = 'multiplayer_overlays', overlay = 'NGHip_M_Hair_000'},
		[57] = {collection = 'multiplayer_overlays', overlay = 'NGHip_M_Hair_001'},
		[58] = {collection = 'multiplayer_overlays', overlay = 'NGInd_M_Hair_000'},
		[59] = {collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_000'},
		[60] = {collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_001'},
		[61] = {collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_002'},
		[62] = {collection = 'mplowrider_overlays', overlay = 'LR_M_Hair_003'},
		[63] = {collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_004'},
		[64] = {collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_005'},
		[65] = {collection = 'mplowrider2_overlays', overlay = 'LR_M_Hair_006'},
		[66] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_000_M'},
		[67] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_001_M'},
		[68] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_002_M'},
		[69] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_003_M'},
		[70] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_004_M'},
		[71] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_005_M'},
		[72] = {collection = 'mpgunrunning_overlays', overlay = 'MP_Gunrunning_Hair_M_000_M'},
		[73] = {collection = 'mpgunrunning_overlays', overlay = 'MP_Gunrunning_Hair_M_001_M'}
	},

	female = {
		[0] = {collection = 'mpbeach_overlays', overlay = 'FM_Hair_Fuzz'},
		[1] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_001'},
		[2] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_002'},
		[3] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_003'},
		[4] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_004'},
		[5] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_005'},
		[6] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_006'},
		[7] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_007'},
		[8] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_008'},
		[9] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_009'},
		[10] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_010'},
		[11] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_011'},
		[12] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_012'},
		[13] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_013'},
		[14] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_014'},
		[15] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_015'},
		[16] = {collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_000'},
		[17] = {collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_001'},
		[18] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_007'},
		[19] = {collection = 'multiplayer_overlays', overlay = 'NGBus_F_Hair_000'},
		[20] = {collection = 'multiplayer_overlays', overlay = 'NGBus_F_Hair_001'},
		[21] = {collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_001'},
		[22] = {collection = 'multiplayer_overlays', overlay = 'NGHip_F_Hair_000'},
		[23] = {collection = 'multiplayer_overlays', overlay = 'NGInd_F_Hair_000'},
		[25] = {collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_000'},
		[26] = {collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_001'},
		[27] = {collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_002'},
		[28] = {collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_003'},
		[29] = {collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_003'},
		[30] = {collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_004'},
		[31] = {collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_006'},
		[32] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_000_F'},
		[33] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_001_F'},
		[34] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_002_F'},
		[35] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_003_F'},
		[36] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_003'},
		[37] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_006_F'},
		[38] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_004_F'},
		[39] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_001'},
		[40] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_002'},
		[41] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_003'},
		[42] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_004'},
		[43] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_005'},
		[44] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_006'},
		[45] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_007'},
		[46] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_008'},
		[47] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_009'},
		[48] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_010'},
		[49] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_011'},
		[50] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_012'},
		[51] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_013'},
		[52] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_014'},
		[53] = {collection = 'multiplayer_overlays', overlay = 'NG_M_Hair_015'},
		[54] = {collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_000'},
		[55] = {collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_001'},
		[56] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_007'},
		[57] = {collection = 'multiplayer_overlays', overlay = 'NGBus_F_Hair_000'},
		[58] = {collection = 'multiplayer_overlays', overlay = 'NGBus_F_Hair_001'},
		[59] = {collection = 'multiplayer_overlays', overlay = 'NGBea_F_Hair_001'},
		[60] = {collection = 'multiplayer_overlays', overlay = 'NGHip_F_Hair_000'},
		[61] = {collection = 'multiplayer_overlays', overlay = 'NGInd_F_Hair_000'},
		[62] = {collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_000'},
		[63] = {collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_001'},
		[64] = {collection = 'mplowrider_overlays', overlay = 'LR_F_Hair_002'},
		[65] = {collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_003'},
		[66] = {collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_003'},
		[67] = {collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_004'},
		[68] = {collection = 'mplowrider2_overlays', overlay = 'LR_F_Hair_006'},
		[69] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_000_F'},
		[70] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_001_F'},
		[71] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_002_F'},
		[72] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_003_F'},
		[73] = {collection = 'multiplayer_overlays', overlay = 'NG_F_Hair_003'},
		[74] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_006_F'},
		[75] = {collection = 'mpbiker_overlays', overlay = 'MP_Biker_Hair_004_F'},
		[76] = {collection = 'mpgunrunning_overlays', overlay = 'MP_Gunrunning_Hair_F_000_F'},
		[77] = {collection = 'mpgunrunning_overlays', overlay = 'MP_Gunrunning_Hair_F_001_F'}
	}
}


local Options = {}
Options[0] = {name = "Blemish", on = true}
Options[1] = {name = "FacialHair", on = true}
Options[2] = {name = "Eyebrows", on = true}
Options[3] = {name = "Age", on = true}
Options[4] = {name = "Makeup", on = true}
Options[5] = {name = "Blush", on = true}
Options[6] = {name = "Complexion", on = true}
Options[7] = {name = "SunDamage", on = true}
Options[8] = {name = "Lipstick", on = true}
Options[9] = {name = "Freckles", on = true}
Options[10] = {name = "Head Blend", on = true}
Options[11] = {name = "BodyBlemish", on = true}
Options[13] = {name = "EyeColor", on = true}
Options[14] = {name = "HairHighlightColor", on = true}
Options[15] = {name = "HairColor", on = true}
Options[16] = {name = "Hair", on = true}


local FaceFeatures = {
	"Nose_width",
	"Nose_height",
	"Nose_length",
	"Nose_bridge_curveness",
	"Nose_tip",
	"Nose_bridge", -- twist
	"Brow_height",
	"Brow_width",
	"Cheekbone_height",
	"Cheekbone_width",
	"Cheeks_width",
	"Eyes",
	"Lips",
	"Jaw_width",
	"Jaw_height",
	"Chin_length",
	"Chin_position",
	"Chin_width",
	"Chin_shape",
	"Neck_width"
}
local path = utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Head_Blends\\"
local auto_apply
local auto_apply_thread

-- Functions
	function funcTable.SaveData(pid, defaultName)
		local status, name = input.get("Name of preset", defaultName or "", 128, 0)
		while status == 1 do
			status, name = input.get("Name of preset", defaultName or "", 128, 0)
			system.wait(0)
		end
		if status == 2 then
			return HANDLER_POP
		end
		name = name:gsub("[<>:\"/\\|%?%*]", "")
		local pedID = player.get_player_ped(pid)
		local valTable = {}
		if Options[10].on then
			valTable = ped.get_ped_head_blend_data(pedID)
			for k, v in pairs(FaceFeatures) do
				valTable[v] = ped.get_ped_face_feature(pedID, k - 1)
			end
		end
		if valTable == nil then
			menu.notify("Head Blend isn't initialized, open Head Blend in menu tab to fix.", "Head Blend Profiles\nERROR", 5, 0x0000ff)
			return HANDLER_POP
		end
		if Options[16].on then
			valTable["Hair"] = ped.get_ped_drawable_variation(pedID, 2)
		end
		if Options[15].on then
			valTable["HairColor"] = ped.get_ped_hair_color(pedID)
		end
		if Options[14].on then
			valTable["HairHighlightColor"] = ped.get_ped_hair_highlight_color(pedID)
		end
		if Options[13].on then
			valTable["EyeColor"] = ped.get_ped_eye_color(pedID)
		end
		for k, v in pairs(Options) do
			if v.on and k ~= 10 and k <= 11 then
				valTable[v.name] = ped.get_ped_head_overlay_value(pedID, k)
				valTable[v.name.."_opactiy"] = ped.get_ped_head_overlay_opacity(pedID, k)
				valTable[v.name.."_color_type"] = ped.get_ped_head_overlay_color_type(pedID, k)
				valTable[v.name.."_color"] = ped.get_ped_head_overlay_color(pedID, k)
				valTable[v.name.."_highlight_color"] = ped.get_ped_head_overlay_highlight_color(pedID, k)
			end
		end
		funcTable.save_ini(name, path, valTable)
		funcTable.addpreset(name)
	end

	function funcTable.GetStats()
		local prefix = "MP"..stats.stat_get_int(gameplay.get_hash_key("MPPLY_LAST_MP_CHAR"), 1).."_"
		local statsTable = {int = {}, float = {}}
		for k, v in pairs(HBstats.int) do
			statsTable.int[v[1]] = stats.stat_get_int(gameplay.get_hash_key(prefix..v[1]), 0)
		end
		for k, v in pairs(HBstats.float) do
			statsTable.float[v[1]] = stats.stat_get_float(gameplay.get_hash_key(prefix..v[1]), 0)
		end
		return statsTable
	end

	function funcTable.get_gender(ped)
		local hash = entity.get_entity_model_hash(ped)
		if hash == gameplay.get_hash_key("mp_m_freemode_01") then
			return "male"
		elseif hash == gameplay.get_hash_key("mp_f_freemode_01") then
			return "female"
		end
	end

	function funcTable.checkifpathexists()
		if not utils.dir_exists(path) then
			utils.make_dir(path)
		end
	end
	funcTable.checkifpathexists()

	function funcTable.apply_headblend(HBTable, pedID)
		if entity.get_entity_model_hash(pedID) ~= 0x9C9EFFD8 and entity.get_entity_model_hash(pedID) ~= 0x705E61F2 then
			menu.notify("Player model has to be a freemode model.", "Head Blend Profiles\nERROR", 5, 0x0000ff)
			return
		end
		if HBTable["shape_first"] then
			ped.set_ped_head_blend_data(pedID, HBTable["shape_first"],
				HBTable["shape_second"],
				HBTable["shape_third"],
				HBTable["skin_first"],
				HBTable["skin_second"],
				HBTable["skin_third"],
				HBTable["mix_shape"],
				HBTable["mix_skin"],
				HBTable["mix_third"]
			)
		end

		if HBTable["HairColor"] or HBTable["HairHighlightColor"] then
			HBTable["HairHighlightColor"] = HBTable["HairHighlightColor"] or 0
			HBTable["HairColor"] = HBTable["HairColor"] or 0
			ped.set_ped_hair_colors(pedID, HBTable["HairColor"], HBTable["HairHighlightColor"])
		end

		if HBTable["EyeColor"] then
			ped.set_ped_eye_color(pedID, HBTable["EyeColor"])
		end

		if HBTable["Hair"] then
			ped.set_ped_component_variation(pedID, 2, HBTable["Hair"], 0, 0)
			local gender = funcTable.get_gender(pedID)
			if hairOverlays[gender][HBTable["Hair"]] then
				native.call(0x0E5173C163976E38, pedID) -- CLEAR_PED_DECORATIONS (probably clears tattoos as well)
				native.call(0x5F5D1665E352A839, pedID, gameplay.get_hash_key(hairOverlays[gender][HBTable["Hair"]].collection), gameplay.get_hash_key(hairOverlays[gender][HBTable["Hair"]].overlay)) -- APPLY_PED_DECORATION_FROM_HASHES
			end
		end

		for k, v in pairs(Options) do
			if not k == 10 or k <= 11 then
				if not HBTable[v.name] then
					HBTable[v.name] = -1
					HBTable[v.name.."_opactiy"] = -1
					HBTable[v.name.."_color_type"] = -1
					HBTable[v.name.."_color"] = -1
					HBTable[v.name.."_highlight_color"] = -1
				end
				ped.set_ped_head_overlay(pedID, k, HBTable[v.name], HBTable[v.name.."_opactiy"])
				ped.set_ped_head_overlay_color(pedID, k, HBTable[v.name.."_color_type"], HBTable[v.name.."_color"], HBTable[v.name.."_highlight_color"])
			end
		end

		for k, v in pairs(FaceFeatures) do
			if HBTable[v] then
				ped.set_ped_face_feature(pedID, k - 1, HBTable[v])
			end
		end
	end

	function funcTable.auto_apply()
		while true do
			if auto_apply then
				funcTable.apply_headblend(auto_apply, player.get_player_ped(player.player_id()))
			else
				break
			end
			system.wait(10000)
		end
	end

	function funcTable.addpreset(HBName)
		if featTable.headblends[HBName] then
			return
		end

		local statPreset

		if menu.is_trusted_mode_enabled() then
			statPreset = menu.add_feature(HBName, "action_value_str", featTable["statParent"], function(f)
				local HBTable = funcTable.read_ini(HBName, path)
				if f.value == 0 then
					local prefix = "MP"..stats.stat_get_int(gameplay.get_hash_key("MPPLY_LAST_MP_CHAR"), 1).."_"
					for i = 1, 20 do
						for index, HB in pairs(HBstats["int"]) do
							if HBTable[HB[2]] then
								stats.stat_set_int(gameplay.get_hash_key(prefix..HB[1]), HBTable[HB[2]], true)
							end
						end
						-- for index, HB in pairs(HBstats["bool"]) do
						-- 	stats.stat_set_bool(gameplay.get_hash_key(prefix..HB[1]), HBTable[HB[2]], true)
						-- end
						for index, HB in pairs(HBstats["float"]) do
							if HBTable[HB[2]] then
								stats.stat_set_float(gameplay.get_hash_key(prefix..HB[1]), HBTable[HB[2]], true)
							end
						end
						system.wait(0)
					end
				elseif f.value == 1 then
					if HBTable["shape_first"] and HBTable["shape_second"] then
						menu.notify(table.concat({
							"Mom: "..parent_id_to_name[HBTable["shape_first"] + 1].." - "..HBTable["shape_first"],
							"Dad: "..parent_id_to_name[HBTable["shape_second"] + 1].." - "..HBTable["shape_second"]
						}, "\n"), "Head Blend Profiles")
					else
						menu.notify("There is no Head Blend data saved in this file.", "Head Blend Profiles")
					end
				end
			end)
			statPreset:set_str_data({"Apply", "Notify Parent Names"})
		end

		featTable.headblends[HBName] = menu.add_feature(HBName, "action_value_str", featTable["Parent"], function(f)
			if f.value == 0 then
				funcTable.apply_headblend(funcTable.read_ini(HBName, path), player.get_player_ped(player.player_id()))
			end

			if f.value == 1 then
				--[[io.remove(path..HBName..".ini")
				menu.delete_feature(f.id)
				if statPreset then
					menu.delete_feature(statPreset.id)
				end--]]
				if f.name:match(" %[Auto Apply%]") then
					f.name = HBName
					auto_apply = nil
					auto_apply_thread = nil
				else
					for k, v in pairs(featTable.headblends) do
						if v.name:match(" %[Auto Apply%]") then
							featTable.headblends[k].name = k
						end
					end
					f.name = HBName.." [Auto Apply]"
					auto_apply = funcTable.read_ini(HBName, path)
					if not auto_apply_thread then
						auto_apply_thread = menu.create_thread(funcTable.auto_apply, nil)
					end
				end
			end
		end)
		featTable.headblends[HBName]:set_str_data({"Apply", "Auto Apply"})
	end

	function funcTable.write_table(tableName, tableTW, file)
		file:write("["..tableName.."]\n")
		for k, v in pairs(tableTW) do
			if type(v) == "table" then
				funcTable.write_table(k, v, file)
			else
				file:write(k..":"..tostring(v).."\n")
			end
		end
		file:write("[%end%]\n")
	end

	function funcTable.save_ini(name, filePath, tableTW, notif)
		local file = io.open(filePath..name..".ini", "w+")

		for k, v in pairs(tableTW) do
			if type(v) ~= "table" and type(v) ~= "function" then
				file:write(k..":"..tostring(v).."\n")
			end
		end

		for k, v in pairs(tableTW) do
			if type(v) == "table" then
				funcTable.write_table(k, v, file)
			end
		end

		if notif then
			menu.notify("Saved Successfully", "Head Blend Profiles", 3, 0x00ff00)
		end

		file:flush()
		file:close()
	end

	function funcTable.read_table(tableRT, file)
		repeat
			local line = file:read("*l")
			if line:match("%[%%end%%%]") then
				return
			elseif line:match("%[.*%]") then
				if not tableRT[tonumber(line:match("%[(.*)%]")) or line:match("%[(.*)%]")] then
					tableRT[tonumber(line:match("%[(.*)%]")) or line:match("%[(.*)%]")] = {}
				end
				funcTable.read_table(tableRT[tonumber(line:match("%[(.*)%]")) or line:match("%[(.*)%]")], file)
			elseif line:match(":(.*)") == "true" or line:match(":(.*)") == "false" then
				tableRT[tonumber(line:match("(.*):")) or line:match("(.*):")] = line:match(":(.*)") == "true"
			else
				tableRT[tonumber(line:match("(.*):")) or line:match("(.*):")] = tonumber(line:match(":(.*)")) or line:match(":(.*)")
			end
		until not line
	end


	function funcTable.read_ini(name, filePath, tableRT)
		tableRT = tableRT or {}
		if not name:match("%.ini") then
			name = name..".ini"
		end
		local file = io.open(filePath..name, "r")
		if not file then return end

		repeat
			local line = file:read("*l")
			if not line then
				break
			end
			if line:match("(.*):") then
				if line:match(":(.*)") == "true" or line:match(":(.*)") == "false" then
					tableRT[tonumber(line:match("(.*):")) or line:match("(.*):")] = line:match(":(.*)") == "true"
				else
					tableRT[tonumber(line:match("(.*):")) or line:match("(.*):")] = tonumber(line:match(":(.*)")) or line:match(":(.*)")
				end
			elseif line:match("%[.*%]") then
				if not tableRT[tonumber(line:match("%[(.*)%]")) or line:match("%[(.*)%]")] then
					tableRT[tonumber(line:match("%[(.*)%]")) or line:match("%[(.*)%]")] = {}
				end
				funcTable.read_table(tableRT[tonumber(line:match("%[(.*)%]")) or line:match("%[(.*)%]")], file)
			end
		until not line

		file:close()

		return tableRT
	end

	local oldsetting = funcTable.read_ini("Options", path)
	if oldsetting then 
		if type(oldsetting[1]) ~= "table" then
			funcTable.save_ini("Options", path, Options)
			menu.notify("Old settings overwritten.", "Head Blend Profiles", 3)
		end
	end
	oldsetting = nil

	funcTable.read_ini("Options", path, Options)

-- Parents
	featTable["Parent"] = menu.add_feature("Head Blend Profiles", "parent", 0).id
	featTable["Options"] = menu.add_feature("Options", "parent", featTable["Parent"]).id
	if menu.is_trusted_mode_enabled() then
		featTable["statParent"] = menu.add_feature("Set Stats", "parent", featTable["Parent"]).id
	end


-- Features
	menu.add_feature("Write HB Stats to file", "action", featTable.Options, function()
		local statTable = funcTable.GetStats()
		funcTable.save_ini("stats", path, statTable)
	end)

	menu.add_feature("Save Options", "action", featTable["Options"], function()
		funcTable.save_ini("Options", path, Options, true)
	end)


	featTable["savePreset"] = menu.add_feature("Save current Head Blend", "action", featTable["Parent"], function()
		if player.get_player_model(player.player_id()) == 0x9C9EFFD8 or player.get_player_model(player.player_id()) == 0x705E61F2 then
			funcTable.SaveData(player.player_id())
		else
			menu.notify("Character isn't a freemode model.")
		end
	end)

	menu.add_player_feature("Yoink their Head Blend", "action", 0, function(f, pid)
		if player.get_player_model(player.player_id()) == 0x9C9EFFD8 or player.get_player_model(player.player_id()) == 0x705E61F2 then
			funcTable.SaveData(pid, player.get_player_name(pid))
		else
			menu.notify("Character isn't a freemode model.")
		end
	end)

	for i, e in pairs(utils.get_all_files_in_directory(path, "ini")) do
		if e ~= "Options.ini" then
			funcTable.addpreset(e:match("^(.*)%.ini"))
		end
	end

	for k, v in pairs(Options) do
		menu.add_feature("Save "..v.name, "toggle", featTable["Options"], function(f) 
			Options[k].on = f.on
		end).on = Options[k].on
	end

GhostsHeadBlendLoaded = true