#Include  %A_ScriptDir%\IME.ahk

;=============================
; キーボード配列ヘルパー
;=============================

Global flg_log
Global intInputX, intInputY
Global intHelpX, intHelpY
Global MapArray
MapArray := {}
; 設定ファイル読み込み（ShinGetaHelper.ini）
IniRead, strInvokeHotKey, %A_ScriptDir%\KanaHelper.ini, Main, InvokeHotKey , +^h
IniRead, flg_log, %A_ScriptDir%\KanaHelper.ini, Main, EnableLog , 0
IniRead, intInputX, %A_ScriptDir%\KanaHelper.ini, Main, InputX , 
IniRead, intInputY, %A_ScriptDir%\KanaHelper.ini, Main, InputY , 
IniRead, intHelpX, %A_ScriptDir%\KanaHelper.ini, Main, HelpX , 200
IniRead, intHelpY, %A_ScriptDir%\KanaHelper.ini, Main, HelpY , 200
IniRead, MapPath, %A_ScriptDir%\KanaHelper.ini, Main,  Map , 

If (MapPath = "")
{
	MsgBox, マッピングファイルを読み込めませんでした。
	Exit
}

; 配列定義読み込み
ParseTSV(MapPath)

; iniのInputX、InputYが空文字の場合はそれぞれの方向の中央にする。
;      HelpX、HelpYが空文字の場合も同様だが、InputBoxはデフォルト中央なので手当不要。
If (intHelpX is integer)
{
	intHelpX = X%intHelpX%
}
Else
{
	intHelpX = XCenter
}

If (intHelpY is integer)
{
	intHelpY = X%intHelpY%
}
Else
{
	intHelpY = YCenter
}

Hotkey, %strInvokeHotKey%, ShowDialog
Return

