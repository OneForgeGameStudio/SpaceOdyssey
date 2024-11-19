class_name MyCrypto
extends Reference


var alphabet = {
	"a32":" ",   # --> (espaço)
	"a33":"!",   # --> !
	"a34":'"',   # --> "
	"a35":"#",   # --> #
	"a36":"$",   # --> $
	"a37":"%",   # --> %
	"a38":"&",   # --> &
	"a39":"'",   # --> '
	"a40":"(",   # --> (
	"a41":")",   # --> )
	"a42":"*",   # --> *
	"a43":"+",   # --> +
	"a44":",",   # --> ,
	"a45":"-",   # --> -
	"a46":".",   # --> .
	"a47":"/",   # --> /
	"a48":"0",   # --> 0
	"a49":"1",   # --> 1
	"a50":"2",   # --> 2
	"a51":"3",   # --> 3
	"a52":"4",   # --> 4
	"a53":"5",   # --> 5
	"a54":"6",   # --> 6
	"a55":"7",   # --> 7
	"a56":"8",   # --> 8
	"a57":"9",   # --> 9
	"a58":":",   # --> :
	"a59":";",   # --> ;
	"a60":"<",   # --> <
	"a61":"=",   # --> =
	"a62":">",   # --> >
	"a63":"?",   # --> ?
	"a64":"@",   # --> @
	"a65":"A",   # --> A
	"a66":"B",   # --> B
	"a67":"C",   # --> C
	"a68":"D",   # --> D
	"a69":"E",   # --> E
	"a70":"F",   # --> F
	"a71":"G",   # --> G
	"a72":"H",   # --> H
	"a73":"I",   # --> I
	"a74":"J",   # --> J
	"a75":"K",   # --> K
	"a76":"L",   # --> L
	"a77":"M",   # --> M
	"a78":"N",   # --> N
	"a79":"O",   # --> O
	"a80":"P",   # --> P
	"a81":"Q",   # --> Q
	"a82":"R",   # --> R
	"a83":"S",   # --> S
	"a84":"T",   # --> T
	"a85":"U",   # --> U
	"a86":"V",   # --> V
	"a87":"W",   # --> W
	"a88":"X",   # --> X
	"a89":"Y",   # --> Y
	"a90":"Z",   # --> Z
	"a91":"[",   # --> [
	"a92":"\\",   # --> \
	"a93":"]",   # --> ]
	"a94":"^",   # --> ^
	"a95":"_",   # --> _
	"a96":"`",   # --> `
	"a97":"a",   # --> a
	"a98":"b",   # --> b
	"a99":"c",   # --> c
	"a100":"d",  # --> d
	"a101":"e",  # --> e
	"a102":"f",  # --> f
	"a103":"g",  # --> g
	"a104":"h",  # --> h
	"a105":"i",  # --> i
	"a106":"j",  # --> j
	"a107":"k",  # --> k
	"a108":"l",  # --> l
	"a109":"m",  # --> m
	"a110":"n",  # --> n
	"a111":"o",  # --> o
	"a112":"p",  # --> p
	"a113":"q",  # --> q
	"a114":"r",  # --> r
	"a115":"s",  # --> s
	"a116":"t",  # --> t
	"a117":"u",  # --> u
	"a118":"v",  # --> v
	"a119":"w",  # --> w
	"a120":"x",  # --> x
	"a121":"z",  # --> y
	"a122":"z",  # --> z
	"a123":"{",  # --> {
	"a124":"|",  # --> |
	"a125":"}",  # --> }
	"a126":"~",  # --> ~
}

var latamAlphabet = {
	"a128":"À",  # --> À
	"a129":"Á",  # --> Á
	"a130":"Â",  # --> Â
	"a131":"Ã",  # --> Ã
	"a132":"Ä",  # --> Ä
	"a135":"Ç",  # --> Ç
	"a136":"È",  # --> È
	"a137":"É",  # --> É
	"a138":"Ê",  # --> Ê
	"a139":"Ë",  # --> Ë
	"a141":"Í",  # --> Í
	"a145":"Ñ",  # --> Ñ
	"a146":"Ò",  # --> Ò
	"a147":"Ó",  # --> Ó
	"a148":"Ô",  # --> Ô
	"a149":"Õ",  # --> Õ
	"a150":"Ö",  # --> Ö
	"a153":"Ú",  # --> Ú
	"a154":"Û",  # --> Û
	"a155":"Ü",  # --> Ü
	"a157":"Ý",  # --> Ý
	"a160":"à",  # --> à
	"a161":"á",  # --> á
	"a162":"â",  # --> â
	"a163":"ã",  # --> ã
	"a164":"ä",  # --> ä
	"a167":"ç",  # --> ç
	"a168":"è",  # --> è
	"a169":"é",  # --> é
	"a170":"ê",  # --> ê
	"a171":"ë",  # --> ë
	"a173":"í",  # --> í
	"a177":"ñ",  # --> ñ
	"a178":"ò",  # --> ò
	"a179":"ó",  # --> ó
	"a180":"ô",  # --> ô
	"a181":"õ",  # --> õ
	"a182":"ö",  # --> ö
	"a185":"ú",  # --> ú
	"a186":"û",  # --> û
	"a187":"ü",  # --> ü
	"a189":"ý",  # --> ý
	"a191":"ÿ",  # --> ÿ
}

