do
  local MerfinPlus = select(2, ...)

  MerfinPlus.ItemSourceDB = MerfinPlus.ItemSourceDB or {}

  local DB = MerfinPlus.ItemSourceDB

  local function Add(itemID, src)
    local t = DB[itemID]
    if not t then
      t = {}
      DB[itemID] = t
    end
    t[#t + 1] = src
  end

  Add(23192, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "H",
  })
  Add(80860, {
    instanceEJ = 313,
    bossEJ = 672,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSMari",
    difficulty = "N",
  })
  Add(80861, {
    instanceEJ = 313,
    bossEJ = 672,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSMari",
    difficulty = "N",
  })
  Add(80862, {
    instanceEJ = 313,
    bossEJ = 672,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSMari",
    difficulty = "N",
  })
  Add(80863, {
    instanceEJ = 313,
    bossEJ = 664,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSStonestep",
    difficulty = "N",
  })
  Add(80864, {
    instanceEJ = 313,
    bossEJ = 664,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSStonestep",
    difficulty = "N",
  })
  Add(80865, {
    instanceEJ = 313,
    bossEJ = 664,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSStonestep",
    difficulty = "N",
  })
  Add(80866, {
    instanceEJ = 313,
    bossEJ = 658,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSFlameheart",
    difficulty = "N",
  })
  Add(80867, {
    instanceEJ = 313,
    bossEJ = 658,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSFlameheart",
    difficulty = "N",
  })
  Add(80868, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "N",
  })
  Add(80869, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "N",
  })
  Add(80870, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "N",
  })
  Add(80871, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "N",
  })
  Add(80872, {
    instanceEJ = 313,
    bossEJ = 658,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSFlameheart",
    difficulty = "N",
  })
  Add(80873, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "N",
  })
  Add(80874, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "N",
  })
  Add(80883, {
    instanceEJ = 312,
    bossEJ = 685,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanShaViolence",
    difficulty = "N",
  })
  Add(80892, {
    instanceEJ = 302,
    bossEJ = 668,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryOokOok",
    difficulty = "N",
  })
  Add(80893, {
    instanceEJ = 302,
    bossEJ = 669,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryHoptallus",
    difficulty = "N",
  })
  Add(80894, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "N",
  })
  Add(80895, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "N",
  })
  Add(80896, {
    instanceEJ = 302,
    bossEJ = 668,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryOokOok",
    difficulty = "N",
  })
  Add(80897, {
    instanceEJ = 302,
    bossEJ = 668,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryOokOok",
    difficulty = "N",
  })
  Add(80898, {
    instanceEJ = 302,
    bossEJ = 669,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryHoptallus",
    difficulty = "N",
  })
  Add(80899, {
    instanceEJ = 302,
    bossEJ = 669,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryHoptallus",
    difficulty = "N",
  })
  Add(80900, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "N",
  })
  Add(80901, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "N",
  })
  Add(80902, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "N",
  })
  Add(80903, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "N",
  })
  Add(80908, {
    instanceEJ = 312,
    bossEJ = 673,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanCloudstrike",
    difficulty = "N",
  })
  Add(80909, {
    instanceEJ = 312,
    bossEJ = 673,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanCloudstrike",
    difficulty = "N",
  })
  Add(80910, {
    instanceEJ = 312,
    bossEJ = 673,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanCloudstrike",
    difficulty = "N",
  })
  Add(80911, {
    instanceEJ = 312,
    bossEJ = 657,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanSnowdrift",
    difficulty = "N",
  })
  Add(80912, {
    instanceEJ = 312,
    bossEJ = 657,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanSnowdrift",
    difficulty = "N",
  })
  Add(80913, {
    instanceEJ = 312,
    bossEJ = 685,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanShaViolence",
    difficulty = "N",
  })
  Add(80915, {
    instanceEJ = 312,
    bossEJ = 685,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanShaViolence",
    difficulty = "N",
  })
  Add(80916, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "N",
  })
  Add(80917, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "N",
  })
  Add(80918, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "N",
  })
  Add(80919, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "N",
  })
  Add(80920, {
    instanceEJ = 303,
    bossEJ = 655,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSKiptilak",
    difficulty = "N",
  })
  Add(80921, {
    instanceEJ = 303,
    bossEJ = 655,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSKiptilak",
    difficulty = "N",
  })
  Add(80922, {
    instanceEJ = 303,
    bossEJ = 675,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSGadok",
    difficulty = "N",
  })
  Add(80923, {
    instanceEJ = 303,
    bossEJ = 675,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSGadok",
    difficulty = "N",
  })
  Add(80924, {
    instanceEJ = 303,
    bossEJ = 675,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSGadok",
    difficulty = "N",
  })
  Add(80925, {
    instanceEJ = 303,
    bossEJ = 676,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRimok",
    difficulty = "N",
  })
  Add(80926, {
    instanceEJ = 303,
    bossEJ = 676,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRimok",
    difficulty = "N",
  })
  Add(80927, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "N",
  })
  Add(80928, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "N",
  })
  Add(80929, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "N",
  })
  Add(80930, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "N",
  })
  Add(80931, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "N",
  })
  Add(80932, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "N",
  })
  Add(80933, {
    instanceEJ = 303,
    bossEJ = 676,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRimok",
    difficulty = "N",
  })
  Add(80934, {
    instanceEJ = 303,
    bossEJ = 655,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSKiptilak",
    difficulty = "N",
  })
  Add(80935, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "N",
  })
  Add(80936, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "N",
  })
  Add(80937, {
    instanceEJ = 312,
    bossEJ = 657,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanSnowdrift",
    difficulty = "N",
  })
  Add(81058, {
    instanceEJ = 313,
    bossEJ = 664,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSStonestep",
    difficulty = "C",
  })
  Add(81059, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(81060, {
    instanceEJ = 313,
    bossEJ = 664,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSStonestep",
    difficulty = "C",
  })
  Add(81061, {
    instanceEJ = 302,
    bossEJ = 668,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryOokOok",
    difficulty = "C",
  })
  Add(81062, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(81063, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(81064, {
    instanceEJ = 302,
    bossEJ = 668,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryOokOok",
    difficulty = "C",
  })
  Add(81065, {
    instanceEJ = 302,
    bossEJ = 669,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryHoptallus",
    difficulty = "C",
  })
  Add(81066, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(81067, {
    instanceEJ = 313,
    bossEJ = 658,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSFlameheart",
    difficulty = "C",
  })
  Add(81068, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(81069, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(81070, {
    instanceEJ = 313,
    bossEJ = 658,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSFlameheart",
    difficulty = "C",
  })
  Add(81071, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(81072, {
    instanceEJ = 313,
    bossEJ = 672,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSMari",
    difficulty = "C",
  })
  Add(81073, {
    instanceEJ = 313,
    bossEJ = 664,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSStonestep",
    difficulty = "C",
  })
  Add(81074, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(81075, {
    instanceEJ = 313,
    bossEJ = 672,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSMari",
    difficulty = "C",
  })
  Add(81076, {
    instanceEJ = 302,
    bossEJ = 669,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryHoptallus",
    difficulty = "C",
  })
  Add(81077, {
    instanceEJ = 302,
    bossEJ = 669,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryHoptallus",
    difficulty = "C",
  })
  Add(81078, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(81079, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(81080, {
    instanceEJ = 302,
    bossEJ = 668,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryOokOok",
    difficulty = "C",
  })
  Add(81081, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(81082, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(81083, {
    instanceEJ = 313,
    bossEJ = 672,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSMari",
    difficulty = "C",
  })
  Add(81084, {
    instanceEJ = 313,
    bossEJ = 658,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSFlameheart",
    difficulty = "C",
  })
  Add(81085, {
    instanceEJ = 303,
    bossEJ = 675,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSGadok",
    difficulty = "C",
  })
  Add(81086, {
    instanceEJ = 312,
    bossEJ = 673,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanCloudstrike",
    difficulty = "C",
  })
  Add(81087, {
    instanceEJ = 312,
    bossEJ = 657,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanSnowdrift",
    difficulty = "C",
  })
  Add(81088, {
    instanceEJ = 303,
    bossEJ = 676,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRimok",
    difficulty = "C",
  })
  Add(81089, {
    instanceEJ = 312,
    bossEJ = 685,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanShaViolence",
    difficulty = "C",
  })
  Add(81090, {
    instanceEJ = 303,
    bossEJ = 655,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSKiptilak",
    difficulty = "C",
  })
  Add(81091, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(81092, {
    instanceEJ = 312,
    bossEJ = 673,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanCloudstrike",
    difficulty = "C",
  })
  Add(81093, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(81094, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(81095, {
    instanceEJ = 303,
    bossEJ = 655,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSKiptilak",
    difficulty = "C",
  })
  Add(81096, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(81097, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(81098, {
    instanceEJ = 303,
    bossEJ = 675,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSGadok",
    difficulty = "C",
  })
  Add(81099, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(81100, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(81101, {
    instanceEJ = 312,
    bossEJ = 657,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanSnowdrift",
    difficulty = "C",
  })
  Add(81102, {
    instanceEJ = 312,
    bossEJ = 685,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanShaViolence",
    difficulty = "C",
  })
  Add(81103, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(81104, {
    instanceEJ = 303,
    bossEJ = 655,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSKiptilak",
    difficulty = "C",
  })
  Add(81105, {
    instanceEJ = 303,
    bossEJ = 676,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRimok",
    difficulty = "C",
  })
  Add(81106, {
    instanceEJ = 303,
    bossEJ = 676,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRimok",
    difficulty = "C",
  })
  Add(81107, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(81108, {
    instanceEJ = 312,
    bossEJ = 657,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanSnowdrift",
    difficulty = "C",
  })
  Add(81109, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(81110, {
    instanceEJ = 312,
    bossEJ = 673,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanCloudstrike",
    difficulty = "C",
  })
  Add(81111, {
    instanceEJ = 303,
    bossEJ = 675,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSGadok",
    difficulty = "C",
  })
  Add(81112, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(81113, {
    instanceEJ = 312,
    bossEJ = 685,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanShaViolence",
    difficulty = "C",
  })
  Add(81114, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(81123, {
    instanceEJ = 313,
    bossEJ = 672,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSMari",
    difficulty = "C",
  })
  Add(81124, {
    instanceEJ = 313,
    bossEJ = 672,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSMari",
    difficulty = "C",
  })
  Add(81125, {
    instanceEJ = 313,
    bossEJ = 664,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSStonestep",
    difficulty = "C",
  })
  Add(81126, {
    instanceEJ = 313,
    bossEJ = 664,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSStonestep",
    difficulty = "C",
  })
  Add(81127, {
    instanceEJ = 313,
    bossEJ = 658,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSFlameheart",
    difficulty = "C",
  })
  Add(81128, {
    instanceEJ = 313,
    bossEJ = 658,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSFlameheart",
    difficulty = "C",
  })
  Add(81129, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(81130, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(81131, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(81132, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(81133, {
    instanceEJ = 302,
    bossEJ = 668,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryOokOok",
    difficulty = "C",
  })
  Add(81134, {
    instanceEJ = 302,
    bossEJ = 668,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryOokOok",
    difficulty = "C",
  })
  Add(81135, {
    instanceEJ = 302,
    bossEJ = 669,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryHoptallus",
    difficulty = "C",
  })
  Add(81136, {
    instanceEJ = 302,
    bossEJ = 669,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryHoptallus",
    difficulty = "C",
  })
  Add(81138, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(81139, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(81140, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(81141, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(81179, {
    instanceEJ = 312,
    bossEJ = 673,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanCloudstrike",
    difficulty = "C",
  })
  Add(81180, {
    instanceEJ = 312,
    bossEJ = 673,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanCloudstrike",
    difficulty = "C",
  })
  Add(81181, {
    instanceEJ = 312,
    bossEJ = 657,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanSnowdrift",
    difficulty = "C",
  })
  Add(81182, {
    instanceEJ = 312,
    bossEJ = 657,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanSnowdrift",
    difficulty = "C",
  })
  Add(81184, {
    instanceEJ = 312,
    bossEJ = 685,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanShaViolence",
    difficulty = "C",
  })
  Add(81185, {
    instanceEJ = 312,
    bossEJ = 685,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanShaViolence",
    difficulty = "C",
  })
  Add(81186, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(81187, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(81188, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(81189, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(81190, {
    instanceEJ = 303,
    bossEJ = 655,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSKiptilak",
    difficulty = "C",
  })
  Add(81191, {
    instanceEJ = 303,
    bossEJ = 655,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSKiptilak",
    difficulty = "C",
  })
  Add(81192, {
    instanceEJ = 303,
    bossEJ = 675,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSGadok",
    difficulty = "C",
  })
  Add(81229, {
    instanceEJ = 303,
    bossEJ = 675,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSGadok",
    difficulty = "C",
  })
  Add(81230, {
    instanceEJ = 303,
    bossEJ = 676,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRimok",
    difficulty = "C",
  })
  Add(81232, {
    instanceEJ = 303,
    bossEJ = 676,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRimok",
    difficulty = "C",
  })
  Add(81233, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(81234, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(81235, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(81236, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(81237, {
    instanceEJ = 321,
    bossEJ = 708,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanTrialKing",
    difficulty = "C",
  })
  Add(81238, {
    instanceEJ = 321,
    bossEJ = 708,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanTrialKing",
    difficulty = "C",
  })
  Add(81239, {
    instanceEJ = 321,
    bossEJ = 708,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanTrialKing",
    difficulty = "C",
  })
  Add(81240, {
    instanceEJ = 321,
    bossEJ = 708,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanTrialKing",
    difficulty = "C",
  })
  Add(81241, {
    instanceEJ = 321,
    bossEJ = 708,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanTrialKing",
    difficulty = "C",
  })
  Add(81242, {
    instanceEJ = 321,
    bossEJ = 690,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanGekkan",
    difficulty = "C",
  })
  Add(81243, {
    instanceEJ = 321,
    bossEJ = 690,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanGekkan",
    difficulty = "C",
  })
  Add(81244, {
    instanceEJ = 321,
    bossEJ = 690,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanGekkan",
    difficulty = "C",
  })
  Add(81245, {
    instanceEJ = 321,
    bossEJ = 690,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanGekkan",
    difficulty = "C",
  })
  Add(81246, {
    instanceEJ = 321,
    bossEJ = 690,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanGekkan",
    difficulty = "C",
  })
  Add(81247, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(81248, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(81249, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(81251, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(81252, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(81253, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(81254, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(81255, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(81256, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(81257, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(81262, {
    instanceEJ = 324,
    bossEJ = 693,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTJinbak",
    difficulty = "C",
  })
  Add(81263, {
    instanceEJ = 324,
    bossEJ = 693,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTJinbak",
    difficulty = "C",
  })
  Add(81264, {
    instanceEJ = 324,
    bossEJ = 692,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTPavalak",
    difficulty = "C",
  })
  Add(81265, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(81266, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(81267, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(81268, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(81270, {
    instanceEJ = 324,
    bossEJ = 693,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTJinbak",
    difficulty = "C",
  })
  Add(81271, {
    instanceEJ = 324,
    bossEJ = 693,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTJinbak",
    difficulty = "C",
  })
  Add(81272, {
    instanceEJ = 324,
    bossEJ = 693,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTJinbak",
    difficulty = "C",
  })
  Add(81273, {
    instanceEJ = 324,
    bossEJ = 738,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTVojak",
    difficulty = "C",
  })
  Add(81274, {
    instanceEJ = 324,
    bossEJ = 738,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTVojak",
    difficulty = "C",
  })
  Add(81275, {
    instanceEJ = 324,
    bossEJ = 738,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTVojak",
    difficulty = "C",
  })
  Add(81276, {
    instanceEJ = 324,
    bossEJ = 738,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTVojak",
    difficulty = "C",
  })
  Add(81277, {
    instanceEJ = 324,
    bossEJ = 738,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTVojak",
    difficulty = "C",
  })
  Add(81279, {
    instanceEJ = 324,
    bossEJ = 692,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTPavalak",
    difficulty = "C",
  })
  Add(81280, {
    instanceEJ = 324,
    bossEJ = 692,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTPavalak",
    difficulty = "C",
  })
  Add(81281, {
    instanceEJ = 324,
    bossEJ = 692,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTPavalak",
    difficulty = "C",
  })
  Add(81282, {
    instanceEJ = 324,
    bossEJ = 692,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTPavalak",
    difficulty = "C",
  })
  Add(81283, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(81284, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(81285, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(81286, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(81287, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(81288, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(81289, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(81290, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(81291, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(81292, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(81560, {
    instanceEJ = 316,
    bossEJ = 688,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMThalnos",
    difficulty = "C",
  })
  Add(81561, {
    instanceEJ = 316,
    bossEJ = 671,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMKorloff",
    difficulty = "C",
  })
  Add(81562, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(81563, {
    instanceEJ = 311,
    bossEJ = 660,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHBraun",
    difficulty = "C",
  })
  Add(81563, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "C",
  })
  Add(81564, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(81565, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(81566, {
    instanceEJ = 246,
    bossEJ = 659,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoChillheart",
    difficulty = "C",
  })
  Add(81567, {
    instanceEJ = 246,
    bossEJ = 666,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoVoss",
    difficulty = "H",
  })
  Add(81568, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "H",
  })
  Add(81569, {
    instanceEJ = 316,
    bossEJ = 688,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMThalnos",
    difficulty = "C",
  })
  Add(81570, {
    instanceEJ = 316,
    bossEJ = 688,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMThalnos",
    difficulty = "C",
  })
  Add(81571, {
    instanceEJ = 316,
    bossEJ = 688,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMThalnos",
    difficulty = "C",
  })
  Add(81572, {
    instanceEJ = 316,
    bossEJ = 688,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMThalnos",
    difficulty = "C",
  })
  Add(81573, {
    instanceEJ = 316,
    bossEJ = 671,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMKorloff",
    difficulty = "C",
  })
  Add(81574, {
    instanceEJ = 316,
    bossEJ = 671,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMKorloff",
    difficulty = "C",
  })
  Add(81575, {
    instanceEJ = 316,
    bossEJ = 671,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMKorloff",
    difficulty = "C",
  })
  Add(81576, {
    instanceEJ = 316,
    bossEJ = 671,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMKorloff",
    difficulty = "C",
  })
  Add(81577, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(81578, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(81687, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(81688, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(81689, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(81690, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(81691, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(81692, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(81693, {
    instanceEJ = 311,
    bossEJ = 660,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHBraun",
    difficulty = "C",
  })
  Add(81693, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "C",
  })
  Add(81694, {
    instanceEJ = 311,
    bossEJ = 660,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHBraun",
    difficulty = "C",
  })
  Add(81694, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "C",
  })
  Add(81695, {
    instanceEJ = 311,
    bossEJ = 660,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHBraun",
    difficulty = "C",
  })
  Add(81695, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "C",
  })
  Add(81696, {
    instanceEJ = 311,
    bossEJ = 660,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHBraun",
    difficulty = "C",
  })
  Add(81696, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "C",
  })
  Add(81697, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "H",
  })
  Add(81698, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "H",
  })
  Add(81699, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "H",
  })
  Add(81700, {
    instanceEJ = 311,
    bossEJ = 654,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHHarlan",
    difficulty = "H",
  })
  Add(82470, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(82812, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(82813, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(82814, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(82815, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(82816, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(82817, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(82818, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(82819, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(82820, {
    instanceEJ = 246,
    bossEJ = 659,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoChillheart",
    difficulty = "C",
  })
  Add(82821, {
    instanceEJ = 246,
    bossEJ = 659,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoChillheart",
    difficulty = "C",
  })
  Add(82822, {
    instanceEJ = 246,
    bossEJ = 659,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoChillheart",
    difficulty = "C",
  })
  Add(82823, {
    instanceEJ = 246,
    bossEJ = 659,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoChillheart",
    difficulty = "C",
  })
  Add(82824, {
    instanceEJ = 246,
    bossEJ = 665,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoRattlegore",
    difficulty = "C",
  })
  Add(82824, {
    instanceEJ = 246,
    bossEJ = 666,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoVoss",
    difficulty = "C",
  })
  Add(82825, {
    instanceEJ = 246,
    bossEJ = 665,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoRattlegore",
    difficulty = "C",
  })
  Add(82825, {
    instanceEJ = 246,
    bossEJ = 666,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoVoss",
    difficulty = "C",
  })
  Add(82826, {
    instanceEJ = 246,
    bossEJ = 665,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoRattlegore",
    difficulty = "C",
  })
  Add(82826, {
    instanceEJ = 246,
    bossEJ = 666,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoVoss",
    difficulty = "C",
  })
  Add(82827, {
    instanceEJ = 246,
    bossEJ = 665,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoRattlegore",
    difficulty = "C",
  })
  Add(82827, {
    instanceEJ = 246,
    bossEJ = 666,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoVoss",
    difficulty = "C",
  })
  Add(82828, {
    instanceEJ = 246,
    bossEJ = 665,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoRattlegore",
    difficulty = "C",
  })
  Add(82828, {
    instanceEJ = 246,
    bossEJ = 666,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoVoss",
    difficulty = "C",
  })
  Add(82847, {
    instanceEJ = 246,
    bossEJ = 663,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoJandice",
    difficulty = "C",
  })
  Add(82848, {
    instanceEJ = 246,
    bossEJ = 663,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoJandice",
    difficulty = "C",
  })
  Add(82850, {
    instanceEJ = 246,
    bossEJ = 663,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoJandice",
    difficulty = "C",
  })
  Add(82851, {
    instanceEJ = 246,
    bossEJ = 663,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoJandice",
    difficulty = "C",
  })
  Add(82852, {
    instanceEJ = 246,
    bossEJ = 663,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoJandice",
    difficulty = "C",
  })
  Add(82853, {
    instanceEJ = 246,
    bossEJ = 666,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoVoss",
    difficulty = "H",
  })
  Add(82854, {
    instanceEJ = 246,
    bossEJ = 666,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoVoss",
    difficulty = "H",
  })
  Add(82855, {
    instanceEJ = 246,
    bossEJ = 666,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoVoss",
    difficulty = "H",
  })
  Add(82856, {
    instanceEJ = 246,
    bossEJ = 666,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoVoss",
    difficulty = "H",
  })
  Add(82857, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(82858, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(82859, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(82860, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(82861, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(82862, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(84801, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84802, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84803, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84804, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84805, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84806, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84807, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84808, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84809, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84810, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84811, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84812, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84813, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84814, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84815, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84816, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84817, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84818, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84819, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84820, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84821, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84822, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84823, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84824, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84825, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84826, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84827, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84828, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84829, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84830, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84831, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84832, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84833, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84834, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84835, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84836, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84837, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84838, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84839, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84840, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84841, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84842, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84843, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84844, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84845, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84846, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84847, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84886, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84887, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84888, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84889, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84890, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84891, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84892, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84946, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84947, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84948, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84949, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84950, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84951, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84952, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84953, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84954, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84955, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84956, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84957, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84958, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84959, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84960, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84972, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84973, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84974, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84975, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84976, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84977, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84978, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84979, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84980, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84981, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84982, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84983, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84984, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84985, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(84986, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85175, {
    instanceEJ = 321,
    bossEJ = 708,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanTrialKing",
    difficulty = "N",
  })
  Add(85176, {
    instanceEJ = 321,
    bossEJ = 708,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanTrialKing",
    difficulty = "N",
  })
  Add(85177, {
    instanceEJ = 321,
    bossEJ = 708,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanTrialKing",
    difficulty = "N",
  })
  Add(85178, {
    instanceEJ = 321,
    bossEJ = 708,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanTrialKing",
    difficulty = "N",
  })
  Add(85179, {
    instanceEJ = 321,
    bossEJ = 708,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanTrialKing",
    difficulty = "N",
  })
  Add(85180, {
    instanceEJ = 321,
    bossEJ = 690,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanGekkan",
    difficulty = "N",
  })
  Add(85181, {
    instanceEJ = 321,
    bossEJ = 690,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanGekkan",
    difficulty = "N",
  })
  Add(85182, {
    instanceEJ = 321,
    bossEJ = 690,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanGekkan",
    difficulty = "N",
  })
  Add(85183, {
    instanceEJ = 321,
    bossEJ = 690,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanGekkan",
    difficulty = "N",
  })
  Add(85184, {
    instanceEJ = 321,
    bossEJ = 690,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanGekkan",
    difficulty = "N",
  })
  Add(85185, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "N",
  })
  Add(85186, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "N",
  })
  Add(85187, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "N",
  })
  Add(85188, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "N",
  })
  Add(85189, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "N",
  })
  Add(85190, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "N",
  })
  Add(85191, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "N",
  })
  Add(85192, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "N",
  })
  Add(85193, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "N",
  })
  Add(85194, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "N",
  })
  Add(85285, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85287, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85290, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85292, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85295, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85297, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85300, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85302, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85306, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85308, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85310, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85312, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85315, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85317, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85320, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85322, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85325, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85327, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85330, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85331, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85335, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85337, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85340, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85342, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85345, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85347, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85350, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85352, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85356, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85358, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85361, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85363, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85364, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85366, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85369, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85371, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85376, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85378, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85380, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85382, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85385, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85387, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85389, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85391, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85395, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85397, {
    instanceEJ = 691,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(85922, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(85923, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(85924, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(85925, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(85926, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(85975, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(85976, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(85977, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(85978, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(85979, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(85980, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(85982, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(85983, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(85984, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(85985, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(85986, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(85987, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(85988, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(85989, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(85990, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(85991, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(85992, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(85993, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(85994, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(85995, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(85996, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(85997, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(86027, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(86038, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(86039, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(86040, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(86041, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(86042, {
    instanceEJ = 317,
    instanceKey = "MoguShanVaults",
    bossKey = "MoguShanVaultsTrash",
    difficulty = "N",
  })
  Add(86043, {
    instanceEJ = 317,
    instanceKey = "MoguShanVaults",
    bossKey = "MoguShanVaultsTrash",
    difficulty = "N",
  })
  Add(86044, {
    instanceEJ = 317,
    instanceKey = "MoguShanVaults",
    bossKey = "MoguShanVaultsTrash",
    difficulty = "N",
  })
  Add(86045, {
    instanceEJ = 317,
    instanceKey = "MoguShanVaults",
    bossKey = "MoguShanVaultsTrash",
    difficulty = "N",
  })
  Add(86046, {
    instanceEJ = 317,
    instanceKey = "MoguShanVaults",
    bossKey = "MoguShanVaultsTrash",
    difficulty = "N",
  })
  Add(86047, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86071, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86075, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86076, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86080, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86081, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86082, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86082, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(86083, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86084, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86086, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86127, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86128, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86129, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(86130, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86131, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86132, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86133, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86134, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(86135, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86136, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86137, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86138, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86139, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86140, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86141, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(86142, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(86144, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(86145, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(86146, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(86147, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(86148, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(86149, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(86150, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(86151, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(86152, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(86153, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(86154, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(86155, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(86156, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(86157, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(86158, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(86159, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(86160, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(86161, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(86162, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(86163, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(86164, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(86165, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(86166, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(86167, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(86168, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(86169, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(86170, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(86171, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(86172, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86173, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86174, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86175, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86176, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86177, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86178, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86179, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86180, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86181, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86182, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(86183, {
    instanceEJ = 330,
    instanceKey = "HeartofFear",
    bossKey = "HoFTrash",
    difficulty = "N",
  })
  Add(86184, {
    instanceEJ = 330,
    instanceKey = "HeartofFear",
    bossKey = "HoFTrash",
    difficulty = "N",
  })
  Add(86185, {
    instanceEJ = 330,
    instanceKey = "HeartofFear",
    bossKey = "HoFTrash",
    difficulty = "N",
  })
  Add(86186, {
    instanceEJ = 330,
    instanceKey = "HeartofFear",
    bossKey = "HoFTrash",
    difficulty = "N",
  })
  Add(86187, {
    instanceEJ = 330,
    instanceKey = "HeartofFear",
    bossKey = "HoFTrash",
    difficulty = "N",
  })
  Add(86188, {
    instanceEJ = 330,
    instanceKey = "HeartofFear",
    bossKey = "HoFTrash",
    difficulty = "N",
  })
  Add(86189, {
    instanceEJ = 330,
    instanceKey = "HeartofFear",
    bossKey = "HoFTrash",
    difficulty = "N",
  })
  Add(86190, {
    instanceEJ = 330,
    instanceKey = "HeartofFear",
    bossKey = "HoFTrash",
    difficulty = "N",
  })
  Add(86191, {
    instanceEJ = 330,
    instanceKey = "HeartofFear",
    bossKey = "HoFTrash",
    difficulty = "N",
  })
  Add(86192, {
    instanceEJ = 330,
    instanceKey = "HeartofFear",
    bossKey = "HoFTrash",
    difficulty = "N",
  })
  Add(86200, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "N",
  })
  Add(86201, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "N",
  })
  Add(86202, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "N",
  })
  Add(86203, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(86204, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "N",
  })
  Add(86205, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "N",
  })
  Add(86210, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "N",
  })
  Add(86211, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "N",
  })
  Add(86212, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "N",
  })
  Add(86213, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "N",
  })
  Add(86214, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "N",
  })
  Add(86217, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "N",
  })
  Add(86219, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "N",
  })
  Add(86226, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "N",
  })
  Add(86227, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "N",
  })
  Add(86228, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "N",
  })
  Add(86229, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "N",
  })
  Add(86230, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86231, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86232, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86233, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86234, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86315, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86316, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86317, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86318, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86319, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86320, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86321, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86322, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86323, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86324, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86325, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86326, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86327, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86328, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86329, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86330, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86331, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86332, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86333, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86334, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86335, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86336, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86337, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86337, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86338, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86338, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86339, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86339, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86340, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86340, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86341, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86341, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86342, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86342, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86343, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86343, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86383, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86383, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86384, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86384, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86385, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86385, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(86386, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "N",
  })
  Add(86387, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "N",
  })
  Add(86388, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "N",
  })
  Add(86389, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "N",
  })
  Add(86390, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(86391, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(86513, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "N",
  })
  Add(86514, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "N",
  })
  Add(86739, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(86741, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(86748, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(86753, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(86754, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(86759, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(86762, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(86764, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(86767, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(86776, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(86777, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(86778, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(86782, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(86783, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(86789, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(86790, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(86791, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(86792, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(86796, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(86799, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(86802, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(86805, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(86806, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(86813, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(86814, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(86820, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(86830, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(86851, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(86858, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(86863, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(86865, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(86871, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(86879, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(86880, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(86894, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(86943, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(86944, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(86945, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(86946, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(86947, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(86948, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(86949, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(86950, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(86951, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(86952, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(86953, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(86954, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(86955, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(86956, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(86957, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(86958, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(86959, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(86960, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(86961, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(86962, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(86963, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86964, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86965, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86966, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86967, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86968, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86969, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86970, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86971, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86972, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86973, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(86974, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "H",
  })
  Add(86975, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "H",
  })
  Add(86976, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "H",
  })
  Add(86977, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "H",
  })
  Add(86978, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "H",
  })
  Add(86979, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "H",
  })
  Add(86980, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "H",
  })
  Add(86981, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "H",
  })
  Add(86982, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "H",
  })
  Add(86983, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "H",
  })
  Add(86984, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "H",
  })
  Add(86985, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "H",
  })
  Add(86986, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "H",
  })
  Add(86987, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "H",
  })
  Add(86988, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "H",
  })
  Add(86989, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "H",
  })
  Add(86990, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "H",
  })
  Add(86991, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "H",
  })
  Add(87012, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87013, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87014, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87015, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87016, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87017, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87018, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87019, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87020, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87021, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87022, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87023, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87024, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87025, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87026, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87027, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87028, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87029, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87030, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87031, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87032, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87033, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87034, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87035, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87036, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87037, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87038, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87039, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87040, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87041, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87042, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87043, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(87044, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87044, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(87045, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87046, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87047, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87048, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87049, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87050, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87051, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87052, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87053, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87054, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87055, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87056, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(87057, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87058, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87059, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87060, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(87061, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87062, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87063, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87064, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87065, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87066, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87067, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87068, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87069, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87070, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87071, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87072, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87073, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87074, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87075, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87076, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87077, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87078, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87144, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87145, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87146, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87147, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87148, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87149, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87150, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87151, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87152, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87153, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87154, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87155, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(87156, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87157, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87158, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87159, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87160, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87161, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87162, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87163, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87164, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87165, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87166, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87167, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87168, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87169, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87170, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87171, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87172, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87173, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(87174, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(87175, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(87176, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(87177, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87177, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87178, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87178, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87179, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87179, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87180, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87180, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87181, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87181, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87182, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87182, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87183, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87183, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87184, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87184, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87185, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87185, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87186, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(87186, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(87208, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(87208, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(87208, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(87208, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(87208, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(87209, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(87209, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(87209, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(87209, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(87210, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(87268, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(87542, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(87543, {
    instanceEJ = 312,
    bossEJ = 686,
    instanceKey = "ShadoPanMonastery",
    bossKey = "ShadoPanTaranZhu",
    difficulty = "C",
  })
  Add(87544, {
    instanceEJ = 313,
    bossEJ = 335,
    instanceKey = "TempleOfTheJadeSerpent",
    bossKey = "TJSShaDoubt",
    difficulty = "C",
  })
  Add(87545, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
    difficulty = "C",
  })
  Add(87546, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(87547, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(87550, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(87551, {
    instanceEJ = 316,
    bossEJ = 674,
    instanceKey = "ScarletMonasteryMoP",
    bossKey = "SMWhitemane",
    difficulty = "C",
  })
  Add(87771, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(87777, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(87822, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(87824, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(87825, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(87827, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(89234, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "N",
  })
  Add(89235, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "N",
  })
  Add(89236, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "N",
  })
  Add(89237, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "N",
  })
  Add(89238, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "N",
  })
  Add(89239, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "N",
  })
  Add(89240, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "N",
  })
  Add(89241, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "N",
  })
  Add(89242, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "N",
  })
  Add(89243, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "N",
  })
  Add(89244, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "N",
  })
  Add(89245, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "N",
  })
  Add(89246, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(89247, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(89248, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "N",
  })
  Add(89249, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "H",
  })
  Add(89250, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "H",
  })
  Add(89251, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "H",
  })
  Add(89252, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "H",
  })
  Add(89253, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "H",
  })
  Add(89254, {
    instanceEJ = 330,
    bossEJ = 737,
    instanceKey = "HeartofFear",
    bossKey = "HoFUnsok",
    difficulty = "H",
  })
  Add(89255, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "H",
  })
  Add(89256, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "H",
  })
  Add(89257, {
    instanceEJ = 330,
    bossEJ = 741,
    instanceKey = "HeartofFear",
    bossKey = "HoFMeljarak",
    difficulty = "H",
  })
  Add(89258, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(89259, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(89260, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(89261, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(89262, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(89263, {
    instanceEJ = 320,
    bossEJ = 729,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESLeiShi",
    difficulty = "H",
  })
  Add(89317, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(89424, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(89425, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(89766, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(89767, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(89768, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "N",
  })
  Add(89783, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(89802, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(89803, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "N",
  })
  Add(89817, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "N",
  })
  Add(89818, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(89819, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "N",
  })
  Add(89820, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(89821, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(89822, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(89823, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(89824, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "N",
  })
  Add(89825, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "N",
  })
  Add(89826, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(89827, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(89828, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(89829, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "N",
  })
  Add(89830, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(89831, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(89832, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(89833, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(89834, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "N",
  })
  Add(89835, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "N",
  })
  Add(89836, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "N",
  })
  Add(89837, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "N",
  })
  Add(89839, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "N",
  })
  Add(89841, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(89842, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(89843, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(89883, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(89884, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "N",
  })
  Add(89885, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(89886, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "N",
  })
  Add(89887, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "N",
  })
  Add(89917, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(89918, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(89919, {
    instanceEJ = 330,
    bossEJ = 745,
    instanceKey = "HeartofFear",
    bossKey = "HoFZorlok",
    difficulty = "H",
  })
  Add(89920, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(89921, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(89922, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(89923, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(89924, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(89925, {
    instanceEJ = 330,
    bossEJ = 713,
    instanceKey = "HeartofFear",
    bossKey = "HoFGaralon",
    difficulty = "H",
  })
  Add(89926, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "H",
  })
  Add(89927, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "H",
  })
  Add(89928, {
    instanceEJ = 330,
    bossEJ = 743,
    instanceKey = "HeartofFear",
    bossKey = "HoFShekzeer",
    difficulty = "H",
  })
  Add(89929, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(89930, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(89931, {
    instanceEJ = 317,
    bossEJ = 679,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVTheStoneGuard",
    difficulty = "H",
  })
  Add(89932, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(89933, {
    instanceEJ = 317,
    bossEJ = 689,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVFeng",
    difficulty = "H",
  })
  Add(89934, {
    instanceEJ = 317,
    bossEJ = 682,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVGarajal",
    difficulty = "H",
  })
  Add(89935, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(89936, {
    instanceEJ = 317,
    bossEJ = 687,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVSpiritKings",
    difficulty = "H",
  })
  Add(89937, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(89938, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(89939, {
    instanceEJ = 317,
    bossEJ = 726,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVElegon",
    difficulty = "H",
  })
  Add(89940, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(89941, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(89942, {
    instanceEJ = 317,
    bossEJ = 677,
    instanceKey = "MoguShanVaults",
    bossKey = "MSVWilloftheEmperor",
    difficulty = "H",
  })
  Add(89943, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(89944, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(89945, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(89946, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(89947, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(89948, {
    instanceEJ = 320,
    bossEJ = 742,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESTsulong",
    difficulty = "H",
  })
  Add(89949, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(89950, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(89951, {
    instanceEJ = 320,
    bossEJ = 709,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESShaofFear",
    difficulty = "H",
  })
  Add(89952, {
    instanceEJ = 321,
    bossEJ = 698,
    instanceKey = "MoguShanPalace",
    bossKey = "MoguShanXin",
    difficulty = "C",
  })
  Add(89967, {
    instanceEJ = 311,
    bossEJ = 656,
    instanceKey = "ScarletHallsMoP",
    bossKey = "SHKoegler",
    difficulty = "C",
  })
  Add(89968, {
    instanceEJ = 246,
    bossEJ = 684,
    instanceKey = "ScholomanceMoP",
    bossKey = "ScholoGandling",
    difficulty = "C",
  })
  Add(89971, {
    instanceEJ = 303,
    bossEJ = 649,
    instanceKey = "GateoftheSettingSun",
    bossKey = "GotSSRaigonn",
    difficulty = "C",
  })
  Add(89972, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "C",
  })
  Add(90408, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90409, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90410, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90411, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90412, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90413, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90414, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90415, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90416, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90417, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90418, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90419, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90420, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90421, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90422, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90423, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90424, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90425, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90429, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90430, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90431, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90432, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90433, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90434, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90435, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90436, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90437, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90438, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90439, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90440, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90441, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90442, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90443, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90444, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90445, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90446, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90447, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90448, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90449, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90450, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90451, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90452, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90453, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90454, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90455, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90456, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90503, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90504, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90505, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90506, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90507, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90508, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90509, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90510, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90511, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90512, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90513, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90514, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90515, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90516, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "H",
  })
  Add(90517, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90518, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90519, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90520, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90521, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90522, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90523, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90524, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90525, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90526, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90527, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90528, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90529, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90530, {
    instanceEJ = 320,
    bossEJ = 683,
    instanceKey = "TerraceofEndlessSpring",
    bossKey = "ToESProtectors",
    difficulty = "N",
  })
  Add(90738, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "N",
  })
  Add(90740, {
    instanceEJ = 330,
    bossEJ = 744,
    instanceKey = "HeartofFear",
    bossKey = "HoFTayak",
    difficulty = "H",
  })
  Add(90839, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(90840, {
    instanceEJ = 322,
    bossEJ = 725,
    instanceKey = "WorldBossesMoP",
    bossKey = "SalyisWarband",
    difficulty = "N",
  })
  Add(90906, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(90907, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(90908, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(90909, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(90910, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(90911, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(90912, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(90913, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(90914, {
    instanceEJ = 322,
    bossEJ = 691,
    instanceKey = "WorldBossesMoP",
    bossKey = "ShaofAnger",
    difficulty = "N",
  })
  Add(91100, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91101, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91102, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91103, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91105, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91106, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91109, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91111, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91113, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91115, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91117, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91119, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91121, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91122, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91123, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91124, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91125, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91126, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91135, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91136, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91137, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91138, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91139, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91140, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91149, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91153, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91157, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91161, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91167, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91169, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91171, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91172, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91176, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91184, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91186, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91188, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91189, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91193, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91212, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91214, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91216, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91218, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91220, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91221, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91224, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91228, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91232, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91236, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91242, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91244, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91246, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91247, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91251, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91257, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91261, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91269, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91273, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91277, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91279, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91281, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91283, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91285, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91286, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91289, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91293, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91297, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91299, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91301, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91303, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91305, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91306, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91309, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91313, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91319, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91323, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91335, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91337, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91339, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91342, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91346, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91350, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91352, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91354, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91356, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91357, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91360, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91364, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91370, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91374, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91378, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91382, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91386, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91411, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91412, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91413, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91414, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91416, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91417, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91420, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91424, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91432, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(91436, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(93666, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
  })
  Add(94125, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
  })
  Add(94152, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
  })
  Add(94228, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(94288, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(94295, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(94328, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94330, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94331, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94333, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94334, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94336, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94337, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94340, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94343, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94344, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94351, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94352, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94353, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94354, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94355, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94357, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94358, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94359, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94360, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94362, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94363, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94364, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94365, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94368, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94370, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94371, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94374, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94376, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94377, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94378, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94379, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94380, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94382, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94383, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94384, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94390, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94391, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94393, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94394, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94395, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94399, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94400, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94402, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94403, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94404, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94407, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94408, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94410, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94411, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94412, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94414, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94417, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94418, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94420, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94421, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94423, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94424, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94425, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94427, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94432, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94435, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94438, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94439, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94440, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94441, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94445, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94446, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94448, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94449, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94451, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94452, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94453, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94455, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94458, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94461, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94462, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94464, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94465, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94468, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94469, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94470, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94471, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94472, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94473, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94474, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94476, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94477, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94478, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94480, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94481, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94483, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94484, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94485, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94486, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94487, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94488, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94489, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94490, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94491, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94494, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94496, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94497, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(94512, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 95997,
  })
  Add(94513, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96041,
  })
  Add(94514, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96013,
  })
  Add(94515, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96098,
  })
  Add(94516, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96049,
  })
  Add(94518, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96151,
  })
  Add(94519, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96129,
  })
  Add(94520, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96084,
  })
  Add(94521, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96083,
  })
  Add(94522, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96120,
  })
  Add(94523, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96037,
  })
  Add(94524, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96186,
  })
  Add(94525, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96135,
  })
  Add(94526, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96026,
  })
  Add(94527, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96099,
  })
  Add(94528, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96183,
  })
  Add(94529, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96171,
  })
  Add(94530, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96189,
  })
  Add(94531, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96144,
  })
  Add(94532, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96174,
  })
  Add(94722, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96004,
  })
  Add(94723, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96002,
  })
  Add(94724, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 95998,
  })
  Add(94725, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96000,
  })
  Add(94726, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96001,
  })
  Add(94727, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96003,
  })
  Add(94728, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 95999,
  })
  Add(94729, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96005,
  })
  Add(94730, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96012,
  })
  Add(94731, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96009,
  })
  Add(94732, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96014,
  })
  Add(94733, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96008,
  })
  Add(94734, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96016,
  })
  Add(94735, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96011,
  })
  Add(94736, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96015,
  })
  Add(94737, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96006,
  })
  Add(94738, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96010,
  })
  Add(94739, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 96007,
  })
  Add(94740, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96019,
  })
  Add(94741, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96021,
  })
  Add(94742, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96022,
  })
  Add(94743, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96020,
  })
  Add(94744, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96024,
  })
  Add(94745, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96025,
  })
  Add(94746, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96018,
  })
  Add(94747, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96023,
  })
  Add(94748, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96017,
  })
  Add(94749, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96029,
  })
  Add(94750, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96028,
  })
  Add(94751, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96036,
  })
  Add(94752, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96027,
  })
  Add(94753, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96034,
  })
  Add(94754, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96030,
  })
  Add(94755, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96032,
  })
  Add(94756, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96033,
  })
  Add(94757, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96173,
  })
  Add(94758, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96047,
  })
  Add(94759, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96038,
  })
  Add(94760, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96042,
  })
  Add(94761, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96040,
  })
  Add(94762, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96039,
  })
  Add(94763, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96044,
  })
  Add(94764, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96046,
  })
  Add(94765, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96043,
  })
  Add(94766, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96048,
  })
  Add(94767, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 96045,
  })
  Add(94768, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96058,
  })
  Add(94769, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96050,
  })
  Add(94770, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96051,
  })
  Add(94771, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96056,
  })
  Add(94772, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96054,
  })
  Add(94773, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96055,
  })
  Add(94774, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96059,
  })
  Add(94775, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96053,
  })
  Add(94776, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96057,
  })
  Add(94777, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96052,
  })
  Add(94778, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96064,
  })
  Add(94779, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96066,
  })
  Add(94780, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96062,
  })
  Add(94781, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96060,
  })
  Add(94782, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96061,
  })
  Add(94783, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96067,
  })
  Add(94784, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96068,
  })
  Add(94785, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96063,
  })
  Add(94786, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96065,
  })
  Add(94787, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 96069,
  })
  Add(94788, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96070,
  })
  Add(94789, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96075,
  })
  Add(94790, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96073,
  })
  Add(94791, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96072,
  })
  Add(94792, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96074,
  })
  Add(94793, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96077,
  })
  Add(94794, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96071,
  })
  Add(94795, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96076,
  })
  Add(94796, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96082,
  })
  Add(94797, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96087,
  })
  Add(94798, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96088,
  })
  Add(94799, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96078,
  })
  Add(94800, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96085,
  })
  Add(94801, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96079,
  })
  Add(94802, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96086,
  })
  Add(94803, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96081,
  })
  Add(94804, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 96080,
  })
  Add(94805, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96092,
  })
  Add(94806, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96091,
  })
  Add(94807, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96097,
  })
  Add(94808, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96094,
  })
  Add(94809, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96095,
  })
  Add(94810, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96096,
  })
  Add(94811, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96093,
  })
  Add(94812, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96089,
  })
  Add(94813, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 96090,
  })
  Add(94814, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96100,
  })
  Add(94815, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96105,
  })
  Add(94816, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96101,
  })
  Add(94817, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96106,
  })
  Add(94818, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96103,
  })
  Add(94819, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96102,
  })
  Add(94820, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96104,
  })
  Add(94821, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96107,
  })
  Add(94822, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96108,
  })
  Add(94835, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
  })
  Add(94867, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
  })
  Add(94922, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96115,
  })
  Add(94923, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96111,
  })
  Add(94924, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96118,
  })
  Add(94925, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96110,
  })
  Add(94926, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96117,
  })
  Add(94927, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96116,
  })
  Add(94928, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96112,
  })
  Add(94929, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96113,
  })
  Add(94930, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96119,
  })
  Add(94931, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96114,
  })
  Add(94937, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96130,
  })
  Add(94938, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96124,
  })
  Add(94939, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96121,
  })
  Add(94940, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96122,
  })
  Add(94941, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96126,
  })
  Add(94942, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96127,
  })
  Add(94943, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96123,
  })
  Add(94944, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96125,
  })
  Add(94945, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96140,
  })
  Add(94946, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96136,
  })
  Add(94947, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96132,
  })
  Add(94948, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96134,
  })
  Add(94949, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96137,
  })
  Add(94950, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96139,
  })
  Add(94951, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96131,
  })
  Add(94952, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96138,
  })
  Add(94953, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96133,
  })
  Add(94954, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96142,
  })
  Add(94955, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96146,
  })
  Add(94956, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96149,
  })
  Add(94957, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96148,
  })
  Add(94958, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96150,
  })
  Add(94959, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96143,
  })
  Add(94960, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96145,
  })
  Add(94961, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96141,
  })
  Add(94962, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 96147,
  })
  Add(94963, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96153,
  })
  Add(94964, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96162,
  })
  Add(94965, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96158,
  })
  Add(94966, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96155,
  })
  Add(94967, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96159,
  })
  Add(94968, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96156,
  })
  Add(94969, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96160,
  })
  Add(94970, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96154,
  })
  Add(94971, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96152,
  })
  Add(94972, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96161,
  })
  Add(94973, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96163,
  })
  Add(94974, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96167,
  })
  Add(94975, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96035,
  })
  Add(94976, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96170,
  })
  Add(94977, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96164,
  })
  Add(94978, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96169,
  })
  Add(94979, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96168,
  })
  Add(94980, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96165,
  })
  Add(94981, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96172,
  })
  Add(94982, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96181,
  })
  Add(94983, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96175,
  })
  Add(94984, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96178,
  })
  Add(94985, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96180,
  })
  Add(94986, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96177,
  })
  Add(94987, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96176,
  })
  Add(94988, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96187,
  })
  Add(94989, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96193,
  })
  Add(94990, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96184,
  })
  Add(94991, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96191,
  })
  Add(94992, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96192,
  })
  Add(94993, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96185,
  })
  Add(94994, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96188,
  })
  Add(94995, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(94996, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(94997, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(94998, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(94999, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95000, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95001, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95002, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95003, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95004, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95005, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95006, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95007, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95008, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95009, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95010, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95011, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95012, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95013, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95014, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95015, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95016, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95017, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95018, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95019, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95020, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95021, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95022, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95023, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95024, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95025, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95026, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95027, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95028, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95029, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95030, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95031, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95032, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95033, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95034, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95035, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95036, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95037, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95038, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95039, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95040, {
    instanceEJ = 362,
    bossEJ = 831,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTRaden",
    difficulty = "H",
  })
  Add(95057, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95059, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
  })
  Add(95060, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96242,
  })
  Add(95061, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96235,
  })
  Add(95062, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96241,
  })
  Add(95063, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96245,
  })
  Add(95064, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96243,
  })
  Add(95065, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96240,
  })
  Add(95066, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96236,
  })
  Add(95067, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96237,
  })
  Add(95068, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96246,
  })
  Add(95069, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96244,
  })
  Add(95147, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95148, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95149, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95150, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95151, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95152, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95153, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95163, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95164, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95165, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95166, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95167, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95177, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95178, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95179, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95180, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95181, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95182, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95183, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95184, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95185, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95186, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95187, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95188, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95189, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95190, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95191, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95192, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95193, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95194, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95195, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95196, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95197, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95198, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95199, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95200, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95201, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95202, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96330,
  })
  Add(95203, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96336,
  })
  Add(95204, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96341,
  })
  Add(95205, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96349,
  })
  Add(95206, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96352,
  })
  Add(95207, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96333,
  })
  Add(95208, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96334,
  })
  Add(95209, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96342,
  })
  Add(95210, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96343,
  })
  Add(95211, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96344,
  })
  Add(95212, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96345,
  })
  Add(95213, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96346,
  })
  Add(95214, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96347,
  })
  Add(95215, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96348,
  })
  Add(95216, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96340,
  })
  Add(95217, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96350,
  })
  Add(95218, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96351,
  })
  Add(95219, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96331,
  })
  Add(95220, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96332,
  })
  Add(95221, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96338,
  })
  Add(95222, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96339,
  })
  Add(95223, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96335,
  })
  Add(95224, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 96337,
  })
  Add(95226, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95228, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95231, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95233, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95236, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95238, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95240, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95242, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95245, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95247, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95251, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95253, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95256, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95258, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95260, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95262, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95266, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95268, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95270, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95272, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95276, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95278, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95281, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95283, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95286, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95288, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95291, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95293, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95295, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95297, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95300, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95302, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95306, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95308, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95311, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95313, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95316, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95318, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95321, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95323, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95325, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95327, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95332, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95333, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95336, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95338, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95472, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96182,
  })
  Add(95473, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96190,
  })
  Add(95498, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96249,
  })
  Add(95499, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96230,
  })
  Add(95500, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96239,
  })
  Add(95501, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96232,
  })
  Add(95502, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96248,
  })
  Add(95503, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96231,
  })
  Add(95504, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96233,
  })
  Add(95505, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96247,
  })
  Add(95506, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96238,
  })
  Add(95507, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96234,
  })
  Add(95510, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 95996,
  })
  Add(95511, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 96109,
  })
  Add(95512, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 96157,
  })
  Add(95513, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 96128,
  })
  Add(95514, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 96031,
  })
  Add(95515, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 96166,
  })
  Add(95516, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 96250,
  })
  Add(95535, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 96179,
  })
  Add(95569, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
  })
  Add(95570, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
  })
  Add(95571, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
  })
  Add(95572, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
  })
  Add(95573, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
  })
  Add(95574, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
  })
  Add(95575, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
  })
  Add(95576, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
  })
  Add(95577, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
  })
  Add(95578, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
  })
  Add(95579, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
  })
  Add(95580, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
  })
  Add(95581, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
  })
  Add(95582, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
  })
  Add(95583, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
  })
  Add(95601, {
    instanceEJ = 322,
    bossEJ = 826,
    instanceKey = "WorldBossesMoP",
    bossKey = "Oondasta",
    difficulty = "N",
  })
  Add(95602, {
    instanceEJ = 322,
    bossEJ = 814,
    instanceKey = "WorldBossesMoP",
    bossKey = "Nalak",
    difficulty = "N",
  })
  Add(95996, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 95510,
    type = true,
  })
  Add(95997, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94512,
    type = true,
  })
  Add(95998, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94724,
    type = true,
  })
  Add(95999, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94728,
    type = true,
  })
  Add(96000, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94725,
    type = true,
  })
  Add(96001, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94726,
    type = true,
  })
  Add(96002, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94723,
    type = true,
  })
  Add(96003, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94727,
    type = true,
  })
  Add(96004, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94722,
    type = true,
  })
  Add(96005, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94729,
    type = true,
  })
  Add(96006, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94737,
    type = true,
  })
  Add(96007, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94739,
    type = true,
  })
  Add(96008, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94733,
    type = true,
  })
  Add(96009, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94731,
    type = true,
  })
  Add(96010, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94738,
    type = true,
  })
  Add(96011, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94735,
    type = true,
  })
  Add(96012, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94730,
    type = true,
  })
  Add(96013, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94514,
    type = true,
  })
  Add(96014, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94732,
    type = true,
  })
  Add(96015, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94736,
    type = true,
  })
  Add(96016, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "N",
    sharedBase = 94734,
    type = true,
  })
  Add(96017, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94748,
    type = true,
  })
  Add(96018, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94746,
    type = true,
  })
  Add(96019, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94740,
    type = true,
  })
  Add(96020, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94743,
    type = true,
  })
  Add(96021, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94741,
    type = true,
  })
  Add(96022, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94742,
    type = true,
  })
  Add(96023, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94747,
    type = true,
  })
  Add(96024, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94744,
    type = true,
  })
  Add(96025, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94745,
    type = true,
  })
  Add(96026, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94526,
    type = true,
  })
  Add(96027, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94752,
    type = true,
  })
  Add(96028, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94750,
    type = true,
  })
  Add(96029, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94749,
    type = true,
  })
  Add(96030, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94754,
    type = true,
  })
  Add(96031, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 95514,
    type = true,
  })
  Add(96032, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94755,
    type = true,
  })
  Add(96033, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94756,
    type = true,
  })
  Add(96034, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94753,
    type = true,
  })
  Add(96035, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94975,
    type = true,
  })
  Add(96036, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "N",
    sharedBase = 94751,
    type = true,
  })
  Add(96037, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94523,
    type = true,
  })
  Add(96038, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94759,
    type = true,
  })
  Add(96039, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94762,
    type = true,
  })
  Add(96040, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94761,
    type = true,
  })
  Add(96041, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94513,
    type = true,
  })
  Add(96042, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94760,
    type = true,
  })
  Add(96043, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94765,
    type = true,
  })
  Add(96044, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94763,
    type = true,
  })
  Add(96045, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94767,
    type = true,
  })
  Add(96046, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94764,
    type = true,
  })
  Add(96047, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94758,
    type = true,
  })
  Add(96048, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94766,
    type = true,
  })
  Add(96049, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "N",
    sharedBase = 94516,
    type = true,
  })
  Add(96050, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94769,
    type = true,
  })
  Add(96051, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94770,
    type = true,
  })
  Add(96052, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94777,
    type = true,
  })
  Add(96053, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94775,
    type = true,
  })
  Add(96054, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94772,
    type = true,
  })
  Add(96055, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94773,
    type = true,
  })
  Add(96056, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94771,
    type = true,
  })
  Add(96057, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94776,
    type = true,
  })
  Add(96058, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94768,
    type = true,
  })
  Add(96059, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94774,
    type = true,
  })
  Add(96060, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94781,
    type = true,
  })
  Add(96061, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94782,
    type = true,
  })
  Add(96062, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94780,
    type = true,
  })
  Add(96063, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94785,
    type = true,
  })
  Add(96064, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94778,
    type = true,
  })
  Add(96065, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94786,
    type = true,
  })
  Add(96066, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94779,
    type = true,
  })
  Add(96067, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94783,
    type = true,
  })
  Add(96068, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94784,
    type = true,
  })
  Add(96069, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "N",
    sharedBase = 94787,
    type = true,
  })
  Add(96070, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94788,
    type = true,
  })
  Add(96071, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94794,
    type = true,
  })
  Add(96072, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94791,
    type = true,
  })
  Add(96073, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94790,
    type = true,
  })
  Add(96074, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94792,
    type = true,
  })
  Add(96075, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94789,
    type = true,
  })
  Add(96076, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94795,
    type = true,
  })
  Add(96077, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94793,
    type = true,
  })
  Add(96078, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94799,
    type = true,
  })
  Add(96079, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94801,
    type = true,
  })
  Add(96080, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94804,
    type = true,
  })
  Add(96081, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94803,
    type = true,
  })
  Add(96082, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94796,
    type = true,
  })
  Add(96083, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94521,
    type = true,
  })
  Add(96084, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94520,
    type = true,
  })
  Add(96085, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94800,
    type = true,
  })
  Add(96086, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94802,
    type = true,
  })
  Add(96087, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94797,
    type = true,
  })
  Add(96088, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "N",
    sharedBase = 94798,
    type = true,
  })
  Add(96089, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94812,
    type = true,
  })
  Add(96090, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94813,
    type = true,
  })
  Add(96091, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94806,
    type = true,
  })
  Add(96092, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94805,
    type = true,
  })
  Add(96093, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94811,
    type = true,
  })
  Add(96094, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94808,
    type = true,
  })
  Add(96095, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94809,
    type = true,
  })
  Add(96096, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94810,
    type = true,
  })
  Add(96097, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94807,
    type = true,
  })
  Add(96098, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94515,
    type = true,
  })
  Add(96099, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "N",
    sharedBase = 94527,
    type = true,
  })
  Add(96100, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94814,
    type = true,
  })
  Add(96101, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94816,
    type = true,
  })
  Add(96102, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94819,
    type = true,
  })
  Add(96103, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94818,
    type = true,
  })
  Add(96104, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94820,
    type = true,
  })
  Add(96105, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94815,
    type = true,
  })
  Add(96106, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94817,
    type = true,
  })
  Add(96107, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94821,
    type = true,
  })
  Add(96108, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94822,
    type = true,
  })
  Add(96109, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 95511,
    type = true,
  })
  Add(96110, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94925,
    type = true,
  })
  Add(96111, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94923,
    type = true,
  })
  Add(96112, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94928,
    type = true,
  })
  Add(96113, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94929,
    type = true,
  })
  Add(96114, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94931,
    type = true,
  })
  Add(96115, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94922,
    type = true,
  })
  Add(96116, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94927,
    type = true,
  })
  Add(96117, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94926,
    type = true,
  })
  Add(96118, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94924,
    type = true,
  })
  Add(96119, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "N",
    sharedBase = 94930,
    type = true,
  })
  Add(96120, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94522,
    type = true,
  })
  Add(96121, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94939,
    type = true,
  })
  Add(96122, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94940,
    type = true,
  })
  Add(96123, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94943,
    type = true,
  })
  Add(96124, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94938,
    type = true,
  })
  Add(96125, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94944,
    type = true,
  })
  Add(96126, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94941,
    type = true,
  })
  Add(96127, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94942,
    type = true,
  })
  Add(96128, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 95513,
    type = true,
  })
  Add(96129, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94519,
    type = true,
  })
  Add(96130, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94937,
    type = true,
  })
  Add(96131, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94951,
    type = true,
  })
  Add(96132, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94947,
    type = true,
  })
  Add(96133, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94953,
    type = true,
  })
  Add(96134, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94948,
    type = true,
  })
  Add(96135, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94525,
    type = true,
  })
  Add(96136, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94946,
    type = true,
  })
  Add(96137, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94949,
    type = true,
  })
  Add(96138, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94952,
    type = true,
  })
  Add(96139, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94950,
    type = true,
  })
  Add(96140, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "N",
    sharedBase = 94945,
    type = true,
  })
  Add(96141, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94961,
    type = true,
  })
  Add(96142, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94954,
    type = true,
  })
  Add(96143, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94959,
    type = true,
  })
  Add(96144, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94531,
    type = true,
  })
  Add(96145, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94960,
    type = true,
  })
  Add(96146, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94955,
    type = true,
  })
  Add(96147, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94962,
    type = true,
  })
  Add(96148, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94957,
    type = true,
  })
  Add(96149, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94956,
    type = true,
  })
  Add(96150, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94958,
    type = true,
  })
  Add(96151, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "N",
    sharedBase = 94518,
    type = true,
  })
  Add(96152, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 94971,
    type = true,
  })
  Add(96153, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 94963,
    type = true,
  })
  Add(96154, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 94970,
    type = true,
  })
  Add(96155, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 94966,
    type = true,
  })
  Add(96156, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 94968,
    type = true,
  })
  Add(96157, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 95512,
    type = true,
  })
  Add(96158, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 94965,
    type = true,
  })
  Add(96159, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 94967,
    type = true,
  })
  Add(96160, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 94969,
    type = true,
  })
  Add(96161, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 94972,
    type = true,
  })
  Add(96162, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "N",
    sharedBase = 94964,
    type = true,
  })
  Add(96163, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 94973,
    type = true,
  })
  Add(96164, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 94977,
    type = true,
  })
  Add(96165, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 94980,
    type = true,
  })
  Add(96166, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 95515,
    type = true,
  })
  Add(96167, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 94974,
    type = true,
  })
  Add(96168, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 94979,
    type = true,
  })
  Add(96169, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 94978,
    type = true,
  })
  Add(96170, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 94976,
    type = true,
  })
  Add(96171, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 94529,
    type = true,
  })
  Add(96172, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 94981,
    type = true,
  })
  Add(96173, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "N",
    sharedBase = 94757,
    type = true,
  })
  Add(96174, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94532,
    type = true,
  })
  Add(96175, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94983,
    type = true,
  })
  Add(96176, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94987,
    type = true,
  })
  Add(96177, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94986,
    type = true,
  })
  Add(96178, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94984,
    type = true,
  })
  Add(96179, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 95535,
    type = true,
  })
  Add(96180, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94985,
    type = true,
  })
  Add(96181, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94982,
    type = true,
  })
  Add(96182, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 95472,
    type = true,
  })
  Add(96183, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94528,
    type = true,
  })
  Add(96184, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94990,
    type = true,
  })
  Add(96185, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94993,
    type = true,
  })
  Add(96186, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94524,
    type = true,
  })
  Add(96187, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94988,
    type = true,
  })
  Add(96188, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94994,
    type = true,
  })
  Add(96189, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94530,
    type = true,
  })
  Add(96190, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 95473,
    type = true,
  })
  Add(96191, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94991,
    type = true,
  })
  Add(96192, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94992,
    type = true,
  })
  Add(96193, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "N",
    sharedBase = 94989,
    type = true,
  })
  Add(96230, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95499,
    type = true,
  })
  Add(96231, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95503,
    type = true,
  })
  Add(96232, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95501,
    type = true,
  })
  Add(96233, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95504,
    type = true,
  })
  Add(96234, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95507,
    type = true,
  })
  Add(96235, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95061,
    type = true,
  })
  Add(96236, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95066,
    type = true,
  })
  Add(96237, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95067,
    type = true,
  })
  Add(96238, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95506,
    type = true,
  })
  Add(96239, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95500,
    type = true,
  })
  Add(96240, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95065,
    type = true,
  })
  Add(96241, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95062,
    type = true,
  })
  Add(96242, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95060,
    type = true,
  })
  Add(96243, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95064,
    type = true,
  })
  Add(96244, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95069,
    type = true,
  })
  Add(96245, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95063,
    type = true,
  })
  Add(96246, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95068,
    type = true,
  })
  Add(96247, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95505,
    type = true,
  })
  Add(96248, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95502,
    type = true,
  })
  Add(96249, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95498,
    type = true,
  })
  Add(96250, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 95516,
    type = true,
  })
  Add(96330, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95202,
    type = true,
  })
  Add(96331, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95219,
    type = true,
  })
  Add(96332, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95220,
    type = true,
  })
  Add(96333, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95207,
    type = true,
  })
  Add(96334, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95208,
    type = true,
  })
  Add(96335, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95223,
    type = true,
  })
  Add(96336, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95203,
    type = true,
  })
  Add(96337, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95224,
    type = true,
  })
  Add(96338, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95221,
    type = true,
  })
  Add(96339, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95222,
    type = true,
  })
  Add(96340, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95216,
    type = true,
  })
  Add(96341, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95204,
    type = true,
  })
  Add(96342, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95209,
    type = true,
  })
  Add(96343, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95210,
    type = true,
  })
  Add(96344, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95211,
    type = true,
  })
  Add(96345, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95212,
    type = true,
  })
  Add(96346, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95213,
    type = true,
  })
  Add(96347, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95214,
    type = true,
  })
  Add(96348, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95215,
    type = true,
  })
  Add(96349, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95205,
    type = true,
  })
  Add(96350, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95217,
    type = true,
  })
  Add(96351, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95218,
    type = true,
  })
  Add(96352, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTrash",
    difficulty = "N",
    sharedBase = 95206,
    type = true,
  })
  Add(96368, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96740,
  })
  Add(96369, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96741,
  })
  Add(96370, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96742,
  })
  Add(96371, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96743,
  })
  Add(96372, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96744,
  })
  Add(96373, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96745,
  })
  Add(96374, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96746,
  })
  Add(96375, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96747,
  })
  Add(96376, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96748,
  })
  Add(96377, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96749,
  })
  Add(96378, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96750,
  })
  Add(96379, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96751,
  })
  Add(96380, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96752,
  })
  Add(96381, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96753,
  })
  Add(96382, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96754,
  })
  Add(96383, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96755,
  })
  Add(96384, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96756,
  })
  Add(96385, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96757,
  })
  Add(96386, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96758,
  })
  Add(96387, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96759,
  })
  Add(96388, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96760,
  })
  Add(96389, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96761,
  })
  Add(96390, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96762,
  })
  Add(96391, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96763,
  })
  Add(96392, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96764,
  })
  Add(96393, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96765,
  })
  Add(96394, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96766,
  })
  Add(96395, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96767,
  })
  Add(96396, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96768,
  })
  Add(96397, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96769,
  })
  Add(96398, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96770,
  })
  Add(96399, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96771,
  })
  Add(96400, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96772,
  })
  Add(96401, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96773,
  })
  Add(96402, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96774,
  })
  Add(96403, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96775,
  })
  Add(96404, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96776,
  })
  Add(96405, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96777,
  })
  Add(96406, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96778,
  })
  Add(96407, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96779,
  })
  Add(96408, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96780,
  })
  Add(96409, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96781,
  })
  Add(96410, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96782,
  })
  Add(96411, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96783,
  })
  Add(96412, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96784,
  })
  Add(96413, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96785,
  })
  Add(96414, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96786,
  })
  Add(96415, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96787,
  })
  Add(96416, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96788,
  })
  Add(96417, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96789,
  })
  Add(96418, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96790,
  })
  Add(96419, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96791,
  })
  Add(96420, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96792,
  })
  Add(96421, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96793,
  })
  Add(96422, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96794,
  })
  Add(96423, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96795,
  })
  Add(96424, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96796,
  })
  Add(96425, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96797,
  })
  Add(96426, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96798,
  })
  Add(96427, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96799,
  })
  Add(96428, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96800,
  })
  Add(96429, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96801,
  })
  Add(96430, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96802,
  })
  Add(96431, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96803,
  })
  Add(96432, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96804,
  })
  Add(96433, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96805,
  })
  Add(96434, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96806,
  })
  Add(96435, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96807,
  })
  Add(96436, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96808,
  })
  Add(96437, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96809,
  })
  Add(96438, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96810,
  })
  Add(96439, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96811,
  })
  Add(96440, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96812,
  })
  Add(96441, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96813,
  })
  Add(96442, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96814,
  })
  Add(96443, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96815,
  })
  Add(96444, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96816,
  })
  Add(96445, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96817,
  })
  Add(96446, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96818,
  })
  Add(96447, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96819,
  })
  Add(96448, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96820,
  })
  Add(96449, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96821,
  })
  Add(96450, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96822,
  })
  Add(96451, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96823,
  })
  Add(96452, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96824,
  })
  Add(96453, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96825,
  })
  Add(96454, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96826,
  })
  Add(96455, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96827,
  })
  Add(96456, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96828,
  })
  Add(96457, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96829,
  })
  Add(96458, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96830,
  })
  Add(96459, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96831,
  })
  Add(96460, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96832,
  })
  Add(96461, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96833,
  })
  Add(96462, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96834,
  })
  Add(96463, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96835,
  })
  Add(96464, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96836,
  })
  Add(96465, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96837,
  })
  Add(96466, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96838,
  })
  Add(96467, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96839,
  })
  Add(96468, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96840,
  })
  Add(96469, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96841,
  })
  Add(96470, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96842,
  })
  Add(96471, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96843,
  })
  Add(96472, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96844,
  })
  Add(96473, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96845,
  })
  Add(96474, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96846,
  })
  Add(96475, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96847,
  })
  Add(96476, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96848,
  })
  Add(96477, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96849,
  })
  Add(96478, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96850,
  })
  Add(96479, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96851,
  })
  Add(96480, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96852,
  })
  Add(96481, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96853,
  })
  Add(96482, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96854,
  })
  Add(96483, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96855,
  })
  Add(96484, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96856,
  })
  Add(96485, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96857,
  })
  Add(96486, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96858,
  })
  Add(96487, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96859,
  })
  Add(96488, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96860,
  })
  Add(96489, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96861,
  })
  Add(96490, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96862,
  })
  Add(96491, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96863,
  })
  Add(96492, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96864,
  })
  Add(96493, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96865,
  })
  Add(96494, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96866,
  })
  Add(96495, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96867,
  })
  Add(96496, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96868,
  })
  Add(96497, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96869,
  })
  Add(96498, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96870,
  })
  Add(96499, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96871,
  })
  Add(96500, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96872,
  })
  Add(96501, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96873,
  })
  Add(96502, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96874,
  })
  Add(96503, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96875,
  })
  Add(96504, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96876,
  })
  Add(96505, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96877,
  })
  Add(96506, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96878,
  })
  Add(96507, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96879,
  })
  Add(96508, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96880,
  })
  Add(96509, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96881,
  })
  Add(96510, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96882,
  })
  Add(96511, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96883,
  })
  Add(96512, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96884,
  })
  Add(96513, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96885,
  })
  Add(96514, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96886,
  })
  Add(96515, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96887,
  })
  Add(96516, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96888,
  })
  Add(96517, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96889,
  })
  Add(96518, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96890,
  })
  Add(96519, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96891,
  })
  Add(96520, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96892,
  })
  Add(96521, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96893,
  })
  Add(96522, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96894,
  })
  Add(96523, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96895,
  })
  Add(96524, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96896,
  })
  Add(96525, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96897,
  })
  Add(96526, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96898,
  })
  Add(96527, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96899,
  })
  Add(96528, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96900,
  })
  Add(96529, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96901,
  })
  Add(96530, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96902,
  })
  Add(96531, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96903,
  })
  Add(96532, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96904,
  })
  Add(96533, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96905,
  })
  Add(96534, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96906,
  })
  Add(96535, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96907,
  })
  Add(96536, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96908,
  })
  Add(96537, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96909,
  })
  Add(96538, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96910,
  })
  Add(96539, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96911,
  })
  Add(96540, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96912,
  })
  Add(96541, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96913,
  })
  Add(96542, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96914,
  })
  Add(96543, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96915,
  })
  Add(96544, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96916,
  })
  Add(96545, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96917,
  })
  Add(96546, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96918,
  })
  Add(96547, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96919,
  })
  Add(96548, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96920,
  })
  Add(96549, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96921,
  })
  Add(96550, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96922,
  })
  Add(96551, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96923,
  })
  Add(96552, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96924,
  })
  Add(96553, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96925,
  })
  Add(96554, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96926,
  })
  Add(96555, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96927,
  })
  Add(96556, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96928,
  })
  Add(96557, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96929,
  })
  Add(96558, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96930,
  })
  Add(96559, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96931,
  })
  Add(96560, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96932,
  })
  Add(96561, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96933,
  })
  Add(96562, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96934,
  })
  Add(96563, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96935,
  })
  Add(96564, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96936,
  })
  Add(96565, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96937,
  })
  Add(96566, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
  })
  Add(96567, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
  })
  Add(96568, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
  })
  Add(96599, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
  })
  Add(96600, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
  })
  Add(96601, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
  })
  Add(96602, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96974,
  })
  Add(96603, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96975,
  })
  Add(96604, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96976,
  })
  Add(96605, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96977,
  })
  Add(96606, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96978,
  })
  Add(96607, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96979,
  })
  Add(96608, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96980,
  })
  Add(96609, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96981,
  })
  Add(96610, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96982,
  })
  Add(96611, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96983,
  })
  Add(96612, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96984,
  })
  Add(96613, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96985,
  })
  Add(96614, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96986,
  })
  Add(96615, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96987,
  })
  Add(96616, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96988,
  })
  Add(96617, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96989,
  })
  Add(96618, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96990,
  })
  Add(96619, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96991,
  })
  Add(96620, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96992,
  })
  Add(96621, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96993,
  })
  Add(96622, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96994,
  })
  Add(96623, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
  })
  Add(96624, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
  })
  Add(96625, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
  })
  Add(96631, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
  })
  Add(96632, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
  })
  Add(96633, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
  })
  Add(96699, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
  })
  Add(96700, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
  })
  Add(96701, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
  })
  Add(96740, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96368,
    type = true,
  })
  Add(96741, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96369,
    type = true,
  })
  Add(96742, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96370,
    type = true,
  })
  Add(96743, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96371,
    type = true,
  })
  Add(96744, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96372,
    type = true,
  })
  Add(96745, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96373,
    type = true,
  })
  Add(96746, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96374,
    type = true,
  })
  Add(96747, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96375,
    type = true,
  })
  Add(96748, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96376,
    type = true,
  })
  Add(96749, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96377,
    type = true,
  })
  Add(96750, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96378,
    type = true,
  })
  Add(96751, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96379,
    type = true,
  })
  Add(96752, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96380,
    type = true,
  })
  Add(96753, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96381,
    type = true,
  })
  Add(96754, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96382,
    type = true,
  })
  Add(96755, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96383,
    type = true,
  })
  Add(96756, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96384,
    type = true,
  })
  Add(96757, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96385,
    type = true,
  })
  Add(96758, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96386,
    type = true,
  })
  Add(96759, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96387,
    type = true,
  })
  Add(96760, {
    instanceEJ = 362,
    bossEJ = 827,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJinrokh",
    difficulty = "H",
    sharedBase = 96388,
    type = true,
  })
  Add(96761, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96389,
    type = true,
  })
  Add(96762, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96390,
    type = true,
  })
  Add(96763, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96391,
    type = true,
  })
  Add(96764, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96392,
    type = true,
  })
  Add(96765, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96393,
    type = true,
  })
  Add(96766, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96394,
    type = true,
  })
  Add(96767, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96395,
    type = true,
  })
  Add(96768, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96396,
    type = true,
  })
  Add(96769, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96397,
    type = true,
  })
  Add(96770, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96398,
    type = true,
  })
  Add(96771, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96399,
    type = true,
  })
  Add(96772, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96400,
    type = true,
  })
  Add(96773, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96401,
    type = true,
  })
  Add(96774, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96402,
    type = true,
  })
  Add(96775, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96403,
    type = true,
  })
  Add(96776, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96404,
    type = true,
  })
  Add(96777, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96405,
    type = true,
  })
  Add(96778, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96406,
    type = true,
  })
  Add(96779, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96407,
    type = true,
  })
  Add(96780, {
    instanceEJ = 362,
    bossEJ = 819,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTHorridon",
    difficulty = "H",
    sharedBase = 96408,
    type = true,
  })
  Add(96781, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96409,
    type = true,
  })
  Add(96782, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96410,
    type = true,
  })
  Add(96783, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96411,
    type = true,
  })
  Add(96784, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96412,
    type = true,
  })
  Add(96785, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96413,
    type = true,
  })
  Add(96786, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96414,
    type = true,
  })
  Add(96787, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96415,
    type = true,
  })
  Add(96788, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96416,
    type = true,
  })
  Add(96789, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96417,
    type = true,
  })
  Add(96790, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96418,
    type = true,
  })
  Add(96791, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96419,
    type = true,
  })
  Add(96792, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96420,
    type = true,
  })
  Add(96793, {
    instanceEJ = 362,
    bossEJ = 816,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTCouncil",
    difficulty = "H",
    sharedBase = 96421,
    type = true,
  })
  Add(96794, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96422,
    type = true,
  })
  Add(96795, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96423,
    type = true,
  })
  Add(96796, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96424,
    type = true,
  })
  Add(96797, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96425,
    type = true,
  })
  Add(96798, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96426,
    type = true,
  })
  Add(96799, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96427,
    type = true,
  })
  Add(96800, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96428,
    type = true,
  })
  Add(96801, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96429,
    type = true,
  })
  Add(96802, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96430,
    type = true,
  })
  Add(96803, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96431,
    type = true,
  })
  Add(96804, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96432,
    type = true,
  })
  Add(96805, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96433,
    type = true,
  })
  Add(96806, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96434,
    type = true,
  })
  Add(96807, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96435,
    type = true,
  })
  Add(96808, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96436,
    type = true,
  })
  Add(96809, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96437,
    type = true,
  })
  Add(96810, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96438,
    type = true,
  })
  Add(96811, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96439,
    type = true,
  })
  Add(96812, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96440,
    type = true,
  })
  Add(96813, {
    instanceEJ = 362,
    bossEJ = 825,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTortos",
    difficulty = "H",
    sharedBase = 96441,
    type = true,
  })
  Add(96814, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96442,
    type = true,
  })
  Add(96815, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96443,
    type = true,
  })
  Add(96816, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96444,
    type = true,
  })
  Add(96817, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96445,
    type = true,
  })
  Add(96818, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96446,
    type = true,
  })
  Add(96819, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96447,
    type = true,
  })
  Add(96820, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96448,
    type = true,
  })
  Add(96821, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96449,
    type = true,
  })
  Add(96822, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96450,
    type = true,
  })
  Add(96823, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96451,
    type = true,
  })
  Add(96824, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96452,
    type = true,
  })
  Add(96825, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96453,
    type = true,
  })
  Add(96826, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96454,
    type = true,
  })
  Add(96827, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96455,
    type = true,
  })
  Add(96828, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96456,
    type = true,
  })
  Add(96829, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96457,
    type = true,
  })
  Add(96830, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96458,
    type = true,
  })
  Add(96831, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96459,
    type = true,
  })
  Add(96832, {
    instanceEJ = 362,
    bossEJ = 821,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTMegaera",
    difficulty = "H",
    sharedBase = 96460,
    type = true,
  })
  Add(96833, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96461,
    type = true,
  })
  Add(96834, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96462,
    type = true,
  })
  Add(96835, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96463,
    type = true,
  })
  Add(96836, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96464,
    type = true,
  })
  Add(96837, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96465,
    type = true,
  })
  Add(96838, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96466,
    type = true,
  })
  Add(96839, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96467,
    type = true,
  })
  Add(96840, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96468,
    type = true,
  })
  Add(96841, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96469,
    type = true,
  })
  Add(96842, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96470,
    type = true,
  })
  Add(96843, {
    instanceEJ = 362,
    bossEJ = 828,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTJiKun",
    difficulty = "H",
    sharedBase = 96471,
    type = true,
  })
  Add(96844, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96472,
    type = true,
  })
  Add(96845, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96473,
    type = true,
  })
  Add(96846, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96474,
    type = true,
  })
  Add(96847, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96475,
    type = true,
  })
  Add(96848, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96476,
    type = true,
  })
  Add(96849, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96477,
    type = true,
  })
  Add(96850, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96478,
    type = true,
  })
  Add(96851, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96479,
    type = true,
  })
  Add(96852, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96480,
    type = true,
  })
  Add(96853, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96481,
    type = true,
  })
  Add(96854, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96482,
    type = true,
  })
  Add(96855, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96483,
    type = true,
  })
  Add(96856, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96484,
    type = true,
  })
  Add(96857, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96485,
    type = true,
  })
  Add(96858, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96486,
    type = true,
  })
  Add(96859, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96487,
    type = true,
  })
  Add(96860, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96488,
    type = true,
  })
  Add(96861, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96489,
    type = true,
  })
  Add(96862, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96490,
    type = true,
  })
  Add(96863, {
    instanceEJ = 362,
    bossEJ = 818,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDurumu",
    difficulty = "H",
    sharedBase = 96491,
    type = true,
  })
  Add(96864, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96492,
    type = true,
  })
  Add(96865, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96493,
    type = true,
  })
  Add(96866, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96494,
    type = true,
  })
  Add(96867, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96495,
    type = true,
  })
  Add(96868, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96496,
    type = true,
  })
  Add(96869, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96497,
    type = true,
  })
  Add(96870, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96498,
    type = true,
  })
  Add(96871, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96499,
    type = true,
  })
  Add(96872, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96500,
    type = true,
  })
  Add(96873, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96501,
    type = true,
  })
  Add(96874, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96502,
    type = true,
  })
  Add(96875, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96503,
    type = true,
  })
  Add(96876, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96504,
    type = true,
  })
  Add(96877, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96505,
    type = true,
  })
  Add(96878, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96506,
    type = true,
  })
  Add(96879, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96507,
    type = true,
  })
  Add(96880, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96508,
    type = true,
  })
  Add(96881, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96509,
    type = true,
  })
  Add(96882, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96510,
    type = true,
  })
  Add(96883, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96511,
    type = true,
  })
  Add(96884, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
    sharedBase = 96512,
    type = true,
  })
  Add(96885, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96513,
    type = true,
  })
  Add(96886, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96514,
    type = true,
  })
  Add(96887, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96515,
    type = true,
  })
  Add(96888, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96516,
    type = true,
  })
  Add(96889, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96517,
    type = true,
  })
  Add(96890, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96518,
    type = true,
  })
  Add(96891, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96519,
    type = true,
  })
  Add(96892, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96520,
    type = true,
  })
  Add(96893, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96521,
    type = true,
  })
  Add(96894, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96522,
    type = true,
  })
  Add(96895, {
    instanceEJ = 362,
    bossEJ = 824,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTDarkAnimus",
    difficulty = "H",
    sharedBase = 96523,
    type = true,
  })
  Add(96896, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96524,
    type = true,
  })
  Add(96897, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96525,
    type = true,
  })
  Add(96898, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96526,
    type = true,
  })
  Add(96899, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96527,
    type = true,
  })
  Add(96900, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96528,
    type = true,
  })
  Add(96901, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96529,
    type = true,
  })
  Add(96902, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96530,
    type = true,
  })
  Add(96903, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96531,
    type = true,
  })
  Add(96904, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96532,
    type = true,
  })
  Add(96905, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96533,
    type = true,
  })
  Add(96906, {
    instanceEJ = 362,
    bossEJ = 817,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTIronQon",
    difficulty = "H",
    sharedBase = 96534,
    type = true,
  })
  Add(96907, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96535,
    type = true,
  })
  Add(96908, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96536,
    type = true,
  })
  Add(96909, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96537,
    type = true,
  })
  Add(96910, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96538,
    type = true,
  })
  Add(96911, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96539,
    type = true,
  })
  Add(96912, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96540,
    type = true,
  })
  Add(96913, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96541,
    type = true,
  })
  Add(96914, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96542,
    type = true,
  })
  Add(96915, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96543,
    type = true,
  })
  Add(96916, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96544,
    type = true,
  })
  Add(96917, {
    instanceEJ = 362,
    bossEJ = 829,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTTwinConsorts",
    difficulty = "H",
    sharedBase = 96545,
    type = true,
  })
  Add(96918, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96546,
    type = true,
  })
  Add(96919, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96547,
    type = true,
  })
  Add(96920, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96548,
    type = true,
  })
  Add(96921, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96549,
    type = true,
  })
  Add(96922, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96550,
    type = true,
  })
  Add(96923, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96551,
    type = true,
  })
  Add(96924, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96552,
    type = true,
  })
  Add(96925, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96553,
    type = true,
  })
  Add(96926, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96554,
    type = true,
  })
  Add(96927, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96555,
    type = true,
  })
  Add(96928, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96556,
    type = true,
  })
  Add(96929, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96557,
    type = true,
  })
  Add(96930, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96558,
    type = true,
  })
  Add(96931, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96559,
    type = true,
  })
  Add(96932, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96560,
    type = true,
  })
  Add(96933, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96561,
    type = true,
  })
  Add(96934, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96562,
    type = true,
  })
  Add(96935, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96563,
    type = true,
  })
  Add(96936, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96564,
    type = true,
  })
  Add(96937, {
    instanceEJ = 362,
    bossEJ = 832,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTLeiShen",
    difficulty = "H",
    sharedBase = 96565,
    type = true,
  })
  Add(96974, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96602,
    type = true,
  })
  Add(96975, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96603,
    type = true,
  })
  Add(96976, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96604,
    type = true,
  })
  Add(96977, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96605,
    type = true,
  })
  Add(96978, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96606,
    type = true,
  })
  Add(96979, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96607,
    type = true,
  })
  Add(96980, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96608,
    type = true,
  })
  Add(96981, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96609,
    type = true,
  })
  Add(96982, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96610,
    type = true,
  })
  Add(96983, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96611,
    type = true,
  })
  Add(96984, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96612,
    type = true,
  })
  Add(96985, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96613,
    type = true,
  })
  Add(96986, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96614,
    type = true,
  })
  Add(96987, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96615,
    type = true,
  })
  Add(96988, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96616,
    type = true,
  })
  Add(96989, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96617,
    type = true,
  })
  Add(96990, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96618,
    type = true,
  })
  Add(96991, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96619,
    type = true,
  })
  Add(96992, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96620,
    type = true,
  })
  Add(96993, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96621,
    type = true,
  })
  Add(96994, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 96622,
    type = true,
  })
  Add(97126, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 97128,
  })
  Add(97127, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 97130,
  })
  Add(97128, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "N",
    sharedBase = 97126,
    type = true,
  })
  Add(97130, {
    instanceEJ = 362,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTShared",
    difficulty = "H",
    sharedBase = 97127,
    type = true,
  })
  Add(97960, {
    instanceEJ = 362,
    bossEJ = 820,
    instanceKey = "ThroneofThunder",
    bossKey = "ToTPrimordius",
    difficulty = "H",
  })
  Add(99092, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99094, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99096, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99098, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99099, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99102, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99104, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99108, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99113, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99115, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99118, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99121, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99123, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99124, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99127, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99129, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99131, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99134, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99137, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99139, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99141, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99143, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99145, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99147, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99149, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99155, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99158, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99160, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99162, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99163, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99165, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99168, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99171, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99174, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99176, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99181, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99183, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99185, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99186, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99189, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99191, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99193, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99195, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99198, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99199, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99202, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(99667, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(99668, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(99669, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(99670, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(99671, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(99672, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(99673, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(99674, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(99675, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(99676, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(99677, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(99678, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(99679, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(99680, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(99681, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(99682, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(99683, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(99684, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(99685, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(99686, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(99687, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(99688, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(99689, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(99690, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(99691, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(99692, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(99693, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(99694, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(99695, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(99696, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(99712, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(99713, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(99714, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(99715, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(99716, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(99717, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(99718, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(99719, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(99720, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(99721, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(99722, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(99723, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(99724, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(99725, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(99726, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(99742, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(99743, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(99744, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(99745, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(99746, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(99747, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(99748, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(99749, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(99750, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(99751, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(99752, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(99753, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(99754, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(99755, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(99756, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(100950, {
    instanceEJ = 324,
    bossEJ = 693,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTJinbak",
    difficulty = "N",
  })
  Add(100951, {
    instanceEJ = 324,
    bossEJ = 693,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTJinbak",
    difficulty = "N",
  })
  Add(100952, {
    instanceEJ = 324,
    bossEJ = 693,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTJinbak",
    difficulty = "N",
  })
  Add(100953, {
    instanceEJ = 324,
    bossEJ = 693,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTJinbak",
    difficulty = "N",
  })
  Add(100954, {
    instanceEJ = 324,
    bossEJ = 693,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTJinbak",
    difficulty = "N",
  })
  Add(100955, {
    instanceEJ = 324,
    bossEJ = 738,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTVojak",
    difficulty = "N",
  })
  Add(100956, {
    instanceEJ = 324,
    bossEJ = 738,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTVojak",
    difficulty = "N",
  })
  Add(100957, {
    instanceEJ = 324,
    bossEJ = 738,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTVojak",
    difficulty = "N",
  })
  Add(100958, {
    instanceEJ = 324,
    bossEJ = 738,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTVojak",
    difficulty = "N",
  })
  Add(100959, {
    instanceEJ = 324,
    bossEJ = 738,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTVojak",
    difficulty = "N",
  })
  Add(100960, {
    instanceEJ = 324,
    bossEJ = 692,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTPavalak",
    difficulty = "N",
  })
  Add(100961, {
    instanceEJ = 324,
    bossEJ = 692,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTPavalak",
    difficulty = "N",
  })
  Add(100962, {
    instanceEJ = 324,
    bossEJ = 692,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTPavalak",
    difficulty = "N",
  })
  Add(100963, {
    instanceEJ = 324,
    bossEJ = 692,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTPavalak",
    difficulty = "N",
  })
  Add(100964, {
    instanceEJ = 324,
    bossEJ = 692,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTPavalak",
    difficulty = "N",
  })
  Add(100965, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "N",
  })
  Add(100967, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "N",
  })
  Add(100968, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "N",
  })
  Add(100969, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "N",
  })
  Add(100970, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "N",
  })
  Add(100971, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "N",
  })
  Add(100972, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "N",
  })
  Add(100973, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "N",
  })
  Add(100974, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "N",
  })
  Add(100975, {
    instanceEJ = 324,
    bossEJ = 727,
    instanceKey = "SiegeofNiuzaoTemple",
    bossKey = "NTNeronok",
    difficulty = "N",
  })
  Add(102292, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(102293, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(102294, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(102295, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(102296, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(102297, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(102298, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(102299, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(102300, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(102301, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(102302, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(102303, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(102304, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(102305, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(102306, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(102307, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(102308, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(102309, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(102310, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(102311, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(102615, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102617, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102618, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102620, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102621, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102623, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102624, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102627, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102630, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102631, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102638, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102639, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102640, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102641, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102642, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102644, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102645, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102646, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102647, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102648, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102649, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102651, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102654, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102656, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102657, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102660, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102662, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102663, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102664, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102665, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102666, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102668, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102669, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102670, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102674, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102675, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102677, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102678, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102679, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102683, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102684, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102686, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102687, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102688, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102691, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102692, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102694, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102695, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102696, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102698, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102701, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102702, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102704, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102705, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102707, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102708, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102709, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102711, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102716, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102719, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102722, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102723, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102724, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102725, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102729, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102730, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102732, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102733, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102735, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102736, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102737, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102739, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102742, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102745, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102746, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102748, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102749, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102752, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102753, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102754, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102755, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102756, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102757, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102758, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102760, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102761, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102762, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102764, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102765, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102767, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102768, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102769, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102770, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102771, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102772, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102773, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102774, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102775, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102778, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102780, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(102781, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103005, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103343, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103344, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103345, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103346, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103348, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103349, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103351, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103352, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103353, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103354, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103355, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103356, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103357, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103358, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103359, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103360, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103361, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103362, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103367, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103368, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103369, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103370, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103371, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103372, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103377, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103379, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103381, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103383, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103386, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103388, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103389, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103391, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103395, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103396, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103397, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103398, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103400, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103410, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103411, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103412, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103413, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103414, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103415, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103417, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103419, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103421, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103423, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103426, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103427, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103428, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103429, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103431, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103434, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103436, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103440, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103442, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103444, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103445, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103446, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103447, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103448, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103449, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103451, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103453, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103455, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103456, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103457, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103458, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103459, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103460, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103462, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103464, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103467, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103469, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103472, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103473, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103474, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103476, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103478, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103480, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103481, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103482, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103483, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103484, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103486, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103488, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103491, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103493, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103495, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103497, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103499, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103512, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103513, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103514, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103515, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103517, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103518, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103520, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103522, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103526, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103528, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(103649, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103726, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103727, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103728, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103729, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103730, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103731, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103732, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(103733, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103734, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103735, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103736, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103737, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103738, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103739, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103740, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103741, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103742, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103743, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103744, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103745, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103747, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103748, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103749, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103750, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(103751, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103752, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103753, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103754, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103755, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103756, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103757, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103758, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103759, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103760, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103761, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103762, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103763, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103764, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103765, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103766, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103767, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103768, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103769, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103770, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103771, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103772, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103773, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103774, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(103775, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103776, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103777, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103778, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103779, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103780, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103781, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103782, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103783, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103784, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103785, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103787, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103788, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103790, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103791, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103792, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(103793, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103794, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(103796, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103798, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103799, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103800, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103801, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103802, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103803, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103804, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103805, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103806, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103807, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103808, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(103809, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103810, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(103811, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103812, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103813, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103814, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(103815, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103816, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103817, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103818, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103819, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(103820, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103821, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(103822, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103823, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103824, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(103826, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103827, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103828, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(103829, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(103830, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103831, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103832, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103834, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103835, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103836, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103837, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103838, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103839, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103840, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103841, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103842, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103843, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103844, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(103845, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103846, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103847, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103848, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103849, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103850, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103851, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103852, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103853, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(103854, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103855, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103856, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103857, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103858, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103859, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103860, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103861, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103862, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103863, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103864, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103865, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103866, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103867, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103868, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103869, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(103870, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(103871, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103872, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(103873, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(103874, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(103875, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103876, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(103877, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103878, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(103879, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103880, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103881, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(103882, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103883, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "N",
  })
  Add(103884, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(103885, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103886, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(103887, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103888, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103889, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103890, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103891, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(103892, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103893, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103894, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103895, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103896, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(103898, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103899, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103900, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103901, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103902, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103904, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(103905, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103906, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103907, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "N",
  })
  Add(103908, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103909, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103910, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(103911, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103912, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103913, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(103914, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103915, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(103916, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103917, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103918, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103919, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(103920, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103921, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103922, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "N",
  })
  Add(103923, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103924, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "N",
  })
  Add(103925, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103926, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103927, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103928, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103929, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103930, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103931, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103932, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103933, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103934, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103935, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103936, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103937, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103938, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103939, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103940, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103941, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103942, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "N",
  })
  Add(103943, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "N",
  })
  Add(103944, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103945, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(103946, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(103947, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(103948, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(103949, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "N",
  })
  Add(103950, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103951, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103952, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103953, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103954, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103955, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103956, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(103957, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103958, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103959, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "N",
  })
  Add(103960, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(103961, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103962, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103963, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(103964, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103965, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103966, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "N",
  })
  Add(103967, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "N",
  })
  Add(103968, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(103969, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(103970, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "N",
  })
  Add(103971, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(103972, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(103973, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "N",
  })
  Add(103974, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104158, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(104162, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104163, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104165, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(104253, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104271, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(104272, {
    instanceEJ = 322,
    bossEJ = 857,
    instanceKey = "WorldBossesMoP",
    bossKey = "TheAugustCelestials",
    difficulty = "N",
  })
  Add(104273, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(104275, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(104308, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "N",
  })
  Add(104311, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104399, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104400, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104401, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104402, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104403, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104404, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104405, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104406, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104407, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104408, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104409, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(104411, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104412, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104413, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104414, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104415, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104416, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104417, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104418, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104419, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104420, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104421, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104422, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104423, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104424, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104425, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104426, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104427, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104428, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104429, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104430, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104431, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104432, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "H",
  })
  Add(104433, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104434, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104435, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104436, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104437, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104438, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104439, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104440, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104441, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104442, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104443, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104444, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104445, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104446, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104447, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104448, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104449, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104450, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104451, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104452, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104453, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "H",
  })
  Add(104454, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104455, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104456, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104457, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104458, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104459, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104460, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104461, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104462, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104463, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104464, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104465, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104466, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104467, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104468, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104469, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104470, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104471, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104472, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104473, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104474, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104475, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "H",
  })
  Add(104476, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104477, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104478, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104479, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104480, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104481, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104482, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104483, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104484, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104485, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "H",
  })
  Add(104486, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104487, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104488, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104489, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104490, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104491, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104492, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104493, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104494, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104495, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104496, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104497, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104498, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104499, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104500, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104501, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104502, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104503, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104504, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104505, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104506, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104507, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "H",
  })
  Add(104508, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104509, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104510, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104511, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104512, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104513, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104514, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104515, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104516, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104517, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104518, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104519, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104520, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104521, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104522, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104523, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104524, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104525, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104526, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104527, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104528, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104529, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "H",
  })
  Add(104530, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104531, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104532, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104533, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104534, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104535, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104536, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104537, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104538, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104539, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104540, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104541, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104542, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104543, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104544, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104545, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104546, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104547, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104548, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104549, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104550, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "H",
  })
  Add(104551, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104552, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104553, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104554, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104555, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104556, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104557, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104558, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104559, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104560, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104561, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "H",
  })
  Add(104562, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104563, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104564, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104565, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104566, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104567, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104568, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104569, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104570, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104571, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104572, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104573, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104574, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104575, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104576, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104577, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104578, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104579, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104580, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104581, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104582, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104583, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "H",
  })
  Add(104584, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104585, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104586, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104587, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104588, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104589, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104590, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104591, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104592, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104593, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104594, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104595, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104596, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104597, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104598, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104599, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104600, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104601, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104602, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104603, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104604, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "H",
  })
  Add(104605, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104606, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104607, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104608, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104609, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104610, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104611, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104612, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104613, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104614, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104615, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "H",
  })
  Add(104616, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104617, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104618, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104619, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104620, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104621, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104622, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104623, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104624, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104625, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104626, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "H",
  })
  Add(104627, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104628, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104629, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104630, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104631, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104632, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104633, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104634, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104635, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104636, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104637, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "H",
  })
  Add(104638, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104639, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104640, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104641, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104642, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104643, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104644, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104645, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104646, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104647, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104648, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104649, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104650, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104651, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104652, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104653, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104654, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104655, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104656, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104657, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104658, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104659, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(104660, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104661, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104662, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104663, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104664, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104665, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104666, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104667, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104668, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104669, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104670, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104671, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104672, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104673, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104674, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104675, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104676, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104677, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104678, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104679, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104680, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104681, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "F",
  })
  Add(104682, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104683, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104684, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104685, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104686, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104687, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104688, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104689, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104690, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104691, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104692, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104693, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104694, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104695, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104696, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104697, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104698, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104699, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104700, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104701, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104702, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "F",
  })
  Add(104703, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104704, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104705, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104706, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104707, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104708, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104709, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104710, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104711, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104712, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104713, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104714, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104715, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104716, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104717, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104718, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104719, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104720, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104721, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104722, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104723, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104724, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "F",
  })
  Add(104725, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(104726, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(104727, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(104728, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(104729, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(104730, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(104731, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(104732, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(104733, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(104734, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "F",
  })
  Add(104735, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104736, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104737, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104738, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104739, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104740, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104741, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104742, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104743, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104744, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104745, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104746, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104747, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104748, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104749, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104750, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104751, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104752, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104753, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104754, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104755, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104756, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "F",
  })
  Add(104757, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104758, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104759, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104760, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104761, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104762, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104763, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104764, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104765, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104766, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104767, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104768, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104769, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104770, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104771, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104772, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104773, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104774, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104775, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104776, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104777, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104778, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "F",
  })
  Add(104779, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104780, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104781, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104782, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104783, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104784, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104785, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104786, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104787, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104788, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104789, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104790, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104791, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104792, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104793, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104794, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104795, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104796, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104797, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104798, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104799, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "F",
  })
  Add(104800, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104801, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104802, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104803, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104804, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104805, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104806, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104807, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104808, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104809, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104810, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "F",
  })
  Add(104811, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104812, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104813, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104814, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104815, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104816, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104817, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104818, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104819, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104820, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104821, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104822, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104823, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104824, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104825, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104826, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104827, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104828, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104829, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104830, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104831, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104832, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "F",
  })
  Add(104833, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104834, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104835, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104836, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104837, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104838, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104839, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104840, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104841, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104842, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104843, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104844, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104845, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104846, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104847, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104848, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104849, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104850, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104851, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104852, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104853, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "F",
  })
  Add(104854, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104855, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104856, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104857, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104858, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104859, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104860, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104861, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104862, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104863, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104864, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "F",
  })
  Add(104865, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104866, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104867, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104868, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104869, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104870, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104871, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104872, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104873, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104874, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104875, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "F",
  })
  Add(104876, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104877, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104878, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104879, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104880, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104881, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104882, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104883, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104884, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104885, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104886, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "F",
  })
  Add(104887, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104888, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104889, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104890, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104891, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104892, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104893, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104894, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104896, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104897, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104898, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104899, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104900, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104901, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104902, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104903, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104904, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104905, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104906, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104907, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104908, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(104909, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104910, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104911, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104912, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104913, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104914, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104915, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104916, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104917, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104918, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104919, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104920, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104921, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104922, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104923, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104924, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104925, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104926, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104927, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104928, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104929, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104930, {
    instanceEJ = 369,
    bossEJ = 852,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOImmerseus",
    difficulty = "C",
  })
  Add(104931, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104932, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104933, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104934, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104935, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104936, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104937, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104938, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104939, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104940, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104941, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104942, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104943, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104944, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104945, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104946, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104947, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104948, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104949, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104950, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104951, {
    instanceEJ = 369,
    bossEJ = 849,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOFallenProtectors",
    difficulty = "C",
  })
  Add(104952, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104953, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104954, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104955, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104956, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104957, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104958, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104959, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104960, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104961, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104962, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104963, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104964, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104965, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104966, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104967, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104968, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104969, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104970, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104971, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104972, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104973, {
    instanceEJ = 369,
    bossEJ = 866,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONorushen",
    difficulty = "C",
  })
  Add(104974, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104975, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104976, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104977, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104978, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104979, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104980, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104981, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104982, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104983, {
    instanceEJ = 369,
    bossEJ = 867,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShaofPride",
    difficulty = "C",
  })
  Add(104984, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104985, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104986, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104987, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104988, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104989, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104990, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104991, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104992, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104993, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104994, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104995, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104996, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104997, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104998, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(104999, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(105000, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(105001, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(105002, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(105003, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(105004, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(105005, {
    instanceEJ = 369,
    bossEJ = 868,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGalakras",
    difficulty = "C",
  })
  Add(105006, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105007, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105008, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105009, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105010, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105011, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105012, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105013, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105014, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105015, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105016, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105017, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105018, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105019, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105020, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105021, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105022, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105023, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105024, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105025, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105026, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105027, {
    instanceEJ = 369,
    bossEJ = 864,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOIronJuggernaut",
    difficulty = "C",
  })
  Add(105028, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105029, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105030, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105031, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105032, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105033, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105034, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105035, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105036, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105037, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105038, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105039, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105040, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105041, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105042, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105043, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105044, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105045, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105046, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105047, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105048, {
    instanceEJ = 369,
    bossEJ = 856,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoODarkShaman",
    difficulty = "C",
  })
  Add(105049, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105050, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105051, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105052, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105053, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105054, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105055, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105056, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105057, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105058, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105059, {
    instanceEJ = 369,
    bossEJ = 850,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoONazgrim",
    difficulty = "C",
  })
  Add(105060, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105061, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105062, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105063, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105064, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105065, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105066, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105067, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105068, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105069, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105070, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105071, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105072, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105073, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105074, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105075, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105076, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105077, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105078, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105079, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105080, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105081, {
    instanceEJ = 369,
    bossEJ = 846,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOMalkorok",
    difficulty = "C",
  })
  Add(105082, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105083, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105084, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105085, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105086, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105087, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105088, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105089, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105090, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105091, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105092, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105093, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105094, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105095, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105096, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105097, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105098, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105099, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105100, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105101, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105102, {
    instanceEJ = 369,
    bossEJ = 870,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOSpoils",
    difficulty = "C",
  })
  Add(105103, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105104, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105105, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105106, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105107, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105108, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105109, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105110, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105111, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105112, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105113, {
    instanceEJ = 369,
    bossEJ = 851,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOThok",
    difficulty = "C",
  })
  Add(105114, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105115, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105116, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105117, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105118, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105119, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105120, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105121, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105122, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105123, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105124, {
    instanceEJ = 369,
    bossEJ = 865,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOBlackfuse",
    difficulty = "C",
  })
  Add(105125, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105126, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105127, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105128, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105129, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105130, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105131, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105132, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105133, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105134, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105135, {
    instanceEJ = 369,
    bossEJ = 853,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOParagons",
    difficulty = "C",
  })
  Add(105136, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105137, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105138, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105139, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105140, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105141, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105142, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105143, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105145, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105146, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105147, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105148, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105149, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105150, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105151, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105152, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105153, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105154, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105155, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105156, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105157, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105676, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(105683, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105684, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105685, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105686, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105687, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105688, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105689, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105690, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105691, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105692, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105693, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105713, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "F",
  })
  Add(105714, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "F",
  })
  Add(105741, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(105742, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(105743, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(105744, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(105745, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(105746, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(105747, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(105748, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "N",
  })
  Add(105754, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105755, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105756, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105757, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105758, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105759, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105760, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105761, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105762, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105763, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105764, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105765, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105766, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105767, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105768, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105769, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105770, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105771, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105772, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105773, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105774, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105775, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105776, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105777, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105778, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105779, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105780, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105781, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105782, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105783, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105784, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105785, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105786, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105787, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105788, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105789, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105790, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105791, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105792, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105793, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105794, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105795, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105796, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105797, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105798, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105799, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105800, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105801, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105802, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105803, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105804, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105805, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105806, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105807, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105808, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105809, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105810, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105811, {
    instanceEJ = 322,
    bossEJ = 861,
    instanceKey = "WorldBossesMoP",
    bossKey = "Ordos",
    difficulty = "N",
  })
  Add(105812, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105813, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105814, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105815, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105816, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105817, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105818, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105819, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105820, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105821, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105822, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105823, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105824, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105825, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "C",
  })
  Add(105826, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105827, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105828, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105829, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105830, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105831, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105832, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105833, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105834, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105835, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105836, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105837, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105838, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105839, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOTrash",
    difficulty = "F",
  })
  Add(105840, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105841, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105842, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105843, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105844, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105845, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105846, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105847, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105848, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105849, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105850, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105851, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105852, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105853, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105856, {
    instanceEJ = 369,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOShared",
    difficulty = "H",
  })
  Add(105857, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(105858, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(105859, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "N",
  })
  Add(105860, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105861, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105862, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "C",
  })
  Add(105863, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(105864, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(105865, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "F",
  })
  Add(105866, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105867, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(105868, {
    instanceEJ = 369,
    bossEJ = 869,
    instanceKey = "SiegeofOrgrimmar",
    bossKey = "SoOGarrosh",
    difficulty = "H",
  })
  Add(810660, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
  })
  Add(811400, {
    instanceEJ = 302,
    bossEJ = 670,
    instanceKey = "StormstoutBrewery",
    bossKey = "BreweryYanZhu",
  })
end
