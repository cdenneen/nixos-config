# functions
#█▓▒░ 1password
function 1pwaccount() {
	domain="${3:-my}.1password.com"
	op account add \
		--address "$domain" \
		--email "$2" \
		--shorthand "$1"
}
function 1pwsignin() {
	# muliuser fun times
	echo "unlock your keychain 🔐"
	read -rs _pw
	if [[ -n "$_pw" ]]; then
		printf "logging in: "
		accounts=("${(f)$(op account list | tail -n +2 | cut -d' ' -f1)}")
		for acct in "${accounts[@]}" ;do
			printf "%s " "$acct"
			eval $(echo "$_pw" | op signin --account "$acct")
		done
		echo
	fi
}
function 1pwcheck() {
	[[ -z "$(op vault user list private --account $1 2>/dev/null)" ]] && 1pwsignin || return true
}
function 1pw() {
	f="${3:-notesPlain}"
	[[ "$2" =~ "^http" ]] && i=$(1pwurl "$2") || i="$2"
	1pwcheck "$1" && op item get "$i" --account "$1" --fields "$f" --format json | jq -rM '.value'
}
function 1pwedit() {
	[[ -z "$4" ]] && { read val; } || { val=$4; }
	1pwcheck "$1" && op item edit --account "$1" "$2" "${3}=${val}"
}
function 1pwfile() {
	f="${4:-notesPlain}"
	1pwcheck "$1" && op --account "$1" read "op://$2/$3/$f"
}
function 1pweditfile() {
	1pwcheck "$1" && op item edit --account "$1" "$2" "files.[file]=$3"
}
function 1pwurl() {
	echo "$1" | sed 's/^.*i=//;s/\&.*$//'
}
