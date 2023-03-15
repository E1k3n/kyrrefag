# Paste URL below
URL="https://discord.com/api/webhooks/1072508325700325438/-e6yvrANyKDACFMWNFkb5IuanSeBJjQrb8i0h5RolJeiqG8QGf8JRcSLz6Bw4EUqhPY3"


RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info () {
echo -e "${CYAN}$1${NC}"
}

error () {
echo -e "${RED}$1${NC}"
}

warn () {
echo -e "${YELLOW}$1${NC}"
}

ok () {
echo -e "${GREEN}$1${NC}"
}

discord_log () {

message="$1"

USERNAME="Logger [$HOSTNAME] ${0##*/}"

JSON="{\"username\": \"$USERNAME\", \"content\": \"$message\"}"

curl -s -X POST -H "Content-Type: application/json" -d "$JSON" $URL

}

discord_log "test for alle penga!"