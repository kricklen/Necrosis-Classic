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
-- Version $LastChangedDate: 2010-08-04 12:04:27 +1000 (Wed, 04 Aug 2010) $
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- VERSION FRANCAISE DES TEXTES --
------------------------------------------------

function Localization.frFR()

	Necrosis.HealthstoneCooldown = "Temps de recharge Pierre de soins"
	
	Necrosis.Localize = {
		["Utilisation"] = "Utilisation",
		["Echange"] = "Echange",
	}

	-- Necrosis.TooltipData = {
	-- 	["Main"] = {
	-- 		Label = "|c00FFFFFFNecrosis|r",
	-- 		Stone = {
	-- 			[true] = "Oui";
	-- 			[false] = "Non";
	-- 		},
	-- 		Hellspawn = {
	-- 			[true] = "On";
	-- 			[false] = "Off";
	-- 		},
	-- 		["Soulshard"] = "Fragment(s) d'\195\162me : ",
	-- 		["InfernalStone"] = "Pierre(s) infernale(s) : ",
	-- 		["DemoniacStone"] = "Pierre(s) d\195\169moniaque(s) : ",
	-- 		["Soulstone"] = "\nPierre d'\195\162me : ",
	-- 		["Healthstone"] = "Pierre de soins : ",
	-- 		["Spellstone"] = "Pierre de sort : ",
	-- 		["Firestone"] = "Pierre de feu : ",
	-- 		["CurrentDemon"] = "D\195\169mon : ",
	-- 		["EnslavedDemon"] = "D\195\169mon : Asservi",
	-- 		["NoCurrentDemon"] = "D\195\169mon : Aucun",
	-- 	},
	-- 	["Soulstone"] = {
	-- 		Text = {"Clic droit pour cr\195\169er","Clic gauche pour utiliser","Utilis\195\169e\nClic droit pour recr\195\169er","En attente"},
	-- 		Ritual = "|c00FFFFFFShift+Clic pour le rituel d'invocation|r"
	-- 	},
	-- 	["Healthstone"] = {
	-- 		Text = {"Clic droit pour cr\195\169er","Clic gauche pour utiliser"},
	-- 		Text2 = "Clic du milieu ou Ctrl+clic gauche pour \195\169changer",
	-- 		Ritual = "|c00FFFFFFShift+Clic pour le rituel des \195\162mes|r"
	-- 	},
	-- 	["Spellstone"] = {
	-- 		Text = {"Clic droit pour cr\195\169er","En inventaire\nClic gauche pour utiliser","Utilis\195\169e", "Utilis\195\169e\nClic pour cr\195\169er"}
	-- 	},
	-- 	["Firestone"] = {
	-- 		Text = {"Clic droit pour cr\195\169er","En inventaire\nClic gauche pour utiliser","Utilis\195\169e", "Utilis\195\169e\nClic pour cr\195\169er"}
	-- 	},
	-- 	["SpellTimer"] = {
	-- 		Label = "|c00FFFFFFDur\195\169e des sorts|r",
	-- 		Text = "Sorts actifs sur la cible",
	-- 		Right = "Clic droit pour pierre de foyer vers "
	-- 	},
	-- 	["ShadowTrance"] = {
	-- 		Label = "|c00FFFFFFTranse de l'ombre|r"
	-- 	},
	-- 	["Backlash"] = {
	-- 		Label = "|c00FFFFFFContrecoup|r"
	-- 	},
	-- 	["Banish"] = {
	-- 		Text = "Clic droit pour Rang 1"
	-- 	},
	-- 	["Imp"] = {
	-- 		Label = "|c00FFFFFFDiablotin|r"
	-- 	},
	-- 	["Voidwalker"] = {
	-- 		Label = "|c00FFFFFFMarcheur \195\169th\195\169r\195\169|r"
	-- 	},
	-- 	["Succubus"] = {
	-- 		Label = "|c00FFFFFFSuccube|r"
	-- 	},
	-- 	["Felhunter"] = {
	-- 		Label = "|c00FFFFFFChasseur corrompu|r"
	-- 	},
	-- 	["Felguard"] = {
	-- 		Label = "|c00FFFFFFGangregarde|r"
	-- 	},
	-- 	["Infernal"] = {
	-- 		Label = "|c00FFFFFFInfernal|r"
	-- 	},
	-- 	["Doomguard"] = {
	-- 		Label = "|c00FFFFFFGarde funeste|r"
	-- 	},
	-- 	["Mount"] = {
	-- 		Label = "|c00FFFFFFMonture|r",
	-- 		Text = "Clic droit pour Rang 1"
	-- 	},
	-- 	["BuffMenu"] = {
	-- 		Label = "|c00FFFFFFMenu des sorts|r",
	-- 		Text = "Clic droit pour laisser ouvert",
	-- 		Text2 = "Mode automatique : Fermeture \195\160 la fin du combat",
	-- 	},
	-- 	["PetMenu"] = {
	-- 		Label = "|c00FFFFFFMenu des d\195\169mons|r",
	-- 		Text = "Clic droit pour laisser ouvert",
	-- 		Text2 = "Mode automatique : Fermeture \195\160 la fin du combat",
	-- 	},
	-- 	["CurseMenu"] = {
	-- 		Label = "|c00FFFFFFMenu des mal\195\169dictions|r",
	-- 		Text = "Clic droit pour laisser ouvert",
	-- 		Text2 = "Mode automatique : Fermeture \195\160 la fin du combat",
	-- 	},
	-- 	["DominationCooldown"] = "Clic droit pour invocation rapide",
	-- }

	Necrosis.Sound = {
		["Fear"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\Fear-Fr.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\SoulstoneEnd-Fr.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\EnslaveDemonEnd-Fr.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\ShadowTrance-Fr.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\Backlash-Fr.mp3",
	}

	Necrosis.ProcText = {
		["ShadowTrance"] = "<white>T<lightPurple1>r<lightPurple2>a<purple>n<darkPurple1>s<darkPurple2>e d<darkPurple1>e l<purple>'<lightPurple2>o<lightPurple1>m<white>b<lightPurple1>r<lightPurple2>e";
		["Backlash"] = "<white>C<lightPurple1>o<lightPurple2>n<purple>t<darkPurple1>r<darkPurple2>e<darkPurple1>c<purple>o<lightPurple2>u<lightPurple1>p"
	}


	Necrosis.ChatMessage = {
		["Bag"] = {
			["FullPrefix"] = "Votre ",
			["FullSuffix"] = " est plein !",
			["FullDestroySuffix"] = " est plein ; Les prochains fragments seront d\195\169truits !",
		},
		["Interface"] = {
			["Welcome"] = "<white>/necrosis pour les options !",
			["TooltipOn"] = "Bulles d'aide activ\195\169es" ,
			["TooltipOff"] = "Bulles d'aide d\195\169sactiv\195\169es",
			["MessageOn"] = "Messages Pierre d'\195\162me et Invocation de joueur activ\195\169s",
			["MessageOff"] = "Messages Pierre d'\195\162me et Invocation de joueur d\195\169sactiv\195\169s",
			["DefaultConfig"] = "<lightYellow>Configuration par d\195\169faut charg\195\169e.",
			["UserConfig"] = "<lightYellow>Configuration charg\195\169e"
		},
		["Help"] = {
			"/necrosis <lightOrange>recall<white> -- <lightBlue>Centre Necrosis et tous les boutons au milieu de l'\195\169cran",
			"/necrosis <lightOrange>reset<white> -- <lightBlue>R\195\169initialise totalement Necrosis",
		},
		["Information"] = {
			["FearProtect"] = "La cible est prot\195\169g\195\169e contre la peur !!!!",
			["EnslaveBreak"] = "Votre D\195\169mon a bris\195\169 ses cha\195\174nes...",
			["SoulstoneEnd"] = "<lightYellow>Votre Pierre d'\195\162me vient de s'\195\169teindre."
		}
	}


	-- Menus de configuration
	Necrosis.Config.Panel = {
		"Configuration des messages",
		"Configuration de la sph\195\168re",
		"Configuration des boutons",
		"Configuration des menus",
		"Configuration des timers",
		"Divers"
	}

	Necrosis.Config.Messages = {
		["Position"] = "<- Position des messages systeme Necrosis ->",
		["Afficher les bulles d'aide"] = "Afficher les bulles d'aide",
		["Afficher les messages dans la zone systeme"] = "Afficher les messages de Necrosis dans la zone syst\195\168me",
		["Activer les messages aleatoires de TP et de Rez"] = "Activer les messages al\195\169atoires de TP et de Rez",
		["Utiliser des messages courts"] = "Utiliser des messages courts",
		["Activer egalement les messages pour les Demons"] = "Activer \195\169galement les messages pour les D\195\169mons",
		["Activer egalement les messages pour les Montures"] = "Activer \195\169galement les messages pour les Montures",
		["Activer egalement les messages pour le Rituel des ames"] = "Activer \195\169galement les messages pour le Rituel des \195\162mes",
		["Activer les sons"] = "Activer les sons",
		["Alerter quand la cible est insensible a la peur"] = "Alerter quand la cible est insensible \195\160 la peur",
		["Alerter quand la cible peut etre banie ou asservie"] = "Alerter quand la cible peut \195\170tre banie ou asservie",
		["M'alerter quand j'entre en Transe"] = "M'alerter quand j'entre en Transe"
	}

	Necrosis.Config.Sphere = {
		["Taille de la sphere"] = "Taille de la sph\195\168re",
		["Skin de la pierre Necrosis"] = "Skin de la sph\195\168re",
		["Evenement montre par la sphere"] = "Ev\195\168nement montr\195\169 par la sph\195\168re",
		["Sort caste par la sphere"] = "Sort cast\195\169 par la sph\195\168re",
		["Afficher le compteur numerique"] = "Afficher le compteur num\195\169rique",
		["Type de compteur numerique"] = "Type de compteur num\195\169rique"
	}
	Necrosis.Config.Sphere.Colour = {
		["Rose"] 		= "Rose",
		["Bleu"] 		= "Bleu",
		["Orange"] 		= "Orange",
		["Turquoise"] 	= "Turquoise",
		["Violet"] 		= "Violet",
		["666"] 		= "666",
		["X"] 			= "X"
	}
	Necrosis.Config.Sphere.Count = {
		["Soulshards"] 	= "Fragments d'\195\162me",
		["DemonStones"] = "Pierres d'invocations",
		["RezTimer"] 	= "Timer de Rez",
		["Mana"] 		= "Mana",
		["Health"] 		= "Sant\195\169"
	}

	Necrosis.Config.Buttons = {
		["Rotation des boutons"] = "Rotation des boutons",
		["Fixer les boutons autour de la sphere"] = "Fixer les boutons autour de la sph\195\168re",
		["Utiliser mes propres montures"] = "Utiliser mes propres montures",
		["Choix des boutons a afficher"] = "Choix des boutons \195\160 afficher",
		["Monture - Clic gauche"] = "Clic gauche",
		["Monture - Clic droit"] = "Clic droit",
	}
	Necrosis.Config.Buttons.Name = {
		"Afficher le bouton des Pierres de feu",
		"Afficher le bouton des Pierres de sort",
		"Afficher le bouton des Pierres de soin",
		"Afficher le bouton des Pierres d'\195\162me",
		"Afficher le bouton des sorts",
		"Afficher le bouton de la Monture",
		"Afficher le bouton d'invocation des D\195\169mons",
		"Afficher le bouton des Mal\195\169dictions",
		"Afficher le bouton de M\195\169tamorphe",
	}

	Necrosis.Config.Menus = {
		["Options Generales"] = "Options G\195\169n\195\169rales",
		["Menu des Buffs"] = "Menu des sorts",
		["Menu des Demons"] = "Menu des D\195\169mons",
		["Menu des Maledictions"] = "Menu des Mal\195\169dictions",
		["Afficher les menus en permanence"] = "Afficher les menus en permanence",
		["Afficher automatiquement les menus en combat"] = "Afficher automatiquement les menus en combat",
		["Fermer le menu apres un clic sur un de ses elements"] = "Fermer le menu apr\195\168s un clic sur un de ses \195\169l\195\169ments",
		["Orientation du menu"] = "Orientation du menu",
		["Changer la symetrie verticale des boutons"] = "Changer la sym\195\169trie verticale des boutons",
		["Taille du bouton Banir"] = "Taille du bouton Bannir",
	}
	Necrosis.Config.Menus.Orientation = {
		"Horizontal",
		"Vers le haut",
		"Vers le bas"
	}

	Necrosis.Config.Timers = {
		["Type de timers"] = "Type de timers",
		["Afficher le bouton des timers"] = "Afficher le bouton des timers",
		["Afficher les timers sur la gauche du bouton"] = "Afficher les timers sur la gauche du bouton",
		["Afficher les timers de bas en haut"] = "Afficher les timers de bas en haut"
	}
	Necrosis.Config.Timers.Type = {
		Disabled	= "Aucun",
		Graphical	= "Graphiques",
		Textual		= "Textuels"
	}

	Necrosis.Config.Misc = {
		["Deplace les fragments"] = "D\195\169place les fragments dans le sac specifi\195\169",
		["Detruit les fragments si le sac plein"] = "D\195\169truit les fragments si le sac plein",
		["Choix du sac contenant les fragments"] = "Choix du sac contenant les fragments",
		["Nombre maximum de fragments a conserver"] = "Nombre maximum de fragments \195\160 conserver",
		["Verrouiller Necrosis sur l'interface"] = "Verrouiller Necrosis sur l'interface",
		["Afficher les boutons caches"] = "Afficher les boutons cach\195\169s pour les d\195\169placer",
		["Taille des boutons caches"] = "Taille des boutons cach\195\169s"
	}

	-- Chat messages

	Necrosis.Speech.TP = {
		[1] = {
			"<after>Taxi des Arcanes ! Cliquez sur le portail svp !",
		},
		[2] = {
			"<after>Bienvenue, sur le vol de ~Succube Air Lines~ \195\160 destination de <player>...",
			"<after>Les h\195\180tesses et leur fouet sont \195\160 votre disposition durant le trajet",
		},
		[3] = {
			"<after>Si vous ne voulez pas qu'une cr\195\169ature tentaculaire, glaireuse et asthmatique sorte de ce portail, cliquez dessus au plus vite !",
		},
		[4] = {
			"<after>Si vous cliquez sur le portail, on commencera \195\160 jouer plus vite...",
		},
		[5] = {
			"Tel un lapin dans un chapeau de mage, nous allons faire appara\195\174tre devant vos yeux \195\169bahis...",
			"<after>Et hop.",
		},
		[6] = {
			"PAR ASTAROTH ET DASMODES, JE T'INVOQUE, O TOUT PUISSANT DEMON DES SEPTS ENFERS, PARANGON VELU DES INFRA MONDES DEMONIAQUES, PAR LA PUISSANCE DU SCEAU ANCESTR... euh ?!? Je crois qu'il y a un probl\195\168me l\195\160...",
			"<after>Ah ben non...",
		},
	}

	Necrosis.Speech.Rez = {
		[1] = {
			"<after>Si ca vous tente un suicide collectif, <target> s'en fout, la pierre d'\195\162me lui permettra de se relever",
		},
		[2] = {
			"<after><target> peut partir siroter un caf\195\169, et pourra se relever du wipe qui s'en suivra gr\195\162ce \195\160 sa pierre d'\195\162me",
		},
		[3] = {
			"<after>Pierre pos\195\169e sur <target>, vous pouvez recommencer \195\160 faire n'importe quoi sans risque",
		},
		[4] = {
			"<after>Gr\195\162ce \195\160 sa pierre d'\195\162me, <target> est pass\195\169 en mode Easy wipe",
		},
		[5] = {
			"<after><target> peut d\195\169sormais revenir d'entre les morts, histoire d'organiser le prochain wipe",
		},
		[6] = {
			"<after>Les hindous croient \195\160 l'immortalit\195\169, <target> aussi depuis que je lui ai pos\195\169 une pierre d'\195\162me",
		},
		[7] = {
			"Ne bougeons plus !",
			"<after><target> est d\195\169sormais \195\169quip\195\169 de son kit de survie temporaire.",
		},
		[8] = {
			"<after>Tel le ph\195\169nix, <target> pourra revenir d'entre les flammes de l'enfer (Faut dire aussi qu'il a beaucoup de rf...)",
		},
		[9] = {
			"<after>Gr\195\162ce \195\160 sa pierre d'\195\162me, <target> peut de nouveau faire n'importe quoi.",
		},
		[10] = {
			"<after>Sur <target> poser une belle pierre d'\195\162me,",
			"<after>Voil\195\160 qui peut ma foi \195\169viter bien des drames !",
		},
	}
	
	Necrosis.Speech.RoS = {
		[1] = {
			"Utilisons donc les \195\162mes de nos ennemis, pour nous redonner la vie !",
		},
		[2] = {
			"Votre \195\162me, mon \195\162me, leur \195\162me... Quelle importance ? Allez, piochez-en juste une !",
		},
	}

	Necrosis.Speech.ShortMessage = {
		{{"<after>--> <target> est prot\195\169g\195\169 par une pierre d'\195\162me <--"}},
		{{"<after><TP> Invocation en cours, cliquez sur le portail svp <TP>"}},
		{{"Rassembler un rituel des \195\162mes"}}
	}

	Necrosis.Speech.Demon = {
		-- Diablotin
		[1] = {
			[1] = {
				"Bon, s\195\162le petite peste de Diablotin, tu arr\195\170tes de bouder et tu viens m'aider ! ET C'EST UN ORDRE !",
			},
			[2] = {
				"<pet> ! AU PIED ! TOUT DE SUITE !",
			},
			[3] = {
				"Attendez, je sors mon briquet !",
			},
		},
		-- Marcheur �th�r�
		[2] = {
			[1] = {
				"Oups, je vais sans doute avoir besoin d'un idiot pour prendre les coups \195\160 ma place...",
				"<pet>, viens m'aider !",
			},
			[2] = {
				"GRAOUbouhhhhh GROUAHOUhououhhaahpfffROUAH !",
				"GRAOUbouhhhhh GROUAHOUhououhhaahpfffROUAH !",
				"(Non je ne suis pas dingue, j'imite le bruit du marcheur en rut !)",
			},
		},
		-- Succube
		[3] = {
			[1] = {
				"<pet> ma grande, viens m'aider ch\195\169rie !",
			},
			[2] = {
				"Ch\195\169rie, l\195\162che ton rimmel et am\195\168ne ton fouet, y a du taf l\195\160 !",
			},
			[3] = {
				"<pet> ? Viens ici ma louloutte !",
			},
		},
		-- Chasseur corrompu
		[4] = {
			[1] = {
				"<pet> ! <pet> ! Aller viens mon brave, viens ! <pet> !",
			},
			[2] = {
				"Rhoo, et qui c'est qui va se bouffer le mage hein ? C'est <pet> !",
				"<after>Regardez, il bave d\195\169j\195\160 :)",
			},
			[3] = {
				"Une minute, je sors le caniche et j'arrive !",
			},
		},
		-- Gangregarde
		[5] = {
			[1] = {
				"<emote> concentre toute sa puissance dans ses connaissances d\195\169monologiques...",
				"En \195\169change de cette \195\162me, viens \195\160 moi, Gangregarde !",
				"<after>Ob\195\169is moi maintenant, <pet> !",
				"<after><emote>fouille dans son sac, puis lance un cristal \195\160 <pet>",
				"<sacrifice>Retourne dans les limbes et donne moi de ta puissance, D\195\169mon !"
			},
		},
		-- Phrase pour la premi�re invocation de pet (quand Necrosis ne connait pas encore leur nom)
		[6] = {
			[1] = {
				"La p\195\170che au d\195\169mon ? Rien de plus facile !",
				"Bon, je ferme les yeux, j'agite les doigts comme \195\167a...",
				"<after>Et hop ! Oh, les jolies couleurs !",
			},
			[2] = {
				"Toute fa\195\167on je vous d\195\169teste tous ! J'ai pas besoin de vous, j'ai des amis.... Puissants !",
				"VENEZ A MOI, CREATURES DE L'ENFER !",
			},
			[3] = {
				"Eh, le d\195\169mon, viens voir, il y a un truc \195\160 cogner l\195\160 !",
			},
			[4] = {
				"En farfouillant dans le monde abyssal, on trouve de ces trucs...",
				"<after>Regardez, ceci par exemple !",
			},

		},
		-- Phrase pour la monture
		[7] = {
			[1] = {
				"Mmmphhhh, je suis en retard ! Invoquons vite un cheval qui rox !",
			},
			[2] = {
				"J'invoque une monture de l'enfer !",
			},
			[3] = {
				"<emote>ricane comme un damn\195\169 !",
				"<after><yell>TREMBLEZ, MORTELS, J'ARRIVE A LA VITESSE DU CAUCHEMAR !!!!",
			},
			[4] = {
				"Et hop, un cheval tout feu tout flamme !",
			},
			[5] = {
				"Vous savez, depuis que j'ai mis une selle ignifug\195\169e, je n'ai plus de probl\195\168me de culotte !"
			},
		},

	}

end


-- Pour les caract�res sp�ciaux :
-- � = \195\169 ---- � = \195\168
-- � = \195\160 ---- � = \195\162
-- � = \195\180 ---- � = \195\170
-- � = \195\187 ---- � = \195\164
-- - = \195\132 ---- � = \195\182
-- � = \195\150 ---- � = \195\188
-- _ = \195\156 ---- � = \195\159
-- � = \195\167 ---- � = \195\174
