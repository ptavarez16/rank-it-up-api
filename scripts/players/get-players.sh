# TOKEN="" sh scripts/players/get-players.sh

curl "http://localhost:4741/players" \
  --include \
  --request GET \
  --header "Authorization: Token token=${TOKEN}" \

echo