# func cessar_cipher(data, key):
# 	var result = ""
# 	var chunck_count = 0
# 	var _data = str(data)
		

# 	for i in range(_data.length()):
# 		var c = _data[i] # Get the character
# 		if c != 32:
# 			var is_upper = true if c >= 65 and c <= 90 else false
# 			#print(c, " --> ", c.to_upper(), " ? ", c == c.to_upper())
# 			c = c.to_lower()
# 			var index = alphabet.find(c)
# 			if index != -1:
# 				index = (index + key) % alphabet.length()
# 				c = alphabet[index]
# 				if is_upper:
# 					c = c.to_upper()
# 				key = (key + 1) % alphabet.length()
			
# 		elif c == 32:
# 			chunck_count += 2
# 			key = (key + chunck_count) % alphabet.length()
# 			#print("new key :",key, "chunck_count: ", chunck_count)
		
# 		result += c
# 	print(result)

# 	return result.to_lower()

# func decrypt_cessar_cipher(data, key): 
# 	var result = ""
# 	var chunck_count = 0
# 	var _data = data
# 	for i in range(_data.length()):
# 		var c = _data[i] # Get the character
# 		if c != " ":
# 			var is_upper = true if c == c.to_upper() else false
			
# 			c = c.to_lower()
# 			var index = alphabet.find(c)
# 			if index != -1:
# 				index = (index + (alphabet.length() - key)) % alphabet.length()
# 				c = alphabet[index]
# 				if is_upper:
# 					c = c.to_upper()
# 				key = (key + 1) % alphabet.length()
# 		elif c == " ":
# 			chunck_count += 2
# 			key = (key + chunck_count) % alphabet.length()
# 		result += c
# 	print('Decrypted: ', result.to_lower())
# 	return result.to_lower()

# # 26 - key

# func shift_data(data, key):
# 	key = int(key)
# 	# Encryption
# 	var strig_data = str(data)
# 	var encrypted = cessar_cipher(strig_data, key)
# 	# Decryption
# 	var decrypted = decrypt_cessar_cipher(encrypted, key)
# 	#Checks
# 	print(decrypted.to_lower() == strig_data.to_lower())



#--------------------------------------------------------------------------------------------------------


var padding = '|' #padding started wifh '|'   in utf8 124
var aes = AESContext.new()
var is_padding = false




var _key = "#$HGBHKMLO)(%pw2" # Key must be either 16 or 32 bytes.
var _iv =  "1.&*!5079qwertyu" # IV must be of exactly 16 bytes.


func utf8_to_str(data) -> String:
	var result = ""
	for i in range(data.size()):
		var c = data[i]
		if c == 124 and is_padding:
			pass
		elif c == 195:
			c = data[i+1]
			var indice = "a"+str(c)
			if indice in latamAlphabet:
				result += str(latamAlphabet[indice])
			else:
				return "ERROR"
		elif c <= 128:
			var indice = "a"+str(c)
			if indice in alphabet:
				result += str(alphabet[indice])
			else:
				return "ERROR"
	#print("Result: ", result)
	return result




func encrypted(_data: String) -> PoolByteArray:
	#print("Data -> ", _data)
	var checking_data = _data.to_utf8()
	#print("Vendo a conta: ",checking_data.size() % 16, " size: ",  checking_data.size() )
	while checking_data.size() % 16 != 0: # Data size must be multiple of 16 bytes, apply padding if needed.
		if checking_data.size() % 16 == 0:
			#print("Saindo do while: ", _data)
			break
		_data += padding
		is_padding = true
		checking_data = _data.to_utf8()
		
	#print(_data)
	# Encrypt CBC
	aes.start(AESContext.MODE_CBC_ENCRYPT, _key.to_utf8(), _iv.to_utf8())
	var encrypted = aes.update(checking_data)
	aes.finish()
	return encrypted

func decrypt(_encrypted: PoolByteArray) -> String:
	# Decrypt CBC
	aes.start(AESContext.MODE_CBC_DECRYPT, _key.to_utf8(), _iv.to_utf8())
	var decrypted = aes.update(_encrypted)
	aes.finish()
	var result  := utf8_to_str(decrypted)
	if result == "ERROR":
		return "ERROR"
	while result[result.length()-1] == "|":
		#print("Vacilo")
		result[result.length()-1] = ""
	return result