ShowDialog:
	ime_mode := IME_GET()
	IME_SET(0)
	InputBox, UserInput, キーボード配列ヘルパー, 入力方法を調べたい文字のローマ字を入力`n（括弧系はkakko、記号系はkigouと入力）`n`n連続した文字を入力する場合はスペースで区切る（例：ta n go）, , 300, 200, %intInputX%, %intInputY%
	IME_SET(ime_mode)
	If (ErrorLevel = 0)
	{
		
		; StringReplace, UserInput, UserInput, %A_Space% , , All
		StringReplace, UserInput, UserInput, 　 , , All
		; スペースまたはから文字が入力された場合は何も表示せずに終了する
		If (UserInput = "")
		{
			return
		}

		; スペース区切りで分割
		StringSplit, arrUserInput, UserInput , %A_Space% ,

		Gui, +AlwaysOnTop -MaximizeBox -MinimizeBox -Resize
		Gui Font, S11 Q5, Meiryo
		Loop, %arrUserInput0%
		{
			If (arrUserInput%A_Index% != "")
			{
				Gui Add, Text  ,w200 , % GetHelp(arrUserInput%A_Index%)
			}
		}
		Gui Font, S9
		Gui Add, Button,h0 w0 default , 閉じる
		Gui Show, %intHelpX% %intHelpY% AutoSize, キーボード配列ヘルパー

		return

		Button閉じる:
			Gui, submit,nohide
			Gui, Destroy
		return

		GuiEscape:
			Gui, Destroy
		Return

	}
Return



GetHelp(kana)
{
	; ア行
		If (kana = "a")
		{
			WriteLog("あ")
			Return "【あ】⇒ " MapArray.あ
		}
		Else If  (kana = "i")
		{
			WriteLog("い")
			Return "【い】⇒ " MapArray.い
		}
		Else If  (kana = "u")
		{
			WriteLog("う")
			Return "【う】⇒ " MapArray.う
		}
		Else If  (kana = "e")
		{
			WriteLog("え")
			Return "【え】⇒ " MapArray.え
		}
		Else If  (kana = "o")
		{
			WriteLog("お")
			Return "【お】⇒ " MapArray.お
		}
	; カ行
		Else If  (kana = "ka")
		{
			WriteLog("か")
			Return "【か】⇒ " MapArray.か
		}
		Else If  (kana = "ki")
		{
			WriteLog("き")
			Return "【き】⇒ " MapArray.き
		}
		Else If  (kana = "ku")
		{
			WriteLog("く")
			Return "【く】⇒ " MapArray.く
		}
		Else If  (kana = "ke")
		{
			WriteLog("け")
			Return "【け】⇒ " MapArray.け
		}
		Else If  (kana = "ko")
		{
			WriteLog("こ")
			Return "【こ】⇒ " MapArray.こ
		}
	; サ行
		Else If  (kana = "sa")
		{
			WriteLog("さ")
			Return "【さ】⇒ " MapArray.さ
		}
		Else If  (kana = "si" || kana = "shi")
		{
			WriteLog("し")
			Return "【し】⇒ " MapArray.し
		}
		Else If  (kana = "su")
		{
			WriteLog("す")
			Return "【す】⇒ " MapArray.す
		}
		Else If  (kana = "se")
		{
			WriteLog("せ")
			Return "【せ】⇒ " MapArray.せ
		}
		Else If  (kana = "so")
		{
			WriteLog("そ")
			Return "【そ】⇒ " MapArray.そ
		}
	; タ行
		Else If  (kana = "ta")
		{
			WriteLog("た")
			Return "【た】⇒ " MapArray.た
		}
		Else If  (kana = "ti" || kana = "chi")
		{
			WriteLog("ち")
			Return "【ち】⇒ " MapArray.ち
		}
		Else If  (kana = "tu" || kana = "tsu")
		{
			WriteLog("つ")
			Return "【つ】⇒ " MapArray.つ
		}
		Else If  (kana = "te")
		{
			WriteLog("て")
			Return "【て】⇒ " MapArray.て
		}
		Else If  (kana = "to")
		{
			WriteLog("と")
			Return "【と】⇒ " MapArray.と
		}
	; ナ行
		Else If  (kana = "na")
		{
			WriteLog("な")
			Return "【な】⇒ " MapArray.な
		}
		Else If  (kana = "ni")
		{
			WriteLog("に")
			Return "【に】⇒ " MapArray.に
		}
		Else If  (kana = "nu")
		{
			WriteLog("ぬ")
			Return "【ぬ】⇒ " MapArray.ぬ
		}
		Else If  (kana = "ne")
		{
			WriteLog("ね")
			Return "【ね】⇒ " MapArray.ね
		}
		Else If  (kana = "no")
		{
			WriteLog("の")
			Return "【の】⇒ " MapArray.の
		}
	; ハ行
		Else If  (kana = "ha")
		{
			WriteLog("は")
			Return "【は】⇒ " MapArray.は
		}
		Else If  (kana = "hi")
		{
			WriteLog("ひ")
			Return "【ひ】⇒ " MapArray.ひ
		}
		Else If  (kana = "hu" || kana = "fu")
		{
			WriteLog("ふ")
			Return "【ふ】⇒ " MapArray.ふ
		}
		Else If  (kana = "he")
		{
			WriteLog("へ")
			Return "【へ】⇒ " MapArray.へ
		}
		Else If  (kana = "ho")
		{
			WriteLog("ほ")
			Return "【ほ】⇒ " MapArray.ほ
		}
	; マ行
		Else If  (kana = "ma")
		{
			WriteLog("ま")
			Return "【ま】⇒ " MapArray.ま
		}
		Else If  (kana = "mi")
		{
			WriteLog("み")
			Return "【み】⇒ " MapArray.み
		}
		Else If  (kana = "mu")
		{
			WriteLog("む")
			Return "【む】⇒ " MapArray.む
		}
		Else If  (kana = "me")
		{
			WriteLog("め")
			Return "【め】⇒ " MapArray.め
		}
		Else If  (kana = "mo")
		{
			WriteLog("も")
			Return "【も】⇒ " MapArray.も
		}
	; ヤ行
		Else If  (kana = "ya")
		{
			WriteLog("や")
			Return "【や】⇒ " MapArray.や
		}
		Else If  (kana = "yu")
		{
			WriteLog("ゆ")
			Return "【ゆ】⇒ " MapArray.ゆ
		}
		Else If  (kana = "yo")
		{
			WriteLog("よ")
			Return "【よ】⇒ " MapArray.よ
		}
	; ラ行
		Else If  (kana = "ra")
		{
			WriteLog("ら")
			Return "【ら】⇒ " MapArray.ら
		}
		Else If  (kana = "ri")
		{
			WriteLog("り")
			Return "【り】⇒ " MapArray.り
		}
		Else If  (kana = "ru")
		{
			WriteLog("る")
			Return "【る】⇒ " MapArray.る
		}
		Else If  (kana = "re")
		{
			WriteLog("れ")
			Return "【れ】⇒ " MapArray.れ
		}
		Else If  (kana = "ro")
		{
			WriteLog("ろ")
			Return "【ろ】⇒ " MapArray.ろ
		}
	; ワ行
		Else If  (kana = "wa")
		{
			WriteLog("わ")
			Return "【わ】⇒ " MapArray.わ
		}
		Else If  (kana = "wo")
		{
			WriteLog("を")
			Return "【を】⇒ " MapArray.を
		}
		Else If  (kana = "n" || kana = "nn")
		{
			WriteLog("ん")
			Return "【ん】⇒ " MapArray.ん
		}
	; ガ行
		Else If  (kana = "ga")
		{
			WriteLog("が")
			Return "【が】⇒ " MapArray.が
		}
		Else If  (kana = "gi")
		{
			WriteLog("ぎ")
			Return "【ぎ】⇒ " MapArray.ぎ
		}
		Else If  (kana = "gu")
		{
			WriteLog("ぐ")
			Return "【ぐ】⇒ " MapArray.ぐ
		}
		Else If  (kana = "ge")
		{
			WriteLog("げ")
			Return "【げ】⇒ " MapArray.げ
		}
		Else If  (kana = "go")
		{
			WriteLog("ご")
			Return "【ご】⇒ " MapArray.ご
		}
	; ザ行
		Else If  (kana = "za")
		{
			WriteLog("ざ")
			Return "【ざ】⇒ " MapArray.ざ
		}
		Else If  (kana = "zi" || kana = "ji")
		{
			WriteLog("じ")
			Return "【じ】⇒ " MapArray.じ
		}
		Else If  (kana = "zu")
		{
			WriteLog("ず")
			Return "【ず】⇒ " MapArray.ず
		}
		Else If  (kana = "ze")
		{
			WriteLog("ぜ")
			Return "【ぜ】⇒ " MapArray.ぜ
		}
		Else If  (kana = "zo")
		{
			WriteLog("ぞ")
			Return "【ぞ】⇒ " MapArray.ぞ
		}
	; ダ行
		Else If  (kana = "da")
		{
			WriteLog("だ")
			Return "【だ】⇒ " MapArray.だ
		}
		Else If  (kana = "di")
		{
			WriteLog("ぢ")
			Return "【ぢ】⇒ " MapArray.ぢ
		}
		Else If  (kana = "du")
		{
			WriteLog("づ")
			Return "【づ】⇒ " MapArray.づ
		}
		Else If  (kana = "de")
		{
			WriteLog("で")
			Return "【で】⇒ " MapArray.で
		}
		Else If  (kana = "do")
		{
			WriteLog("ど")
			Return "【ど】⇒ " MapArray.ど
		}
	; バ行
		Else If  (kana = "ba")
		{
			WriteLog("ば")
			Return "【ば】⇒ " MapArray.ば
		}
		Else If  (kana = "bi")
		{
			WriteLog("び")
			Return "【び】⇒ " MapArray.び
		}
		Else If  (kana = "bu")
		{
			WriteLog("ぶ")
			Return "【ぶ】⇒ " MapArray.ぶ
		}
		Else If  (kana = "be")
		{
			WriteLog("べ")
			Return "【べ】⇒ " MapArray.べ
		}
		Else If  (kana = "bo")
		{
			WriteLog("ぼ")
			Return "【ぼ】⇒ " MapArray.ぼ
		}
	; パ行
		Else If  (kana = "pa")
		{
			WriteLog("ぱ")
			Return "【ぱ】⇒ " MapArray.ぱ
		}
		Else If  (kana = "pi")
		{
			WriteLog("ぴ")
			Return "【ぴ】⇒ " MapArray.ぴ
		}
		Else If  (kana = "pu")
		{
			WriteLog("ぷ")
			Return "【ぷ】⇒ " MapArray.ぷ
		}
		Else If  (kana = "pe")
		{
			WriteLog("ぺ")
			Return "【ぺ】⇒ " MapArray.ぺ
		}
		Else If  (kana = "po")
		{
			WriteLog("ぽ")
			Return "【ぽ】⇒ " MapArray.ぽ
		}
	; 小文字系
		Else If (kana = "xa" || kana = "la")
		{
			WriteLog("ぁ")
			Return "【ぁ】⇒ " MapArray.ぁ
		}
		Else If (kana = "xi" || kana = "li")
		{
			WriteLog("ぃ")
			Return "【ぃ】⇒ " MapArray.ぃ
		}
		Else If (kana = "xu" || kana = "lu")
		{
			WriteLog("ぅ")
			Return "【ぅ】⇒ " MapArray.ぅ
		}
		Else If (kana = "xe" || kana = "le")
		{
			WriteLog("ぇ")
			Return "【ぇ】⇒ " MapArray.ぇ
		}
		Else If (kana = "xo" || kana = "lo")
		{
			WriteLog("ぉ")
			Return "【ぉ】⇒ " MapArray.ぉ
		}
		Else If (kana = "xtu" || kana = "ltu" || kana = "ttu" || kana = "xtsu" || kana = "ltsu" || kana = "ttsu")
		{
			WriteLog("っ")
			Return "【っ】⇒ " MapArray.っ
		}
		Else If (kana = "xya" || kana = "lya")
		{
			WriteLog("ゃ")
			Return "【ゃ】⇒ " MapArray.ゃ
		}
		Else If (kana = "xyu" || kana = "lyu")
		{
			WriteLog("ゅ")
			Return "【ゅ】⇒ " MapArray.ゅ
		}
		Else If (kana = "xyo" || kana = "lyo")
		{
			WriteLog("ょ")
			Return "【ょ】⇒ " MapArray.ょ
		}
		Else If (kana = "xwa" || kana = "lwa")
		{
			WriteLog("ゎ")
			Return "【ゎ】⇒ " MapArray.ゎ
		}
	; ウ系
		Else If (kana = "wi")
		{
			WriteLog("うぃ")
			Return "【うぃ】⇒ " MapArray.うぃ
		}
		Else If (kana = "we")
		{
			WriteLog("うぇ")
			Return "【うぇ】⇒ " MapArray.うぇ
		}
		Else If (kana = "uxo" || kana = "wlo")
		{
			WriteLog("うぉ")
			Return "【うぉ】⇒ " MapArray.うぉ
		}
		Else If (kana = "vu")
		{
			WriteLog("う゛")
			Return "【う゛】⇒ " MapArray.う゛
		}
	; キャ行
		Else If (kana = "kya")
		{
			WriteLog("きゃ")
			Return "【きゃ】⇒ " MapArray.きゃ
		}
		Else If (kana = "kyu")
		{
			WriteLog("きゅ")
			Return "【きゅ】⇒ " MapArray.きゅ
		}
		Else If (kana = "kyo")
		{
			WriteLog("きょ")
			Return "【きょ】⇒ " MapArray.きょ
		}
	; ギャ行
		Else If (kana = "gya")
		{
			WriteLog("ぎゃ")
			Return "【ぎゃ】⇒ " MapArray.ぎゃ
		}
		Else If (kana = "gyu")
		{
			WriteLog("ぎゅ")
			Return "【ぎゅ】⇒ " MapArray.ぎゅ
		}
		Else If (kana = "gyo")
		{
			WriteLog("ぎょ")
			Return "【ぎょ】⇒ " MapArray.ぎょ
		}
	; シャ行
		Else If (kana = "sha" || kana = "sya")
		{
			WriteLog("しゃ")
			Return "【しゃ】⇒ " MapArray.しゃ
		}
		Else If (kana = "shu")
		{
			WriteLog("しゅ")
			Return "【しゅ】⇒ " MapArray.しゅ
		}
		Else If (kana = "she" || kana = "sye")
		{
			WriteLog("しぇ")
			Return "【しぇ】⇒ " MapArray.しぇ
		}
		Else If (kana = "syo" || kana = "sho")
		{
			WriteLog("しょ")
			Return "【しょ】⇒ " MapArray.しょ
		}
	; ジャ行
		Else If (kana = "ja" || kana = "zya")
		{
			WriteLog("じゃ")
			Return "【じゃ】⇒ " MapArray.じゃ
		}
		Else If (kana = "ju" || kana = "zyu")
		{
			WriteLog("じゅ")
			Return "【じゅ】⇒ " MapArray.じゅ
		}
		Else If (kana = "je" || kana = "zye")
		{
			WriteLog("じぇ")
			Return "【じぇ】⇒ " MapArray.じぇ
		}
		Else If (kana = "jo" || kana = "zyo")
		{
			WriteLog("じょ")
			Return "【じょ】⇒ " MapArray.じょ
		}
	; チャ行
		Else If (kana = "cya" || kana = "tya" || kana = "cha")
		{
			WriteLog("ちゃ")
			Return "【ちゃ】⇒ " MapArray.ちゃ
		}
		Else If (kana = "cyu" || kana = "tyu" || kana = "chu")
		{
			WriteLog("ちゅ")
			Return "【ちゅ】⇒ " MapArray.ちゅ
		}
		Else If (kana = "che" || kana = "tye")
		{
			WriteLog("ちぇ")
			Return "【ちぇ】⇒ " MapArray.ちぇ
		}
		Else If (kana = "cyo" || kana = "tyo" || kana = "cho")
		{
			WriteLog("ちょ")
			Return "【ちょ】⇒ " MapArray.ちょ
		}
	; ヂャ行
		Else If (kana = "dya")
		{
			WriteLog("ぢゃ")
			Return "【ぢゃ】⇒ " MapArray.ぢゃ
		}
		Else If (kana = "dyu")
		{
			WriteLog("ぢゅ")
			Return "【ぢゅ】⇒ " MapArray.ぢゅ
		}
		Else If (kana = "dye")
		{
			WriteLog("ぢぇ")
			Return "【ぢぇ】⇒ " MapArray.ぢぇ
		}
		Else If (kana = "dyo")
		{
			WriteLog("ぢょ")
			Return "【ぢょ】⇒ " MapArray.ぢょ
		}	
	; ティ系
		Else If (kana = "texi" || kana = "thi")
		{
			WriteLog("てぃ")
			Return "【てぃ】⇒ " MapArray.てぃ
		}
		Else If (kana = "dexi" || kana = "dhi")
		{
			WriteLog("でぃ")
			Return "【でぃ】⇒ " MapArray.でぃ
		}
	; ニャ行
		Else If (kana = "nya")
		{
			WriteLog("にゃ")
			Return "【にゃ】⇒ " MapArray.にゃ
		}
		Else If (kana = "nyu")
		{
			WriteLog("にゅ")
			Return "【にゅ】⇒ " MapArray.にゅ
		}
		Else If (kana = "nyo")
		{
			WriteLog("にょ")
			Return "【にょ】⇒ " MapArray.にょ
		}
	; ヒャ行
		Else If (kana = "hya")
		{
			WriteLog("ひゃ")
			Return "【ひゃ】⇒ " MapArray.ひゃ
		}
		Else If (kana = "hyu")
		{
			WriteLog("ひゅ")
			Return "【ひゅ】⇒ " MapArray.ひゅ
		}
		Else If (kana = "hyo")
		{
			WriteLog("ひょ")
			Return "【ひょ】⇒ " MapArray.ひょ
		}
	; ビャ行
		Else If (kana = "bya")
		{
			WriteLog("びゃ")
			Return "【びゃ】⇒ " MapArray.びゃ
		}
		Else If (kana = "byu")
		{
			WriteLog("びゅ")
			Return "【びゅ】⇒ " MapArray.びゅ
		}
		Else If (kana = "byo")
		{
			WriteLog("びょ")
			Return "【びょ】⇒ " MapArray.びょ
		}
	; ピャ行
		Else If (kana = "pya")
		{
			WriteLog("ぴゃ")
			Return "【ぴゃ】⇒ " MapArray.ぴゃ
		}
		Else If (kana = "pyu")
		{
			WriteLog("ぴゅ")
			Return "【ぴゅ】⇒ " MapArray.ぴゅ
		}
		Else If (kana = "pyo")
		{
			WriteLog("ぴょ")
			Return "【ぴょ】⇒ " MapArray.ぴょ
		}
	; ファ行
		Else If (kana = "fa")
		{
			WriteLog("ふぁ")
			Return "【ふぁ】⇒ " MapArray.ふぁ
		}
		Else If (kana = "fi")
		{
			WriteLog("ふぃ")
			Return "【ふぃ】⇒ " MapArray.ふぃ
		}
		Else If (kana = "fe")
		{
			WriteLog("ふぇ")
			Return "【ふぇ】⇒ " MapArray.ふぇ
		}
		Else If (kana = "fo")
		{
			WriteLog("ふぉ")
			Return "【ふぉ】⇒ " MapArray.ふぉ
		}
	; ミャ行
		Else If (kana = "mya")
		{
			WriteLog("みゃ")
			Return "【みゃ】⇒ " MapArray.みゃ
		}
		Else If (kana = "myu")
		{
			WriteLog("みゅ")
			Return "【みゅ】⇒ " MapArray.みゅ
		}
		Else If (kana = "myo")
		{
			WriteLog("みょ")
			Return "【みょ】⇒ " MapArray.みょ
		}
	; リャ行
		Else If (kana = "rya")
		{
			WriteLog("りゃ")
			Return "【りゃ】⇒ " MapArray.りゃ
		}
		Else If (kana = "ryu")
		{
			WriteLog("りゅ")
			Return "【りゅ】⇒ " MapArray.りゅ
		}
		Else If (kana = "ryo")
		{
			WriteLog("りょ")
			Return "【りょ】⇒ " MapArray.りょ
		}


	; 記号系
		Else If (kana = "-")
		{
			WriteLog("ー")
			Return "【ー】⇒ " MapArray.ー
		}
		Else If (kana = ",")
		{
			WriteLog("、")
			Return "【、】⇒ " MapArray.、
		}
		Else If (kana = ".")
		{
			WriteLog("。")
			Return "【。】⇒ " MapArray.。
		}
		Else If (kana = "?")
		{
			WriteLog("？")
			Return "【？】⇒ " MapArray.？
		}
		Else If (kana = "!")
		{
			WriteLog("！")
			Return "【！】⇒ " MapArray.！
		}
		Else If (kana = ";")
		{
			WriteLog("；")
			Return "【；】⇒ " MapArray.；
		}
		Else If (kana = ";")
		{
			WriteLog("：")
			Return "【：】⇒ " MapArray.：
		}
		Else If (kana = "@")
		{
			WriteLog("＠")
			Return "【＠】⇒ " MapArray.＠
		}
		Else If (kana = "*")
		{
			WriteLog("＊")
			Return "【＊】⇒ " MapArray.＊
		}
		Else If (kana = "kakko")
		{
			WriteLog("括弧")
			Return MapArray.括弧
		}
		Else If (kana = "kigou")
		{
			WriteLog("記号")
			Return MapArray.記号
		}

	; 	Else If (kana = "hye")
	; 	{
	; 		Return "ひ＋ぇ"
	; 	}
	; 	Else If (kana = "tha")
	; 	{
	; 		Return "て＋ゃ"
	; 	}
	; 	Else If (kana = "thu")
	; 	{
	; 		Return "て＋ゅ"
	; 	}
	; 	Else If (kana = "tho")
	; 	{
	; 		Return "て＋ょ"
	; 	}

	; 未入力
		Else If (kana = "")
		{
			Return "ローマ字を入力してください。"
		}
	; その他
		Else
		{
			Return "ローマ字入力が想定外。"
		}
}

WriteLog(log)
{
	If (flg_log)
	{
		logText = %A_YYYY%/%A_MM%/%A_DD%,%A_Hour%:%A_Min%:%A_Sec%,%log%
    	FileAppend,  %logText%`n, %A_ScriptDir%\HelperLog.csv
	}
    
}

ParseTSV(strFilePath)
{  
	FileRead, strData, %strFilePath%
	Loop, Parse, strData, `n, `r
	{
		StringSplit, mapline, A_LoopField , `t ,
		Loop, %mapline0%
		{
			If (Mod(A_Index , 2) = 0  && mapline2 != "")
			{
				StringReplace, result_nl, mapline2, \n , `n , All
				MapArray.Insert(mapline1, result_nl)
			}
		}

	}
}