@actions = Hash.new

@actions = {
	"0" => {
		"inicio" => "S2"
	},
	"1" => {
		"$" => "ACC"
	},
	"2" => {
		"varinicio" => "S4"
	},
	"3" => {
		"fim" => "S11",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"facaAte" => "S68",
		"se" => "S15"
	},
	"4" => {
		"varfim" => "S19",
		"inteiro" => "S38",
		"real" => "S39",
		"lit" => "S40"		
	},
	"5" => {
		"$" => "R2"
	},
	"6" => {
		"fim" => "S11",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"7" => {
		"fim" => "S11",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"8" => {
		"fim" => "S11",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"9" => {
		"fim" => "S11",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"10" => {
		"fimse" => "S27",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"11" => {
		"$" => "R38"
	},
	"12" => {
		"id" => "S28"
	},
	"13" => {
		"lit" => "S32",
		"num" => "S33",
		"id" => "S34"
	},
	"14" => {
		"RCB" => "S59"
	},
	"15" => {
		"AB_P" => "S35"
	},
	"16" => {
		"leia" => "R3",
		"escreva" => "R3",	
		"id" => "R3",	
		"se" => "R3",	
		"fim" => "R3",	
		"facaAte" => "R3"
	},
	"17" => {
		"varfim" => "S19",
		"inteiro" => "S38",
		"real" => "S39",
		"lit" => "S40"			
	},
	"18" => {
		"id" => "S20"
	},
	"19" => {
		"PT_V" => "S41"
	},
	"20" => {
		"VIR" => "S42",
		"PT_V" => "R8"
	},
	"21" => {
		"$" => "R18"
	},
	"22" => {
		"leia" => "R25",
		"escreva" => "R25",	
		"id" => "R25",	
		"se" => "R25",	
		"fim" => "R25",
		"facaAte" => "R25",
		"fimse" => "R25",
	},
	"23" => {
		"fimse" => "S27",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"24" => {
		"fimse" => "S27",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"25" => {
		"fimse" => "S27",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"26" => {
		"leia" => "R34",
		"escreva" => "R34",	
		"id" => "R34",	
		"se" => "R34",	
		"fim" => "R34",
		"facaAte" => "R34"
	},
	"27" => {
		"leia" => "R31",
		"escreva" => "R31",	
		"id" => "R31",	
		"se" => "R31",	
		"fim" => "R31",
		"facaAte" => "R31",
		"fimse" => "R31",
		"fimfaca" => "R31"
	},
	"28" => {
		"PT_V" => "S29"
	},
	"29" => {
		"leia" => "R13",
		"escreva" => "R13",	
		"id" => "R13",	
		"se" => "R13",	
		"fim" => "R13",
		"facaAte" => "R13",
		"fimse" => "R13",
		"fimfaca" => "R13"
	},
	"30" => {
		"PT_V" => "S31"
	},
	"31" => {
		"leia" => "R14",
		"escreva" => "R14",	
		"id" => "R14",	
		"se" => "R14",	
		"fim" => "R14",
		"facaAte" => "R14",
		"fimse" => "R14",
		"fimfaca" => "R14"	
	},
	"32" => {
		"PT_V" => "R15"
	},
	"33" => {
		"PT_V" => "R16"
	},
	"34" => {
		"PT_V" => "R17"
	},
	"35" => {
		"id" => "S49",
		"num" => "S50"
	},
	"36" => {
		"leia" => "R4",
		"escreva" => "R4",	
		"id" => "R4",	
		"se" => "R4",	
		"fim" => "R4",
		"facaAte" => "R4"
	},
	"37" => {
		"PT_V" => "S60"
	},
	"38" => {
		"id" => "R9"
	},
	"39" => {
		"id" => "R10"
	},
	"40" => {
		"id" => "R11"
	},
	"41" => {
		"leia" => "R5",
		"escreva" => "R5",	
		"id" => "R5",	
		"se" => "R5",	
		"fim" => "R5",
		"facaAte" => "R5"
	},
	"42" => {
		"id" => "S20"
	},
	"43" => {
		"leia" => "R28",
		"escreva" => "R28",	
		"id" => "R28",	
		"se" => "R28",	
		"fim" => "R28",
		"facaAte" => "R28",
		"fimse" => "R28",
		"fimfaca" => "R28"
	},
	"44" => {
		"leia" => "R29",
		"escreva" => "R29",	
		"id" => "R29",	
		"se" => "R29",	
		"fim" => "R29",
		"facaAte" => "R29",
		"fimse" => "R29",
		"fimfaca" => "R29"
	},
	"45" => {
		"leia" => "R30",
		"escreva" => "R30",	
		"id" => "R30",	
		"se" => "R30",	
		"fim" => "R30",
		"facaAte" => "R30",
		"fimse" => "R30",
		"fimfaca" => "R30"		
	},
	"46" => {
		"leia" => "R35",
		"escreva" => "R35",	
		"id" => "R35",	
		"se" => "R35",	
		"fim" => "R35",
		"facaAte" => "R35"
	},
	"47" => {
		"FC_P" => "S52"
	},
	"48" => {
		"OPR" => "S53"
	},
	"49" => {
		"OPM" => "R22",
		"PT_V" => "R22",
		"OPR" => "R22",
		"FC_P" => "R22"
	},
	"50" => {
		"OPM" => "R23",
		"PT_V" => "R23",
		"OPR" => "R23",
		"FC_P" => "R23"
	},
	"51" => {
		"inteiro" => "R7",	
		"real" => "R7",
		"lit" => "R7"
	},
	"52" => {
		"entao" => "S54"
	},	
	"53" => {
		"id" => "S49",
		"num" => "S50"
	},
	"54" => {
		"leia" => "R26",
		"escreva" => "R26",	
		"id" => "R26",	
		"se" => "R26",	
		"fimse" => "R26"
	},
	"55" => {
		"FC_P" => "R27"
	},
	"56" => {
		"$" => "R12"
	},
	"57" => {
		"$" => "R24"
	},
	"58" => {
		"$" => "R32"
	},
	"59" => {
		"id" => "S49",
		"num" => "S50"
	},
	"60" => {
		"inteiro" => "R6",
		"real" => "R6",
		"lit" => "R6",
		"id" => "R6",
		"varfim" => "R6"
	},
	"61" => {
		"PT_V" => "S62"
	},
	"62" => {
		"leia" => "R19",
		"escreva" => "R19",	
		"id" => "R19",	
		"se" => "R19",	
		"fim" => "R19",
		"facaAte" => "R19",
		"fimse" => "R19",
		"fimfaca" => "R19"
	},
	"63" => {
		"OPM" => "S64",
		"PT_V" => "R21"
	},
	"64" => {
		"id" => "S49",
		"num" => "S50"
	},
	"65" => {
		"PT_V" => "R20"
	},
	"66" => {
		"leia" => "R36",
		"escreva" => "R36",	
		"id" => "R36",	
		"se" => "R36",
		"facaAte" => "R36",	
		"fim" => "R36"
	},
	"67" => {
		"leia" => "R37",
		"escreva" => "R37",	
		"id" => "R37",	
		"se" => "R37",
		"facaAte" => "R37",	
		"fim" => "R37"
	},

	"68" => {
		"AB_P" => "S69"
	},	
	"69" => {
		"id" => "S49",
		"num" => "S50"
	},
	"70" => {
		"FC_P" => "S71"
	},
	"71" => {
		"fimfaca" => "S67",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"72" => {
		"leia" => "R33",
		"escreva" => "33",	
		"id" => "R33",	
		"se" => "R33",
		"facaAte" => "R33",	
		"fim" => "R33"
	},
	"73" => {
		"fimfaca" => "S67",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"74" => {
		"fimfaca" => "S67",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	},
	"75" => {
		"fimfaca" => "S67",
		"leia" => "S12",
		"escreva" => "S13",
		"id" => "S14",
		"se" => "S15"
	}
}