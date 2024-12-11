#!/bin/bash

file=website_status.log

if ! [ -e "$file" ] ; then
    touch "$file"
fi

declare -a sites=("https://google.com" "https://facebook.com" "https://twitter.com")

for url in "${sites[@]}"
do
  while [ -n "${url}" ]
  do
      redirect_url=$(curl -Ls -o /dev/null -w %{url_effective} $url)
      if [[ "$redirect_url" != "$url" ]] ; then
        echo $url "redirects to" $redirect_url >> $file
        url=$redirect_url
      else
        break
      fi
  done

  status_code=$(curl --write-out %{http_code} --silent --output /dev/null $url)

  if [[ "$status_code" -ne 200 ]] ; then
    echo $url "is DOWN. Status code:" $status_code >> $file
  else
    echo $url "is UP" >> $file
  fi
done

echo "Log file" $file "created"
