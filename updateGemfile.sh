echo "Current Gemfile"
echo "----------start-----------"
cat Gemfile
echo "-----------end------------"
EYES=$(gem search -e eyes_selenium | grep eyes_selenium | grep -E -o "[0-9]+.[0-9]+.[0-9]+")
echo "eyes_selenium version: $EYES"
WATIR=$(gem search -e watir | grep watir | grep -E -o "[0-9]+.[0-9]+.[0-9]+" | head -1)
echo "watir version: $WATIR"
echo "source 'https://rubygems.org'

gem \"eyes_selenium\", \"= $EYES\"
gem \"watir\", \"= $WATIR\"" > Gemfile