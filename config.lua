Config = {}



Config.requiredCops = {
    shop = 0,
    bank = 4,
}
Config.cooldowns ={
    globalCd = 3600, -- GLOBALNY CD!!!! (1 - 1 sekunda)
    shopCd = 3600, -- CD na sklepy
    bankCd = 3600, -- CD na banki
}

--[[
    GROUP_UNARMED: This group is used for unarmed combat.
    GROUP_MELEE: This group is used for melee weapons.
    GROUP_PISTOL: This group is used for pistols.
    GROUP_SMG: This group is used for submachine guns.
    GROUP_ASSAULT_RIFLE: This group is used for assault rifles.
    GROUP_DMG: This group is used for heavy weapons.
    GROUP_SHOTGUN: This group is used for shotguns.
    GROUP_SNIPER: This group is used for sniper rifles.
    GROUP_HEAVY: This group is used for explosive weapons.
]]--


Config.heists = {
    shops = {
        -- shop1 = { -- shop1 = pierwszy sklep który stworzyłem tako
        --     name = "Sklep na Groove St.", -- Nazwa sklepu, można ustawić jakąś konkret, można zostawić Sklep
        --     vault = vector3(375.199432, -1412.894043, 41.509319), -- Miejsce utworzenia skarbca / sejfu
        --     reward = {10000,50000},
        --     npcSpawn = {
        --         [1] = vector3(0,0,0), -- Miejsce spawnu pierwszego npc
        --         [2] = vector3(0,0,0), -- Miejsce spawnu drugiego npc 
        --     },
        --     requiredWeaponType = "GROUP_MELEE", -- wymagany rodzaj broni, potem podam katerogire
        --     robberyType = "shop",
        --     robbingTime = 60, -- CZAS W SEKUNDACH!!!

        -- },
        shop1 = {
            name = 'Sklep na G.O.H.',
            vault = vector3(-2959.561279, 387.448456, 14.043196),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop2 = {
            name = 'Sklep na Inseno Road (G.O.H.)',
            vault = vector3(-3047.804443, 585.629578, 7.908927),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop3 = {
            name = 'Sklep na Chumash',
            vault = vector3(-3249.931885, 1004.402222, 12.830714),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop4 = {
            name = 'Sklep na Senora FWY (N)',
            vault = vector3(1734.837524, 6420.850586, 35.037228),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop5 = {
            name = 'Sklep na Grape Seed',
            vault = vector3(1707.891724, 4920.380371, 42.063663),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop6 = {
            name = 'Sklep na Alhambra DR. (Sandy E.)',
            vault = vector3(1959.182739, 3748.871582, 32.343731),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop7 = {
            name = 'Sklep na Algonquin BLVD. (Sandy W.)',
            vault = vector3(1395.097290, 3613.967529, 34.980865),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop8 = {
            name = 'Sklep na Senora FWY.',
            vault = vector3(2672.764404, 3286.545898, 55.241116),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop9 = {
            name = 'Sklep na Route 68',
            vault = vector3(546.326233, 2662.804688, 42.156551),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop10 = {
            name = 'Sklep na Palomino FWY.',
            vault = vector3(2549.292236, 385.009918, 108.622917),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop11 = {
            name = 'Sklep na Mirror Park',
            vault = vector3(1126.743408, -980.167664, 45.415836),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop12 = {
            name = 'Sklep na Vinewood (N)',
            vault = vector3(378.252136, 333.320831, 103.566338),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop13 = {
            name = 'Sklep na Ghetto',
            vault = vector3(28.291124, -1339.167847, 29.497017),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop14 = {
            name = 'Sklep przy Burger Shot',
            vault = vector3(-1220.761108, -916.020386, 11.326345),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
        shop15 = {
            name = 'Sklep na Del Perro',
            vault = vector3(-1479.063599, -375.498077, 39.163391),
            reward = {10000, 50000},
            npcSpawn = {

            },
            requiredWeaponType = "GROUP_MELEE",
            robberyType = "shop",
            robbingTime = 60, 
        },
    },
    banks = {
        bank1 = {
            name = "Fleeca na kwadracie", -- Nazwa banku, można ustawić jakąś konkret, można zostawić Sklep
            vault = vector3(0,0,0), -- Miejsce utworzenia skarbca / sejfu
            cops = 2, -- Wymagana liczba policjantów
            rMax = 100, -- Max kwota za napad
            rMin = 50, -- Min kwota za napad
            npcSpawn = {
                [1] = vector3(0,0,0), -- Miejsce spawnu pierwszego npc
                [2] = vector3(0,0,0), -- Miejsce spawnu drugiego npc 
            },
            requiredWeaponType = "GROUP_PISTOL", -- wymagany rodzaj broni
            cd = 60*1000, --cd na dany napad
        },
    },
}