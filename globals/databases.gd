extends Node

enum Targets{
	ENEMY,
	ALLY,
	SELF,
}

enum MinionTypes{
	NONE,
	NORMAL,
	FLYING,
	PLANT,
	WATER,
	EARTH,
	FIRE,
	ELECTRIC,
	ROBOT,
	DINO,
	UNDEAD,
	DEMONIC,
	HOLY,
	ICE,
	TITAN,
}

enum MoveTypes{
	NONE,
	PASSIVE,
	NORMAL,
	FLYING,
	PLANT,
	WATER,
	EARTH,
	FIRE,
	ELECTRIC,
	ROBOT,
	DINO,
	UNDEAD,
	DEMONIC,
	HOLY,
	ICE,
	TITAN,
}

enum MoveClasses{
	AGILE_INSPIRATION,
	AGILITY,
	ALLOY_COAT,
	ANCIENT_FORCE,
	ASHEN_REMINDER,
	BATCH_BOLT,
	BLAZE,
	BLINDING_JOLT,
	BLOOD_PRESS,
	BLOOD_RITUAL,
	BLOW_BY,
	BONE_CHILL,
	BONE_CRUNCH,
	BRILLIANCE,
	BURN,
	CHARGE_BLAST,
	CHARGE_PASS,
	CHOSEN_EARTH,
	CLAW,
	CLEANSE_DARKNESS,
	CLEANSING_HEAL,
	CLERIC,
	COG_FALLOUT,
	COLDFRONT,
	CONCENTRATION,
	CRAZED,
	CRAZED_BLAST,
	CRUSADE,
	CRUSH,
	CUTTING_WIND,
	DEADLY_INSPIRATION,
	DEATH_CALL,
	DEATHLY_ENERGY,
	DEMONIC_BARGAIN,
	DEMONIC_FORCE,
	DEMONIC_SACRIFICE,
	DEMONIC_STRIKE,
	DEMORALIZE,
	DEMORALIZING_CHARGE,
	DESPERATION,
	DESTABILIZE,
	DIAMOND_INSPIRATION,
	DIAMOND_SKIN,
	DOMINATE,
	DOWNLOAD,
	DRAIN,
	DREAD_TRANSFER,
	DRY_ICE,
	EARTH_BARRIER,
	EARTH_SHIELD,
	EARTHQUAKE,
	EARTHY_FORTITUDE,
	EFFICIENCY,
	ENERGIZE,
	ENERGIZING_INSPIRATION,
	EVIL_EYE,
	FEROCITY,
	FIRE_BASH,
	FIRE_BLAST,
	FIRE_BOLT,
	FIRE_RAM,
	FIRE_SHOT,
	FLARE_UP,
	FLESH_SACRIFICE,
	FLURRY,
	FOCUS,
	FOCUSED_CHARGE,
	FORCEFUL_HEAL,
	FORTITUDE,
	FRESH_STREAM,
	GRASSBLADE,
	GRIND,
	GROUP_REFLECT,
	HAILSTONE,
	HAUNT,
	HOLY_BURN,
	HOLY_LIGHT,
	HOLY_STRIKE,
	HOPE,
	HULK_INSPIRATION,
	HURRICANE,
	ICE_BARRIER,
	ICE_ENCLOSURE,
	ICE_SHIELD,
	ICY_BLAST,
	INFEST,
	INFLAME,
	INNER_FORCE,
	INTENSE_FLAME,
	INVIGORATE,
	KINDLE,
	KINGS_RUSH,
	LICH_BURN,
	LIFELESS_TOUCH,
	MADNESS,
	MARTYR,
	MENDING_INSPIRATION,
	METAL_MOLD,
	METAL_SHIELD,
	METEOR_STRIKE,
	MIRROR_COATING,
	MIRROR_SKIN,
	MORTIFY,
	MUD_BLAST,
	MYSTIC_ICE,
	NOURISH,
	ORE_DRILL,
	OVERFLOW,
	OVERLOAD,
	PECK,
	PENANCE,
	PERSEVERANCE,
	PHANTOM_STRIKE,
	PIERCING_CHARGE,
	PLATINUM,
	POISON_IVY,
	POISON_TOOTH,
	POUND,
	PREHISTORIC_BITE,
	PRIEST,
	PURGE,
	QUICKNESS,
	RAINFALL,
	RANCID_BITE,
	RAZOR_VINE,
	RECKLESS_DASH,
	RECKLESS_GRASP,
	REFLECT_DAMAGE,
	REFRESHING_WAVE,
	REGROWTH,
	RESURGENCE,
	RIGHTEOUS_FATE,
	RIGHTEOUS_ZEAL,
	ROAR,
	ROCK_BLAST,
	ROCK_SKIN,
	ROCK_SLIDE,
	ROCK_THROW,
	SEAR,
	SERENITY,
	SKILLFUL,
	SKIN_TRAP,
	SLEET,
	SLOW,
	SOAK,
	SOLDER,
	SPARK,
	SPIKE,
	SPORE_BLAST,
	STATIC_PUMMEL,
	STEEL_SPIKE,
	STONE_FALL,
	STONEQUAKE,
	STUN,
	SWIFT_MEND,
	TACKLE,
	TAUNT,
	THUNDERSTORM,
	TIMBER,
	TIRE,
	TITAN_BLAST,
	TITAN_HEAL,
	TITAN_LIGHT,
	TITAN_RECOVERY,
	TITAN_RESTORE,
	TITAN_SLAM,
	TITAN_SLASH,
	TOUCH_FIRE,
	TREE_SLAM,
	TWIN_MISSILE,
	VICIOUS,
	VOLLEY,
	WARMTH,
	WATER_INFUSION,
	WATER_SLAM,
	WATERGIZE,
	WATERJET,
	WILD_LANCE,
	WILD_TACKLE,
	WILDFIRE,
	WIND_LANCE,
}


