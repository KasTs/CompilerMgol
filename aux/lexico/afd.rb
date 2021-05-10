@afd = Hash.new

@afd = {
	"Q0" => { 
		"LETRA" => "Q7",
		"DIGITO" => "Q1",
		"ASPAS" => "Q8",
		"+" => "Q19",
		"-" => "Q19",
		"*" => "Q19",
		"/" => "Q19",
		"<" => "Q13",
		">" => "Q16",
		"=" => "Q12",
		"(" => "Q20",
		")" => "Q21",
		";" => "Q22",
		"," => "Q23",
		"{" => "Q10",
		"FINAL" => false,
	},
	"Q1" => {
		"DIGITO" => "Q1",
		"." => "Q2",
		"FINAL" => true,
		"CLASSE" => "num"
	},
	"Q2" => {
		"DIGITO" => "Q3",
		"FINAL" => false
	},
	"Q3" => {
		"DIGITO" => "Q3",
		"Ee" => "Q4",
		"FINAL" => true,
		"CLASSE" => "num"
	},
	"Q4" => {
		"DIGITO" => "Q5",
		"+" => "Q6",
		"-" => "Q6",
		"FINAL" => false,
	},
	"Q5" => {
		"FINAL" => true,
		"CLASSE" => "num"
	},
	"Q6" => {
		"DIGITO" => "Q5",
		"FINAL" => false
	},
	"Q7" => {
		"LETRA" => "Q7",
		"DIGITO" => "Q7",
		"_" => "Q7",
		"FINAL" => true,
		"CLASSE" => "id"
	},
	"Q8" => {
		"ASPAS" => "Q9",
		"FINAL" => false
	},
	"Q9" => {
		"FINAL" => true,
		"CLASSE" => "lit"
	},
	"Q10" => {
		"}" => "Q11",
		"FINAL" => false
	},
	"Q11" => {
		"FINAL" => true,
		"CLASSE" => "Comentário"
	},
	"Q12" => {
		"FINAL" => true,
		"CLASSE" => "OPR"
	},
	"Q13" => {
		">" => "Q15",
		"=" => "Q15",
		"-" => "Q14",
		"FINAL" => true,
		"CLASSE" => "OPR"
	},
	"Q14" => {
		"FINAL" => true,
		"CLASSE" => "RCB"
	},
	"Q15" => {
		"FINAL" => true,
		"CLASSE" => "OPR"
	},
	"Q16" => {
		"=" => "Q17",
		"FINAL" => true,
		"CLASSE" => "OPR"
	},
	"Q17" => {
		"FINAL" => true,
		"CLASSE" => "OPR"
	},
	"Q18" => {
		"FINAL" => true,
		"CLASSE" => "EOF"
	},
	"Q19" => {
		"FINAL" => true,
		"CLASSE" => "OPM"
	},
	"Q20" => {
		"FINAL" => true,
		"CLASSE" => "AB_P"		
	},
	"Q21" => {
		"FINAL" => true,
		"CLASSE" => "FC_P"	
	},
	"Q22" => {
		"FINAL" => true,
		"CLASSE" => "PT_V"
	},
	"Q23" => {
		"FINAL" => true,
		"CLASSE" => "VIR"
	}
}