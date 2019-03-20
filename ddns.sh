#!/bin/bash

# Step 1: Fill in EMAIL, AUTH, ZONE_ID. Your API token is here: https://www.cloudflare.com/a/account/my-account
#         Make sure the token is the Global token, or has these permissions: #zone:read, #dns_record:read, #dns_records:edit
# Step 2: Create an A record on Cloudflare with the subdomain you chose
#         This step is optional, but will save you 2 requests every time you this script
# Step 3: Put arguments in the function put_dns(email, record_id)
# Step 4: Run "./ddns.sh". It should tell you that record was updated.
# Step 5: Run it every hour with cron.
#         0 * * * * /path/to/ddns.sh


EMAIL='example@gmail.com'
AUTH='auth'
ZONE_ID='zone_id'


EXTERNAL_IP=$(curl -s https://api.ipify.org)
echo $EXTERNAL_IP

function put_dns() {
  local domain="$1"
  local record_id="$2"

  curl -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$record_id" \
     -H "X-Auth-Email: $EMAIL" \
     -H "X-Auth-Key: $AUTH" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":'\"$domain\"',"content":'\"$EXTERNAL_IP\"',"ttl":120,"proxied":false}'

  echo ""
}

put_dns "domain.org" "record_id


exit 0