## 1: The MoveType is Super Effective, -1: The MoveType is not effective
var type_matrix : Dictionary = {
	MoveTypes.NONE : {
	},
	MoveTypes.PASSIVE : {
	},
	MoveTypes.ROBOT : {
	},
	MoveTypes.NORMAL : {
		MinionTypes.HOLY : 1,
		MinionTypes.TITAN : -1,
	},
	MoveTypes.FLYING : {
		MinionTypes.PLANT : 1,
		MinionTypes.WATER : 1,
		MinionTypes.ICE : 1,
		MinionTypes.ELECTRIC : -1,
		MinionTypes.TITAN : -1,
	},
	MoveTypes.WATER : {
		MinionTypes.EARTH : 1,
		MinionTypes.FIRE : 1,
		MinionTypes.ROBOT : 1,
		MinionTypes.DEMONIC : 1,
		MinionTypes.PLANT : -1,
		MinionTypes.WATER : -1,
		MinionTypes.ELECTRIC : -1,
		MinionTypes.DINO : -1, 
		MinionTypes.HOLY : -1,
	},
	MoveTypes.PLANT : {
		MinionTypes.WATER : 1,
		MinionTypes.EARTH : 1,
		MinionTypes.UNDEAD : 1,
		MinionTypes.PLANT : -1,
		MinionTypes.FIRE : -1,
		MinionTypes.ROBOT : -1,
		MinionTypes.DINO : -1,
	},
	MoveTypes.EARTH : {
		MinionTypes.FLYING : 1,
		MinionTypes.FIRE : 1,
		MinionTypes.ELECTRIC :1,
		MinionTypes.DINO : 1,
		MinionTypes.PLANT : -1,
		MinionTypes.WATER : -1,
		MinionTypes.EARTH : -1,
		MinionTypes.UNDEAD : -1,
	},
	MoveTypes.ICE : {
		MinionTypes.PLANT : 1,
		MinionTypes.DINO : 1,
		MinionTypes.TITAN : 1,
		MinionTypes.ICE : -1,
		MinionTypes.FIRE : -1,
	},
	MoveTypes.FIRE : {
		MinionTypes.PLANT : 1,
		MinionTypes.ICE : 1,
		MinionTypes.ROBOT : 1,
		MinionTypes.UNDEAD : 1,
		MinionTypes.WATER : -1,
		MinionTypes.FIRE : -1,
		MinionTypes.DEMONIC : -1,
	},
	MoveTypes.ELECTRIC : {
		MinionTypes.FLYING : 1,
		MinionTypes.WATER : 1,
		MinionTypes.ROBOT : 1,
		MinionTypes.EARTH : -1,
		MinionTypes.ELECTRIC : -1,
		MinionTypes.DINO : -1,
	},
	MoveTypes.DINO : {
		MinionTypes.PLANT : 1,
		MinionTypes.ELECTRIC : 1,
		MinionTypes.ROBOT : 1,
		MinionTypes.EARTH : -1,
		MinionTypes.ICE : -1,
	},
	MoveTypes.UNDEAD : {
		MinionTypes.NORMAL : 1,
		MinionTypes.EARTH : 1,
		MinionTypes.PLANT : -1,
		MinionTypes.FIRE : -1,
		MinionTypes.UNDEAD : -1,
		MinionTypes.DEMONIC : -1,
		MinionTypes.HOLY : -1,
	},
	MoveTypes.DEMONIC : {
		MinionTypes.NORMAL : 1,
		MinionTypes.PLANT : 1,
		MinionTypes.HOLY : 1,
		MinionTypes.FIRE : -1,
		MinionTypes.UNDEAD : -1,
		MinionTypes.DEMONIC : -1,
	},
	MoveTypes.HOLY : {
		MinionTypes.UNDEAD : 1,
		MinionTypes.DEMONIC : 1,
		MinionTypes.TITAN : 1,
		MinionTypes.NORMAL : -1,
		MinionTypes.FLYING : -1,
		MinionTypes.HOLY : -1,
	},
	MoveTypes.TITAN : {
		MinionTypes.ICE : 1,
		MinionTypes.DINO : 1,
		MinionTypes.TITAN : 1,
		MinionTypes.EARTH : -1,
		MinionTypes.HOLY : -1,
	},
}
