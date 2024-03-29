--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

    This file is part of Necrosis LdC.

    Necrosis LdC is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Necrosis LdC is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Necrosis LdC; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--]]


------------------------------------------------------------------------------------------------------
-- Necrosis LdC
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic) 
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- Version $LastChangedDate: 2009-12-10 17:09:53 +1100 (Thu, 10 Dec 2009) $
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- GERMAN VERSION TEXTS --
------------------------------------------------

function Localization.deDE()

	Necrosis.HealthstoneCooldown = "Gesundheitsstein Cooldown"
	
	Necrosis.Localize = {
		["Utilisation"] = "Use",
		["Echange"] = "Trade",
	}

	-- Necrosis.TooltipData = {
	-- 	["Main"] = {
	-- 		Label = "|c00FFFFFFNecrosis|r",
	-- 		Stone = {
	-- 			[true] = "Ja";
	-- 			[false] = "Nein";
	-- 		},
	-- 		Hellspawn = {
	-- 			[true] = "An";
	-- 			[false] = "Aus";
	-- 		},
	-- 		["Soulshard"] = "Seelensplitter : ",
	-- 		["InfernalStone"] = "H\195\182llensteine : ",
	-- 		["DemoniacStone"] = "D\195\164monen-Statuetten : ",
	-- 		["Soulstone"] = "\nSeelenstein : ",
	-- 		["Healthstone"] = "Gesundheitsstein : ",
	-- 		["Spellstone"] = "Zauberstein: ",
	-- 		["Firestone"] = "Feuerstein : ",
	-- 		["CurrentDemon"] = "D\195\164mon : ",
	-- 		["EnslavedDemon"] = "D\195\164mon : Versklavter",
	-- 		["NoCurrentDemon"] = "D\195\164mon : Keiner",
	-- 	},
	-- 	["Soulstone"] = {
	-- 		Text = {"Rechte Maustaste zum herstellen","Linke Maustaste zum benutzten","Benutzt\nRechte Maustaste zum wiederherstellen","Warten"},
	-- 		Ritual = "|c00FFFFFFShift+Click to cast the Ritual of Summoning|r"
	-- 	},
	-- 	["Healthstone"] = {
	-- 		Text = {"Rechte Maustaste zum herstellen","Linke Maustaste zum benutzten"},
	-- 		Text2 = "Mittlerer Maustaste oder Strg+rechte Maustaste zum handeln",
	-- 		Ritual = "|c00FFFFFFShift+Klick um das Ritual der Seelen zu zaubern|r"
	-- 	},
	-- 	["Spellstone"] = {
	-- 		Text = {"Rechte Maustaste zum herstellen","Im Inventar\nLinke Maustaste zum benutzten","Benutzt", "Benutzt\n Maustaste zum herstellen"}
	-- 	},
	-- 	["Firestone"] = {
	-- 		Text = {"Rechte Maustaste zum herstellen","Im Inventar\nLinke Maustaste zum benutzten","Benutzt", "Benutzt\n Maustaste zum herstellen"}
	-- 	},
	-- 	["SpellTimer"] = {
	-- 		Label = "|c00FFFFFFSpruchdauer|r",
	-- 		Text = "Aktive Spr\195\188che auf dem Ziel\n",
	-- 		Right = "Rechtsklick f\195\188r Ruhestein nach "
	-- 	},
	-- 	["ShadowTrance"] = {
	-- 		Label = "|c00FFFFFFSchatten Trance|r"
	-- 	},
	-- 	["Backlash"] = {
	-- 		Label = "|c00FFFFFFHeimzahlen|r"
	-- 	},
	-- 	["Banish"] = {
	-- 		Text = "Rechtsklick f\195\188r Rang 1"
	-- 	},
	-- 	["Imp"] = {
	-- 		Label = "|c00FFFFFFWichtel|r"
	-- 	},
	-- 	["Voidwalker"] = {
	-- 		Label = "|c00FFFFFFLeerwandler|r"
	-- 	},
	-- 	["Succubus"] = {
	-- 		Label = "|c00FFFFFFSukkubus|r"
	-- 	},
	-- 	["Felhunter"] = {
	-- 		Label = "|c00FFFFFFTeufelsj\195\164ger|r"
	-- 	},
	-- 	["Felguard"] = {
	-- 		Label = "|c00FFFFFFTeufelswache|r"
	-- 	},
	-- 	["Infernal"] = {
	-- 		Label = "|c00FFFFFFH\195\182llenbestie|r"
	-- 	},
	-- 	["Doomguard"] = {
	-- 		Label = "|c00FFFFFFVerdammniswache|r"
	-- 	},
	-- 	["Mount"] = {
	-- 		Label = "|c00FFFFFFMount|r",
	-- 		Text = "Rechtsklick f\195\188r Rang 1"
	-- 	},
	-- 	["BuffMenu"] = {
	-- 		Label = "|c00FFFFFFSpruch Men\195\188|r",
	-- 		Text = "Rechtsklick um das Men\195\188 zu \195\182ffnen",
	-- 		Text2 = "Automatischer Modus: Wird beim verlassen des Kampfes geschlossen",
	-- 	},
	-- 	["PetMenu"] = {
	-- 		Label = "|c00FFFFFFD\195\164monen Men\195\188|r",
	-- 		Text = "Rechtsklick um das Men\195\188 zu \195\182ffnen",
	-- 		Text2 = "Automatischer Modus: Wird beim verlassen des Kampfes geschlossen",
	-- 	},
	-- 	["CurseMenu"] = {
	-- 		Label = "|c00FFFFFFFluch Men\195\188|r",
	-- 		Text = "Rechtsklick um das Men\195\188 zu \195\182ffnen",
	-- 		Text2 = "Automatischer Modus: Wird beim verlassen des Kampfes geschlossen",
	-- 	},
	-- 	["DominationCooldown"] = "Mit der rechten Taste klicken f\195\188r eine schnelle Beschw\195\182rung",
	-- }


	Necrosis.Sound = {
		["Fear"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\Fear-En.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\SoulstoneEnd-En.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\EnslaveDemonEnd-En.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\ShadowTrance-En.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\Backlash-Fr.mp3",
	}


	Necrosis.ProcText = {
		["ShadowTrance"] = "<white>S<lightPurple1>c<lightPurple2>h<purple>a<darkPurple1>tt<darkPurple2>en<darkPurple1>tr<purple>a<lightPurple2>n<lightPurple1>c<white>e",
		["Backlash"] = "<white>H<lightPurple1>e<lightPurple2>i<purple>m<darkPurple1>z<darkPurple2>a<darkPurple1>h<purple>l<lightPurple2>e<lightPurple1>n"
	}

	Necrosis.ChatMessage = {
		["Bag"] = {
			["FullPrefix"] = "Dein ",
			["FullSuffix"] = " ist voll !",
			["FullDestroySuffix"] = " ist voll; folgende Seelensplitter werden zerst\195\182rt !",
		},
		["Interface"] = {
			["Welcome"] = "<white>/necrosis f\195\188r das Einstellungsmen\195\188.",
			["TooltipOn"] = "Tooltips an" ,
			["TooltipOff"] = "Tooltips aus",
			["MessageOn"] = "Chat Nachrichten an",
			["MessageOff"] = "Chat Nachrichten aus",
			["DefaultConfig"] = "<lightYellow>Standard-Einstellungen geladen.",
			["UserConfig"] = "<lightYellow>Einstellungen geladen."
		},
		["Help"] = {
			"/necrosis <lightOrange>recall<white> -- <lightBlue>Zentriere Necrosis und alle Buttons in der Mitte des Bildschirms",
			"/necrosis <lightOrange>reset<white> -- <lightBlue>Setzt Necrosis komplett auf Grundeinstellungen zur\195\188ck",
		},
		["Information"] = {
			["FearProtect"] = "Dein Ziel hat Fear-Protection!!!",
			["EnslaveBreak"] = "Dein D\195\164mon hat seine Ketten gebrochen...",
			["SoulstoneEnd"] = "<lightYellow>Dein Seelenstein ist ausgelaufen."
		}
	}


	Necrosis.Translation.StoneRank = {
		["Minor"] = "schwach",
		["Major"] = "gering",
		["Lesser"] = "gro/195/159",
		["Greater"] = "erheblich"
	}
	-- Gestion XML - Menu de configuration
	Necrosis.Config.Panel = {
		"Nachrichten Einstellungen",
		"Sph\195\164re Einstellungen",
		"Buttons Einstellungen",
		"Men\195\188s Einstellungen",
		"Timer Einstellungen",
		"Sonstiges"
	}

	Necrosis.Config.Messages = {
		["Position"] = "<- Hier werden Nachrichten von Necrosis erscheinen ->",
		["Afficher les bulles d'aide"] = "Zeige Tooltips",
		["Afficher les messages dans la zone systeme"] = "Zeige Nachrichten von Necrosis im System Frame",
		["Activer les messages aleatoires de TP et de Rez"] = "Zuf\195\164llige Spr\195\188che",
		["Utiliser des messages courts"] = "Benutzte kurze Nachrichten",
		["Activer egalement les messages pour les Demons"] = "Zuf\195\164llige Spr\195\188che f\195\188r D\195\164monen auch",
		["Activer egalement les messages pour les Montures"] = "Zuf\195\164llige Spr\195\188che f\195\188r Mount auch",
		["Activer egalement les messages pour le Rituel des ames"] = "Zuf\195\164llige Spr\195\188che f\195\188r das Ritual der Seelen aktivieren",
		["Activer les sons"] = "Aktiviere Sounds",
		["Alerter quand la cible est insensible a la peur"] = "Warnung, wenn Ziel immun gegen\195\188ber Fear ist",
		["Alerter quand la cible peut etre banie ou asservie"] = "Warnung, wenn ein Ziel verbannt\\versklavt werden kann",
		["M'alerter quand j'entre en Transe"] = "Warnung, wenn Trance eintritt"
	}

	Necrosis.Config.Sphere = {
		["Taille de la sphere"] = "Gr\195\182\195\159e der Sph\195\164re",
		["Skin de la pierre Necrosis"] = "Aussehen der Necrosis Sph\195\164re",
		["Evenement montre par la sphere"] = "Anzeige in der grafischen Sph\195\164re",
		["Sort caste par la sphere"] = "Zauber der durch Klick auf die\nSph\195\164re gewirkt wird",
		["Afficher le compteur numerique"] = "Zeige die gew\195\164hlte Anzeige in der Sph\195\164re",
		["Type de compteur numerique"] = "Anzeige w\195\164hlen:"
	}
	Necrosis.Config.Sphere.Colour = {
		["Rose"] 		= "Pink",
		["Bleu"] 		= "Blau",
		["Orange"] 		= "Orange",
		["Turquoise"] 	= "T\195\188rkis",
		["Violet"] 		= "Lila",
		["666"] 		= "666",
		["X"] 			= "X"
	}
	Necrosis.Config.Sphere.Count = {
		["Soulshards"] 	= "Seelensplitter",
		["DemonStones"] = "D\195\164monenen-Beschw\195\182rungs-Steine",
		["RezTimer"] 	= "Wiederbelebungs-Timer",
		["Mana"] 		= "Mana",
		["Health"] 		= "Gesundheit"
	}

	Necrosis.Config.Buttons = {
		["Rotation des boutons"] = "Rotation der Buttons",
		["Fixer les boutons autour de la sphere"] = "Fixiere die Buttons um die Sph\195\164re",
		["Utiliser mes propres montures"] = "Use my own mounts",
		["Choix des boutons a afficher"] = "Selection of buttons to be shown",
		["Monture - Clic gauche"] = "Left click",
		["Monture - Clic droit"] = "Right click",
	}
	Necrosis.Config.Buttons.Name = {
		"Zeige den Feuerstein Button",
		"Zeige den Zauberstein Button",
		"Zeige den Gesundheitsstein Button",
		"Zeige den Seelenstein Button",
		"Zeige den Spruch Men\195\188 Button",
		"Zeige den Mount Button",
		"Zeige den D\195\164monen Men\195\188 Button",
		"Zeige den Fluch Men\195\188 Button",
	}

	Necrosis.Config.Menus = {
		["Options Generales"] = "Allgemeine Einstellungen",
		["Menu des Buffs"] = "Spruch Men\195\188",
		["Menu des Demons"] = "D\195\164monen Men\195\188",
		["Menu des Maledictions"] = "Fluch Men\195\188",
		["Afficher les menus en permanence"] = "Zeige die Men\195\188s permanent",
		["Afficher automatiquement les menus en combat"] = "Men\195\188s im Kampf automatisch \195\182ffnen",
		["Fermer le menu apres un clic sur un de ses elements"] = "Schließe das Men\195\188, sobald ein Button geklickt wurde",
		["Orientation du menu"] = "Ausrichtung des Men\195\188s",
		["Changer la symetrie verticale des boutons"] = "Ver\195\164ndert die Vertikale Symmetrie der Buttons",
		["Taille du bouton Banir"] = "Gr\195\182\195\159e des Verbannen Button",
	}
	Necrosis.Config.Menus.Orientation = {
		"Horizontal",
		"Aufw\195\164rts",
		"Abw\195\164rts"
	}

	Necrosis.Config.Timers = {
		["Type de timers"] = "Timer Typ",
		["Afficher le bouton des timers"] = "Zeige den Timer Button",
		["Afficher les timers sur la gauche du bouton"] = "Zeige die Timer auf der linken Seite des Knopfes",
		["Afficher les timers de bas en haut"] = "Neue Timer oberhalb der bestehenden Timer anzeigen",
	}
	Necrosis.Config.Timers.Type = {
		Disabled	= "Kein",
		Graphical	= "Graphische",
		Textual		= "Texttimer"
	}

	Necrosis.Config.Misc = {
		["Deplace les fragments"] = "Lege die Seelensplitter in die ausgew\195\164hlte Tasche.",
		["Detruit les fragments si le sac plein"] = "Zerst\195\182re neue Seelensplitter,\nwenn die Tasche voll ist.",
		["Choix du sac contenant les fragments"] = "W\195\164hle die Seelensplitter-Tasche",
		["Nombre maximum de fragments a conserver"] = "Maximale Anzahl der zu behaltenden Splitter:",
		["Verrouiller Necrosis sur l'interface"] = "Sperre Necrosis",
		["Afficher les boutons caches"] = "Zeige versteckte Buttons um sie zu verschieben",
		["Taille des boutons caches"] = "Gr\195\182\195\159e des versteckten Buttons"
	}

	-- Chat messages
	Necrosis.Speech.TP = {
		[1] = {
			"<after>Arcanum Taxi Cab ! Ich beschw\195\182re <target>, bitte klicke auf das Portal.",
		},
		[2] = {
			"<after>Willkommen an Bord, <target>, du fliegst mit ~Sukkubus Air Lines~ zu <player>...",
			"<after>Die Stewardessen und ihre Peitschen werden Dir w\195\164hrend der Reise zur Verf\195\188gung stehen!",
		},
		[3] = {
			"<after>Wenn Du das Portal klicken w\195\188rdest, wird jemand mit dem Namen <target> erscheinen, und Deinen Job f\195\188r Dich tun !",
		},
		[4] = {
			"<after>Wenn Du nicht m\195\182chtest, dass eine auf dem Boden kriechende, schleimige und einfach gr\195\164ssliche Kreatur aus diesem Portal kommt,",
			"<after>klicke drauf und hilf <target>, so schnell wie m\195\182glich einen Weg zur H\195\182lle zu finden!",
		},
	}

	Necrosis.Speech.Rez = {
		[1] = {
			"<after>Solltet Ihr einen Massenselbstmord erw\195\164gen, denkt daran dass <target> sich nun selbst wiederbeleben kann. Alles wird gut werden, auf in den Kampf !",
		},
		[2] = {
			"<after><target> kann afk gehen um eine Tasse Kaffee oder so zu trinken, denn er wird Dank dieses Seelensteins in der Lage sein, unseren Tod zu \195\188berleben",
		},
	}

	Necrosis.Speech.RoS = {
		[1] = {
			"Let us use the souls of our fallen enemies to give us vitality",
		},
		[2] = {
			"My soul, their soul, doesn't matter, just take one",
		},
	}

	Necrosis.Speech.ShortMessage = {
		{{"<after>--> <target> hat nun einen Seelenstein aktiv f\195\188r 30 Minuten <--"}},
		{{"<after><Portal> Ich beschw\195\182re <target>, bitte klickt auf das Tor <Portal>"}},
		{{"Summoning a Ritual of Souls"}},
	}

	Necrosis.Speech.Demon = {
		-- Wichtel
		[1] = {
			[1] = {
				"Na mein kleiner, b\195\182ser Wichtel, nun h\195\182r auf rumzuzicken und hilf endlich! UND DAS IST EIN BEFEHL !",
			},
			[2] = {
				"<pet> ! SCHWING DIE BEINE ! JETZT SOFORT !",
			},
		},
		-- Leerwandler
		[2] = {
			[1] = {
				"Huuuch, anscheinend brauch ich einen Idioten, der f\195\188r mich die R\195\188be hinh\195\164lt...",
				"<pet>, hilf mir !",
			},
		},
		-- Sukkubus
		[3] = {
			[1] = {
				"<pet>, Baby, sei ein Schatzi und hilf mir!",
			},
		},
		-- Teufelsj�ger
		[4] = {
			[1] = {
				"<pet> ! <pet> ! Bei Fu\195\159, mein Guter, bei Fu\195\159 ! <pet> !",
			},
		},
		-- Felguard
		[5] = {
			[1] = {
				"<emote> is concentrating hard on Demoniac knowledge...",
				"I'll give you a soul if you come to me, Felguard ! Please hear my command !",
				"<after>Obey now, <pet> !",
				"<after><emote>looks in a bag, then throws a mysterious shard at <pet>",
				"<sacrifice>Please return in the Limbs you are from, Demon, and give me your power in exchange !"
			},
		},
		-- S�tze f�r die erste Beschw�rung : Wenn Necrosis den Namen Deines D�mons noch nicht kennt
		[6] = {
			[1] = {
				"Angeln ? Oh jaaa, ich liebe Angeln, schau !",
				"Ich schlie\195\159e meine Augen, dann bewege ich meine Finger in etwa so... Und voila ! Ja, aber sicher, es ist ein Fisch, ich schw\195\182re es Dir !",
			},
			[2] = {
				"Nichtsdestotrotz hasse ich Euch alle ! Ich brauche Euch nicht, ich habe Freunde.... M\195\164chtige Freunde !",
				"KOMM ZU MIR, KREATUR, DIE DU KOMMST AUS DER H\195\150LLE UND ENDLOSEN ALPTR\195\132UMEN !",
			},
		},
		-- Spr�che zur Beschw�rung des Mounts
		[7] = {
			[1] = {
				"Hey, ich bin sp\195\164t dran ! Ich hoffe ich finde ein Pferd das rennt wie ein ge\195\182lter Blitz !",
			},
			[2] = {
				"Ich beschw\195\182re ein Reittier, das einem Alptraum entspringt!",
				"AH AHA HA HA AH AH !",
			},
		},
	}

end


-- Besondere Zeichen :
-- � = \195\169 ---- � = \195\168
-- � = \195\160 ---- � = \195\162
-- � = \195\180 ---- � = \195\170
-- � = \195\187 ---- � = \195\164
-- � = \195\132 ---- � = \195\182
-- � = \195\150 ---- � = \195\188
-- � = \195\156 ---- � = \195\159
-- � = \195\167 ---- � = \195\174
