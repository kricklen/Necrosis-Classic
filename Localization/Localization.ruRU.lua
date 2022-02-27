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
-- Version Russe par Komsomolka (Хроми) (https://koms.ruguild.ru)
--
-- Version $LastChangedDate: 2010-08-04 12:04:27 +1000 (Wed, 04 Aug 2010) $
------------------------------------------------------------------------------------------------------

------------------------------------------------
-- ENGLISH  VERSION TEXTS --
------------------------------------------------

function Localization.ruRU()

	Necrosis.HealthstoneCooldown = "Готовность Камня здоровья"
	
	Necrosis.Localize = {
		["Utilisation"] = "Use",
		["Echange"] = "Trade",
	}

	-- Necrosis.TooltipData = {
	-- 	["Main"] = {
	-- 		Label = "|c00FFFFFFNecrosis|r",
	-- 		Stone = {
	-- 			[true] = "Есть",
	-- 			[false] = "Нет",
	-- 		},
	-- 		Hellspawn = {
	-- 			[true] = "Вкл",
	-- 			[false] = "Выкл",
	-- 		},
	-- 		["Soulshard"] = "Осколки душ: ",
	-- 		["InfernalStone"] = "Камни инфернала: ",
	-- 		["DemoniacStone"] = "Демонические статуэтки: ",
	-- 		["Soulstone"] = "\nКамень души: ",
	-- 		["Healthstone"] = "Камень здоровья: ",
	-- 		["Spellstone"] = "Камень чар: ",
	-- 		["Firestone"] = "Камень огня: ",
	-- 		["CurrentDemon"] = "Демон: ",
	-- 		["EnslavedDemon"] = "Демон: Порабощенный",
	-- 		["NoCurrentDemon"] = "Демон: Отсутствует",
	-- 	},
	-- 	["Soulstone"] = {
	-- 		Text = {"[Правый Клик] Создать","[Левый Клик] Использовать","[Правый Клик] Повторное создание","Ожидание"},
	-- 		Ritual = "|c00FFFFFF[Shift]+[Клик] начало выполнения Ритуала призыва|r"
	-- 	},
	-- 	["Healthstone"] = {
	-- 		Text = {"[Правый Клик] Создать","[Левый Клик] Использовать"},
	-- 		Text2 = "[Средний Клик] или [Ctrl]+[Левый Клик] для передачи",
	-- 		Ritual = "|c00FFFFFF[Shift]+[Клик] Начать Ритуал Душ|r"
	-- 	},
	-- 	["Spellstone"] = {
	-- 		Text = {"[Правый Клик] Создать камень","Камень у Вас в сумке\n[Левый Клик] Нанести на оружие","Нанесено на оружие\n[Клик] Для замены/обновления", "Созданный ранее камень полностью использован\n[Клик] Создать новый камень"}
	-- 	},
	-- 	["Firestone"] = {
	-- 		Text = {"[Правый Клик] Создать камень","Камень у Вас в сумке\n[Левый Клик] Нанести на оружие","Нанесено на оружие\n[Клик] Для замены/обновления", "Созданный ранее камень полностью использован\n[Клик] Создать новый камень"}
	-- 	},
	-- 	["SpellTimer"] = {
	-- 		Label = "|c00FFFFFFТаймер заклинаний|r",
	-- 		Text = "Активное заклинание на цели",
	-- 		Right = "[Правый Клик] Использовать Камень Возвращения в "
	-- 	},
	-- 	["ShadowTrance"] = {
	-- 		Label = "|c00FFFFFFТеневой транс|r"
	-- 	},
	-- 	["Backlash"] = {
	-- 		Label = "|c00FFFFFFОтветный Удар|r"
	-- 	},
	-- 	["Banish"] = {
	-- 		Text = "[Правый Клик] для применения Уровня 1"
	-- 	},
	-- 	["Imp"] = {
	-- 		Label = "|c00FFFFFFБес|r"
	-- 	},
	-- 	["Voidwalker"] = {
	-- 		Label = "|c00FFFFFFДемон Бездны|r"
	-- 	},
	-- 	["Succubus"] = {
	-- 		Label = "|c00FFFFFFСуккуба|r"
	-- 	},
	-- 	["Felhunter"] = {
	-- 		Label = "|c00FFFFFFОхотник Скверны|r"
	-- 	},
	-- 	["Felguard"] = {
	-- 		Label = "|c00FFFFFFСтраж Скверны|r"
	-- 	},
	-- 	["Infernal"] = {
	-- 		Label = "|c00FFFFFFИнфернал|r"
	-- 	},
	-- 	["Doomguard"] = {
	-- 		Label = "|c00FFFFFFСтражник Ужаса|r"
	-- 	},
	-- 	["Mount"] = {
	-- 		Label = "|c00FFFFFFКонь|r",
	-- 		Text = "[Левый Клик] Призыв коня погибели\n[Правый Клик] Призыв коня Скверны"
	-- 	},
	-- 	["BuffMenu"] = {
	-- 		Label = "|c00FFFFFFМеню заклинаний|r",
	-- 		Text = "[Правый Клик] Для удержания меню открытым",
	-- 		Text2 = "Авто-Режим: Закрытие при выходе из боя",
	-- 	},
	-- 	["PetMenu"] = {
	-- 		Label = "|c00FFFFFFМеню демонов|r",
	-- 		Text = "[Правый Клик] Для удержания меню открытым",
	-- 		Text2 = "Авто-Режим: Закрытие при выходе из боя",
	-- 	},
	-- 	["CurseMenu"] = {
	-- 		Label = "|c00FFFFFFМеню проклятий|r",
	-- 		Text = "[Правый Клик] Для удержания меню открытым",
	-- 		Text2 = "Авто-Режим: Закрытие при выходе из боя",
	-- 	},
	-- 	["DominationCooldown"] = "[Правый Клик] Быстрый вызов",
	-- }

	Necrosis.Sound = {
		["Fear"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\Fear-Ru.mp3",
		["SoulstoneEnd"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\SoulstoneEnd-Ru.mp3",
		["EnslaveEnd"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\EnslaveDemonEnd-Ru.mp3",
		["ShadowTrance"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\ShadowTrance-Ru.mp3",
		["Backlash"] = "Interface\\AddOns\\Necrosis-Classic\\sounds\\Backlash-Ru.mp3",
	}

	Necrosis.ProcText = {
		["ShadowTrance"] = "<white>Т<lightPurple1>е<lightPurple2>н<purple>е<darkPurple1>в<darkPurple2>о<darkPurple1>й Т<purple>р<lightPurple2>а<lightPurple1>н<white>с",
		["Backlash"] = "<white>О<lightPurple1>т<lightPurple2>в<purple>е<darkPurple1>т<darkPurple2>н<darkPurple1>ы<darkPurple2>й У<purple>д<lightPurple2>а<lightPurple1>р"
	}


	Necrosis.ChatMessage = {
		["Bag"] = {
			["FullPrefix"] = "Ваша ",
			["FullSuffix"] = " полна!",
			["FullDestroySuffix"] = " полна. Следующий осколок души будет уничтожен!",
		},
		["Interface"] = {
			["Welcome"] = "<white>Введите /necrosis для отображения окна настроек",
			["TooltipOn"] = "[+] Всплывающие подсказки включены" ,
			["TooltipOff"] = "[-] Всплывающие подскажки выключены",
			["MessageOn"] = "[+] Оповещения в окне чата - включены",
			["MessageOff"] = "[-] Оповещения в окне чата - выключены",
			["DefaultConfig"] = "<lightYellow>Загружена стандартная конфигурация.",
			["UserConfig"] = "<lightYellow>Конфигурация успешно загружена."
		},
		["Help"] = {
			"/necrosis <lightOrange>recall<white> -- <lightBlue>Команда для размещение окна Necrosis и его кнопок в центре экрана.",
			"/necrosis <lightOrange>reset<white> -- <lightBlue>Команда полностью сбрасывает все настройки Necrosis до настроек по умолчанию.",
		},
		["Information"] = {
			["FearProtect"] = "Ваша цель не поддается страху!",
			["EnslaveBreak"] = "Ваш демон разорвал цепи!",
			["SoulstoneEnd"] = "<lightYellow>Ваш Камень Души выдохся!"
		}
	}


	-- Gestion XML - Menu de configuration
	Necrosis.Config.Panel = {
		"Настройки Сообщений",
		"Настройки Сферы",
		"Настройки Кнопок",
		"Настройки Меню",
		"Настройки Таймера",
		"Разное"
	}

	Necrosis.Config.Messages = {
		["Position"] = "<- Сообщения Necrosis будут расположены здесь ->",
		["Afficher les bulles d'aide"] = "Показывать подсказки",
		["Afficher les messages dans la zone systeme"] = "Показывать сообщения Necrosis в системном окне",
		["Activer les messages aleatoires de TP et de Rez"] = "Включить различные оповещения",
		["Utiliser des messages courts"] = "Использовать только 'короткие' сообщения",
		["Activer egalement les messages pour les Demons"] = "Показывать сообщения для демонов",
		["Activer egalement les messages pour les Montures"] = "Показывать сообщения для коней",
		["Activer egalement les messages pour le Rituel des ames"] = "Показывать сообщения для Ритуала Душ",
		["Activer les sons"] = "Воспроизводить звуковые эффекты",
		["Alerter quand la cible est insensible a la peur"] = "Предупреждать, если цель не поддается страху",
		["Alerter quand la cible peut etre banie ou asservie"] = "Предупреждать, если цель изгнана или порабощена",
		["M'alerter quand j'entre en Transe"] = "Предупреждать о наступлении Теневого Транса"
	}

	Necrosis.Config.Sphere = {
		["Taille de la sphere"] = "Размер кнопок Necrosis",
		["Skin de la pierre Necrosis"] = "Вид Сферы",
		["Evenement montre par la sphere"] = "На Сфере отображать",
		["Sort caste par la sphere"] = "Заклинание Сферы",
		["Afficher le compteur numerique"] = "Показывать отсчет цифрами",
		["Type de compteur numerique"] = "Показывать количество камней"
	}
	Necrosis.Config.Sphere.Colour = {
		["Rose"] 		= "Розовый",
		["Bleu"] 		= "Синий",
		["Orange"] 		= "Оранжевый",
		["Turquoise"] 	= "Бирюзовый",
		["Violet"] 		= "Пурпурный",
		["666"] 		= "666",
		["X"] 			= "X"
	}
	Necrosis.Config.Sphere.Count = {
		["Soulshards"] 	= "Осколки душ",
		["DemonStones"] = "Камни призыва демонов",
		["RezTimer"] 	= "Таймер оживления",
		["Mana"] 		= "Мана",
		["Health"] 		= "Здоровье"
	}

	Necrosis.Config.Buttons = {
		["Rotation des boutons"] = "Вращение кнопок",
		["Fixer les boutons autour de la sphere"] = "Закрепить кнопки вокруг Сферы",
		["Utiliser mes propres montures"] = "Использовать мой транспорт",
		["Choix des boutons a afficher"] = "Выбор кнопок, которые будут показаны",
		["Monture - Clic gauche"] = "[Левый Клик]",
		["Monture - Clic droit"] = "[Правый Клик]",
	}
	Necrosis.Config.Buttons.Name = {
		"Показывать кнопку Камня огня",
		"Показывать кнопку Камня чар",
		"Показывать кнопку Камня здоровья",
		"Показывать кнопку Камня Души",
		"Показывать кнопку Заклинаний",
		"Показывать кнопку вызова Коня",
		"Показывать кнопку Демонов",
		"Показывать кнопку Проклятий",
		"Показывать кнопку Метаморфозы",
	}

	Necrosis.Config.Menus = {
		["Options Generales"] = "Основные настройки",
		["Menu des Buffs"] = "Меню заклинаний",
		["Menu des Demons"] = "Меню Демонов",
		["Menu des Maledictions"] = "Меню Проклятий",
		["Afficher les menus en permanence"] = "Всегда показывать меню",
		["Afficher automatiquement les menus en combat"] = "Показывать меню автоматически во время боя",
		["Fermer le menu apres un clic sur un de ses elements"] = "Закрывать меню тогда, когда Вы нажали на его элемент",
		["Orientation du menu"] = "Размещение меню",
		["Changer la symetrie verticale des boutons"] = "Изменить вертикальную симметрию кнопок (зеркальное\nотражение при выбранном размещении меню: Горизонтально)",
		["Taille du bouton Banir"] = "Размер кнопки Изгнания",
	}
	Necrosis.Config.Menus.Orientation = {
		"Горизонтально",
		"Вверх",
		"Вниз"
	}

	Necrosis.Config.Timers = {
		["Type de timers"] = "Тип таймера",
		["Afficher le bouton des timers"] = "Показывать кнопку таймера заклинаний",
		["Afficher les timers sur la gauche du bouton"] = "Показывать строки таймера слева от кнопки таймера",
		["Afficher les timers de bas en haut"] = "Таймер растёт вверх",
	}
	Necrosis.Config.Timers.Type = {
		Disabled	= "Нет таймера",
		Graphical	= "Графический",
		Textual		= "Текстовый"
	}

	Necrosis.Config.Misc = {
		["Deplace les fragments"] = "Размещать осколки душ в выбранной сумке",
		["Detruit les fragments si le sac plein"] = "Разрушать все новые осколки, если сумка полна",
		["Choix du sac contenant les fragments"] = "Выбор контейнера для осколков душ",
		["Nombre maximum de fragments a conserver"] = "Максимальное кол-во хранимых осколков душ",
		["Verrouiller Necrosis sur l'interface"] = "Заблокировать Necrosis",
		["Afficher les boutons caches"] = "Показать скрытые кнопки для их перемещения",
		["Taille des boutons caches"] = "Размер скрытых кнопок"
	}

	-- Chat messages

	Necrosis.Speech.TP = {
		[1] = {
			"<after>Для открытия межгалактических путей, нажмите на портал.",
		},
		[2] = {
			"<after>Добро пожаловать на борт Темных Авиалиний!",
			"<after>Напоминаем, что курение запрещено на всём протяжении полёта.",
		},
		[3] = {
			"<after>Если вы нажмёте на портал, мы намного быстрее начнём веселиться!",
		},
		[4] = {
			"<after>Если вы не хотите, чтобы из этого портала полезла демоническая гадость, нажмите на него скорее!",
		},
		[5] =  {
			"<after>Камни здоровья=10г; Камни души=20г; Услуги Темных Авиалиний(так как вы за слишком ленивы чтобы добраться сюда самим)=10000г!",
		},
		[6] =  {
			"<after>WTB людей, которые нажмут на портал, вместо того чтобы смотреть на него! :-/",
		},
	}

	Necrosis.Speech.Rez = {
		[1] = {
			"<after>Если вы затаили идею массового суицида, смею вас расстроить! <target> сейчас может самостоятельно оживить свой труп и всё будет хорошо!",
		},
		[2]= {
			"<after><target> теперь может отправиться гулять, выпить кофе или принять ванну. Сохраненная душонка может позволить ему разок сдохнуть...",
		},
		[3]= {
			"<after>Хм... <target> предохранен, и может пуститься в разгул. Но, увы, не вы!",
		},
		[4]= {
			"<after><target> предохранён! Чернокнижники за безопасный секс!",
		},
		[5]= {
			"<after>Почему <target>, после наложения Камня души, всегда сразу уходит в AFK?!!!",
		},
	}

	Necrosis.Speech.RoS = {
		[1] = {
			"Используйте души наших врагов..., чтобы стать сильнее!",
		},
		[2] = {
			"Моя душа... твоя душа... не имеет значения! Возьми себе одну...",
		},
		[3] = {
			"WTS Камни здоровья по 10г за штуку! Дешевле чем на аукционе!",
		},
		[4] = {
			"Камень здоровья вряд ли сохранит вашу жизнь, но всё-таки возьмите один, на всякий случай, авось повезёт...",
		},
		[5] = {
			"Если вы не будете рвать агро, то вам и камень здоровья не понадобится!",
		},
	}

	Necrosis.Speech.ShortMessage = {
		{{"<after>--> <target> теперь сохранен(а) на 30 минут <--"}},
		{{"<after><TP> Призываю <target>. Пожалуйста, нажмите на портал! <TP>"}},
		{{"Выполняется Ритуал душ"}},
	}

	Necrosis.Speech.Demon = {
		-- Imp
		[1] = {
			[1] = {
				"Ах ты позорный маленький бес... Прекрати шкодить и помоги мне! ЭТО ПРИКАЗ!",
			},
			[2] = {
				"<pet>, бес! Приказываю служить мне!",
			},
		},
		-- Voidwalker
		[2] = {
			[1] = {
				"Упс... Похоже, мне нужен идиот, который бы прислуживал мне...",
				"<pet>, мне нужна твоя помощь!",
			},
		},
		-- Succubus
		[3] = {
			[1] = {
				"<pet>, детка... Помоги мне, милая!",
			},
		},
		-- Felhunter
		[4] = {
			[1] = {
				"<pet>! <pet>! Ко мне, пёсик. К ноге, <pet>.",
			},
		},
		-- Felguard
		[5] = {
			[1] = {
				"<emote> концентрируется на своих Демонических знаниях...",
				"Я отдам тебе душу, если ты явишься и будешь служить мне!",
				"<after>Воскресни вновь, <pet>!",
				"<after><emote>смотрит в сумку, затем кидает мистический осколок в <pet>",
				"<sacrifice>Я возвращаю тебя туда, откуда ты пришел, демон... но в замен ты одашь мне свою силу!"
			},
		},
		-- Sentences for the first summon : When Necrosis do not know the name of your demons yet
		[6] = {
			[1] = {
				"Удить рыбу? Да, я люблю рыбалку... смотри...",
				"Я закрываю свои глаза... Я опускаю свои пальцы ниже...",
				"<after>И вуаля! Да, да, да! Это... рыбка.",
			},
			[2] = {
				"Я ненавижу вас всех! Вы не нужны мне! У меня есть лишь один друг... сильный друг!",
				"ПРИДИ КО МНЕ, СОЗДАНИЕ ДЬЯВОЛА И ТЬМЫ!",
			},
		},
		-- Sentences for the stead summon
		[7] = {
			[1] = {
				"Лошааааадкаааа! Лошааааадкаааа!",
			},
			[2] = {
				"<emote> глумится...",
				"Я призываю коня из глубин Ада!",
			},
			[3] = {
				"Я призываю коня из самих глубин Ада! А чего добился ты?",
			},
			[4] = {
				"Эй, дорогу, я опаздываю!",
			},
		}
	}

end
