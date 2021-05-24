EYES=$(gem search -e eyes_selenium | grep eyes_selenium | grep -E -o "[0-9]+.[0-9]+.[0-9]+")
echo "eyes_selenium version: $EYES"
WATIR=$(gem search -e watir | grep watir | grep -E -o "[0-9]+.[0-9]+.[0-9]+" | head -1)
echo "watir version: $WATIR"
bundle remove eyes_selenium
bundle remove watir
bundle add eyes_selenium -v "$EYES"
bundle add watir -v "$WATIR"