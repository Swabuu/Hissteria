-- Data/SpecSpells.lua
-- Comprehensive WotLK 3.3.5a Spell-to-Spec Database
-- Inspired by Details!/Skada detection methods

local ADDON_NAME, Hissteria = ...

-- [SpellID] = { spec = "SpecName", isHealer = boolean }
Hissteria.SpecSpells = {

    -- ================================================================
    -- DEATH KNIGHT
    -- ================================================================
    
    -- Blood
    [55050] = { spec = "Blood", isHealer = false },    -- Heart Strike
    [49028] = { spec = "Blood", isHealer = false },    -- Dancing Rune Weapon
    [55233] = { spec = "Blood", isHealer = false },    -- Vampiric Blood
    [49016] = { spec = "Blood", isHealer = false },    -- Hysteria
    [48982] = { spec = "Blood", isHealer = false },    -- Rune Tap
    [50449] = { spec = "Blood", isHealer = false },    -- Bloody Vengeance
    [49005] = { spec = "Blood", isHealer = false },    -- Mark of Blood
    [55262] = { spec = "Blood", isHealer = false },    -- Heart Strike (Rank 6)
    
    -- Frost
    [49143] = { spec = "Frost", isHealer = false },    -- Frost Strike
    [51271] = { spec = "Frost", isHealer = false },    -- Unbreakable Armor
    [49184] = { spec = "Frost", isHealer = false },    -- Howling Blast
    [49203] = { spec = "Frost", isHealer = false },    -- Hungering Cold
    [50401] = { spec = "Frost", isHealer = false },    -- Razor Frost
    [55268] = { spec = "Frost", isHealer = false },    -- Frost Strike (Rank 6)
    [51411] = { spec = "Frost", isHealer = false },    -- Howling Blast (Rank 4)
    [49796] = { spec = "Frost", isHealer = false },    -- Deathchill
    
    -- Unholy
    [55090] = { spec = "Unholy", isHealer = false },   -- Scourge Strike
    [49206] = { spec = "Unholy", isHealer = false },   -- Summon Gargoyle
    [51052] = { spec = "Unholy", isHealer = false },   -- Anti-Magic Zone
    [49222] = { spec = "Unholy", isHealer = false },   -- Bone Shield
    [55271] = { spec = "Unholy", isHealer = false },   -- Scourge Strike (Rank 4)
    [63560] = { spec = "Unholy", isHealer = false },   -- Ghoul Frenzy
    [49158] = { spec = "Unholy", isHealer = false },   -- Corpse Explosion
    [51460] = { spec = "Unholy", isHealer = false },   -- Necrosis
    
    -- ================================================================
    -- DRUID
    -- ================================================================
    
    -- Balance
    [48505] = { spec = "Balance", isHealer = false },  -- Starfall
    [53201] = { spec = "Balance", isHealer = false },  -- Starfall (Rank 4)
    [48463] = { spec = "Balance", isHealer = false },  -- Moonfire (Rank 14)
    [61384] = { spec = "Balance", isHealer = false },  -- Typhoon
    [53227] = { spec = "Balance", isHealer = false },  -- Typhoon (Rank 5)
    [24858] = { spec = "Balance", isHealer = false },  -- Moonkin Form
    [48468] = { spec = "Balance", isHealer = false },  -- Insect Swarm
    [50516] = { spec = "Balance", isHealer = false },  -- Typhoon (Rank 1)
    [33831] = { spec = "Balance", isHealer = false },  -- Force of Nature
    [48391] = { spec = "Balance", isHealer = false },  -- Owlkin Frenzy
    
    -- Feral
    [50334] = { spec = "Feral", isHealer = false },    -- Berserk
    [33876] = { spec = "Feral", isHealer = false },    -- Mangle (Cat)
    [48566] = { spec = "Feral", isHealer = false },    -- Mangle (Cat Rank 5)
    [33878] = { spec = "Feral", isHealer = false },    -- Mangle (Bear)
    [48564] = { spec = "Feral", isHealer = false },    -- Mangle (Bear Rank 5)
    [52610] = { spec = "Feral", isHealer = false },    -- Savage Roar
    [62078] = { spec = "Feral", isHealer = false },    -- Swipe (Cat)
    [49376] = { spec = "Feral", isHealer = false },    -- Feral Charge - Cat
    [16979] = { spec = "Feral", isHealer = false },    -- Feral Charge - Bear
    [61336] = { spec = "Feral", isHealer = false },    -- Survival Instincts
    
    -- Restoration
    [48438] = { spec = "Restoration", isHealer = true },  -- Wild Growth
    [53251] = { spec = "Restoration", isHealer = true },  -- Wild Growth (Rank 1)
    [18562] = { spec = "Restoration", isHealer = true },  -- Swiftmend
    [33891] = { spec = "Restoration", isHealer = true },  -- Tree of Life
    [17116] = { spec = "Restoration", isHealer = true },  -- Nature's Swiftness
    [48451] = { spec = "Restoration", isHealer = true },  -- Lifebloom
    [33763] = { spec = "Restoration", isHealer = true },  -- Lifebloom (Rank 1)
    [50464] = { spec = "Restoration", isHealer = true },  -- Nourish
    [48441] = { spec = "Restoration", isHealer = true },  -- Rejuvenation (Rank 15)
    
    -- ================================================================
    -- HUNTER
    -- ================================================================
    
    -- Beast Mastery
    [19574] = { spec = "Beast Mastery", isHealer = false },  -- Bestial Wrath
    [19577] = { spec = "Beast Mastery", isHealer = false },  -- Intimidation
    [34692] = { spec = "Beast Mastery", isHealer = false },  -- The Beast Within
    [82726] = { spec = "Beast Mastery", isHealer = false },  -- Fervor
    [53257] = { spec = "Beast Mastery", isHealer = false },  -- Cobra Strikes
    
    -- Marksmanship
    [53209] = { spec = "Marksmanship", isHealer = false },   -- Chimera Shot
    [19434] = { spec = "Marksmanship", isHealer = false },   -- Aimed Shot
    [49050] = { spec = "Marksmanship", isHealer = false },   -- Aimed Shot (Rank 9)
    [34490] = { spec = "Marksmanship", isHealer = false },   -- Silencing Shot
    [23989] = { spec = "Marksmanship", isHealer = false },   -- Readiness
    [53353] = { spec = "Marksmanship", isHealer = false },   -- Chimera Shot (Rank 1)
    [19506] = { spec = "Marksmanship", isHealer = false },   -- Trueshot Aura
    
    -- Survival
    [53301] = { spec = "Survival", isHealer = false },   -- Explosive Shot
    [60053] = { spec = "Survival", isHealer = false },   -- Explosive Shot (Rank 4)
    [3674]  = { spec = "Survival", isHealer = false },   -- Black Arrow
    [63672] = { spec = "Survival", isHealer = false },   -- Black Arrow (Rank 1)
    [19386] = { spec = "Survival", isHealer = false },   -- Wyvern Sting
    [49012] = { spec = "Survival", isHealer = false },   -- Wyvern Sting (Rank 6)
    [19306] = { spec = "Survival", isHealer = false },   -- Counterattack
    [48999] = { spec = "Survival", isHealer = false },   -- Counterattack (Rank 6)
    
    -- ================================================================
    -- MAGE
    -- ================================================================
    
    -- Arcane
    [44425] = { spec = "Arcane", isHealer = false },   -- Arcane Barrage
    [44781] = { spec = "Arcane", isHealer = false },   -- Arcane Barrage (Rank 3)
    [12042] = { spec = "Arcane", isHealer = false },   -- Arcane Power
    [31589] = { spec = "Arcane", isHealer = false },   -- Slow
    [55342] = { spec = "Arcane", isHealer = false },   -- Mirror Image
    [12043] = { spec = "Arcane", isHealer = false },   -- Presence of Mind
    [44572] = { spec = "Arcane", isHealer = false },   -- Deep Freeze (shared with Frost)
    
    -- Fire
    [44457] = { spec = "Fire", isHealer = false },     -- Living Bomb
    [55360] = { spec = "Fire", isHealer = false },     -- Living Bomb (Rank 3)
    [11129] = { spec = "Fire", isHealer = false },     -- Combustion
    [31661] = { spec = "Fire", isHealer = false },     -- Dragon's Breath
    [42950] = { spec = "Fire", isHealer = false },     -- Dragon's Breath (Rank 6)
    [11113] = { spec = "Fire", isHealer = false },     -- Blast Wave
    [42945] = { spec = "Fire", isHealer = false },     -- Blast Wave (Rank 9)
    [55362] = { spec = "Fire", isHealer = false },     -- Living Bomb (explosion)
    
    -- Frost
    [44572] = { spec = "Frost", isHealer = false },    -- Deep Freeze
    [11958] = { spec = "Frost", isHealer = false },    -- Cold Snap
    [31687] = { spec = "Frost", isHealer = false },    -- Summon Water Elemental
    [44545] = { spec = "Frost", isHealer = false },    -- Fingers of Frost
    [12472] = { spec = "Frost", isHealer = false },    -- Icy Veins
    [55080] = { spec = "Frost", isHealer = false },    -- Shattered Barrier
    
    -- ================================================================
    -- PALADIN
    -- ================================================================
    
    -- Holy
    [20473] = { spec = "Holy", isHealer = true },      -- Holy Shock
    [48825] = { spec = "Holy", isHealer = true },      -- Holy Shock (Rank 7)
    [53563] = { spec = "Holy", isHealer = true },      -- Beacon of Light
    [31842] = { spec = "Holy", isHealer = true },      -- Divine Illumination
    [20216] = { spec = "Holy", isHealer = true },      -- Divine Favor
    [31821] = { spec = "Holy", isHealer = true },      -- Aura Mastery
    [54428] = { spec = "Holy", isHealer = true },      -- Divine Plea
    [53652] = { spec = "Holy", isHealer = true },      -- Beacon of Light heal
    
    -- Protection
    [31935] = { spec = "Protection", isHealer = false },  -- Avenger's Shield
    [48827] = { spec = "Protection", isHealer = false },  -- Avenger's Shield (Rank 4)
    [53595] = { spec = "Protection", isHealer = false },  -- Hammer of the Righteous
    [20925] = { spec = "Protection", isHealer = false },  -- Holy Shield
    [48952] = { spec = "Protection", isHealer = false },  -- Holy Shield (Rank 6)
    [64205] = { spec = "Protection", isHealer = false },  -- Divine Sacrifice
    [31850] = { spec = "Protection", isHealer = false },  -- Ardent Defender
    
    -- Retribution
    [35395] = { spec = "Retribution", isHealer = false }, -- Crusader Strike
    [53385] = { spec = "Retribution", isHealer = false }, -- Divine Storm
    [20066] = { spec = "Retribution", isHealer = false }, -- Repentance
    [59578] = { spec = "Retribution", isHealer = false }, -- Art of War
    [53380] = { spec = "Retribution", isHealer = false }, -- Righteous Vengeance
    [20271] = { spec = "Retribution", isHealer = false }, -- Judgement of Light
    
    -- ================================================================
    -- PRIEST
    -- ================================================================
    
    -- Discipline
    [47540] = { spec = "Discipline", isHealer = true },  -- Penance
    [53007] = { spec = "Discipline", isHealer = true },  -- Penance (Rank 4)
    [33206] = { spec = "Discipline", isHealer = true },  -- Pain Suppression
    [10060] = { spec = "Discipline", isHealer = true },  -- Power Infusion
    [47509] = { spec = "Discipline", isHealer = true },  -- Divine Aegis
    [47753] = { spec = "Discipline", isHealer = true },  -- Divine Aegis (triggered)
    [45234] = { spec = "Discipline", isHealer = true },  -- Focused Will
    [47930] = { spec = "Discipline", isHealer = true },  -- Grace
    [52985] = { spec = "Discipline", isHealer = true },  -- Penance (heal)
    
    -- Holy
    [34861] = { spec = "Holy", isHealer = true },      -- Circle of Healing
    [48089] = { spec = "Holy", isHealer = true },      -- Circle of Healing (Rank 7)
    [47788] = { spec = "Holy", isHealer = true },      -- Guardian Spirit
    [33076] = { spec = "Holy", isHealer = true },      -- Prayer of Mending
    [48113] = { spec = "Holy", isHealer = true },      -- Prayer of Mending (Rank 7)
    [64843] = { spec = "Holy", isHealer = true },      -- Divine Hymn
    [64844] = { spec = "Holy", isHealer = true },      -- Divine Hymn (HoT)
    [724]   = { spec = "Holy", isHealer = true },      -- Lightwell
    [48087] = { spec = "Holy", isHealer = true },      -- Lightwell (Rank 6)
    
    -- Shadow
    [15473] = { spec = "Shadow", isHealer = false },   -- Shadowform
    [48160] = { spec = "Shadow", isHealer = false },   -- Vampiric Touch
    [34914] = { spec = "Shadow", isHealer = false },   -- Vampiric Touch (Rank 1)
    [47585] = { spec = "Shadow", isHealer = false },   -- Dispersion
    [64044] = { spec = "Shadow", isHealer = false },   -- Psychic Horror
    [15407] = { spec = "Shadow", isHealer = false },   -- Mind Flay
    [48156] = { spec = "Shadow", isHealer = false },   -- Mind Flay (Rank 9)
    [15487] = { spec = "Shadow", isHealer = false },   -- Silence
    [34433] = { spec = "Shadow", isHealer = false },   -- Shadowfiend
    
    -- ================================================================
    -- ROGUE
    -- ================================================================
    
    -- Assassination
    [1329]  = { spec = "Assassination", isHealer = false },  -- Mutilate
    [48666] = { spec = "Assassination", isHealer = false },  -- Mutilate (Rank 5)
    [14177] = { spec = "Assassination", isHealer = false },  -- Cold Blood
    [51662] = { spec = "Assassination", isHealer = false },  -- Hunger For Blood
    [32645] = { spec = "Assassination", isHealer = false },  -- Envenom
    [57993] = { spec = "Assassination", isHealer = false },  -- Envenom (Rank 4)
    [14983] = { spec = "Assassination", isHealer = false },  -- Vigor
    [58427] = { spec = "Assassination", isHealer = false },  -- Overkill
    
    -- Combat
    [13877] = { spec = "Combat", isHealer = false },   -- Blade Flurry
    [51690] = { spec = "Combat", isHealer = false },   -- Killing Spree
    [13750] = { spec = "Combat", isHealer = false },   -- Adrenaline Rush
    [51672] = { spec = "Combat", isHealer = false },   -- Savage Combat
    [5171]  = { spec = "Combat", isHealer = false },   -- Slice and Dice
    [35551] = { spec = "Combat", isHealer = false },   -- Combat Potency
    
    -- Subtlety
    [36554] = { spec = "Subtlety", isHealer = false }, -- Shadowstep
    [51713] = { spec = "Subtlety", isHealer = false }, -- Shadow Dance
    [14185] = { spec = "Subtlety", isHealer = false }, -- Preparation
    [16511] = { spec = "Subtlety", isHealer = false }, -- Hemorrhage
    [48660] = { spec = "Subtlety", isHealer = false }, -- Hemorrhage (Rank 4)
    [31223] = { spec = "Subtlety", isHealer = false }, -- Master of Subtlety
    [14278] = { spec = "Subtlety", isHealer = false }, -- Ghostly Strike
    
    -- ================================================================
    -- SHAMAN
    -- ================================================================
    
    -- Elemental
    [51490] = { spec = "Elemental", isHealer = false },  -- Thunderstorm
    [59159] = { spec = "Elemental", isHealer = false },  -- Thunderstorm (Rank 4)
    [60043] = { spec = "Elemental", isHealer = false },  -- Lava Burst
    [60188] = { spec = "Elemental", isHealer = false },  -- Lava Burst (Rank 2)
    [16166] = { spec = "Elemental", isHealer = false },  -- Elemental Mastery
    [16164] = { spec = "Elemental", isHealer = false },  -- Elemental Focus
    [30706] = { spec = "Elemental", isHealer = false },  -- Totem of Wrath
    
    -- Enhancement
    [17364] = { spec = "Enhancement", isHealer = false }, -- Stormstrike
    [60103] = { spec = "Enhancement", isHealer = false }, -- Lava Lash
    [30823] = { spec = "Enhancement", isHealer = false }, -- Shamanistic Rage
    [51533] = { spec = "Enhancement", isHealer = false }, -- Feral Spirit
    [51530] = { spec = "Enhancement", isHealer = false }, -- Maelstrom Weapon
    [63685] = { spec = "Enhancement", isHealer = false }, -- Frozen Power
    [58804] = { spec = "Enhancement", isHealer = false }, -- Spirit Walk
    
    -- Restoration
    [61295] = { spec = "Restoration", isHealer = true },  -- Riptide
    [61301] = { spec = "Restoration", isHealer = true },  -- Riptide (Rank 4)
    [974]   = { spec = "Restoration", isHealer = true },  -- Earth Shield
    [49284] = { spec = "Restoration", isHealer = true },  -- Earth Shield (Rank 5)
    [16190] = { spec = "Restoration", isHealer = true },  -- Mana Tide Totem
    [16188] = { spec = "Restoration", isHealer = true },  -- Nature's Swiftness
    [51886] = { spec = "Restoration", isHealer = true },  -- Cleanse Spirit
    [55198] = { spec = "Restoration", isHealer = true },  -- Tidal Force
    
    -- ================================================================
    -- WARLOCK
    -- ================================================================
    
    -- Affliction
    [48181] = { spec = "Affliction", isHealer = false },  -- Haunt
    [59164] = { spec = "Affliction", isHealer = false },  -- Haunt (Rank 4)
    [30108] = { spec = "Affliction", isHealer = false },  -- Unstable Affliction
    [47843] = { spec = "Affliction", isHealer = false },  -- Unstable Affliction (Rank 5)
    [18223] = { spec = "Affliction", isHealer = false },  -- Curse of Exhaustion
    [30405] = { spec = "Affliction", isHealer = false },  -- Unstable Affliction (dispel)
    [63106] = { spec = "Affliction", isHealer = false },  -- Siphon Life
    
    -- Demonology
    [59672] = { spec = "Demonology", isHealer = false },  -- Metamorphosis
    [47193] = { spec = "Demonology", isHealer = false },  -- Demonic Empowerment
    [30146] = { spec = "Demonology", isHealer = false },  -- Summon Felguard
    [54785] = { spec = "Demonology", isHealer = false },  -- Demon Form
    [47241] = { spec = "Demonology", isHealer = false },  -- Metamorphosis (immolation)
    [50589] = { spec = "Demonology", isHealer = false },  -- Immolation Aura
    
    -- Destruction
    [17962] = { spec = "Destruction", isHealer = false }, -- Conflagrate
    [50796] = { spec = "Destruction", isHealer = false }, -- Chaos Bolt
    [59172] = { spec = "Destruction", isHealer = false }, -- Chaos Bolt (Rank 4)
    [30283] = { spec = "Destruction", isHealer = false }, -- Shadowfury
    [47847] = { spec = "Destruction", isHealer = false }, -- Shadowfury (Rank 4)
    [17877] = { spec = "Destruction", isHealer = false }, -- Shadowburn
    [47827] = { spec = "Destruction", isHealer = false }, -- Shadowburn (Rank 10)
    
    -- ================================================================
    -- WARRIOR
    -- ================================================================
    
    -- Arms
    [46924] = { spec = "Arms", isHealer = false },     -- Bladestorm
    [12294] = { spec = "Arms", isHealer = false },     -- Mortal Strike
    [47486] = { spec = "Arms", isHealer = false },     -- Mortal Strike (Rank 8)
    [29834] = { spec = "Arms", isHealer = false },     -- Second Wind
    [46867] = { spec = "Arms", isHealer = false },     -- Wrecking Crew
    [56636] = { spec = "Arms", isHealer = false },     -- Taste for Blood
    [64976] = { spec = "Arms", isHealer = false },     -- Juggernaut
    
    -- Fury
    [23881] = { spec = "Fury", isHealer = false },     -- Bloodthirst
    [23885] = { spec = "Fury", isHealer = false },     -- Bloodthirst (heal)
    [12292] = { spec = "Fury", isHealer = false },     -- Death Wish
    [46916] = { spec = "Fury", isHealer = false },     -- Slam! (Bloodsurge)
    [29801] = { spec = "Fury", isHealer = false },     -- Rampage
    [60970] = { spec = "Fury", isHealer = false },     -- Heroic Fury
    [12323] = { spec = "Fury", isHealer = false },     -- Piercing Howl
    
    -- Protection
    [46968] = { spec = "Protection", isHealer = false }, -- Shockwave
    [12975] = { spec = "Protection", isHealer = false }, -- Last Stand
    [50720] = { spec = "Protection", isHealer = false }, -- Vigilance
    [47498] = { spec = "Protection", isHealer = false }, -- Devastate (Rank 5)
    [20243] = { spec = "Protection", isHealer = false }, -- Devastate
    [46953] = { spec = "Protection", isHealer = false }, -- Sword and Board
    [12809] = { spec = "Protection", isHealer = false }, -- Concussion Blow
}
