#!/bin/bash

# Test script for Cloudinary webhook
# This simulates what Cloudinary sends when you upload an image

# Load your API secret from .env.development.local
# (In real life, Cloudinary knows this secret and uses it to sign requests)
source .env.development.local

# The fake webhook payload (simulating an upload notification)
PAYLOAD='{"notification_type":"upload","public_id":"test_image","resource_type":"image","tags":["gallery"]}'

# Current timestamp (Cloudinary includes this in the signature)
TIMESTAMP=$(date +%s)

# Compute the signature the same way Cloudinary does:
# SHA1(payload + timestamp + api_secret)
SIGNATURE=$(echo -n "${PAYLOAD}${TIMESTAMP}${CLOUDINARY_API_SECRET}" | sha1sum | cut -d' ' -f1)

echo "=== Cloudinary Webhook Test ==="
echo ""
echo "Payload: $PAYLOAD"
echo "Timestamp: $TIMESTAMP"
echo "Signature: $SIGNATURE"
echo ""
echo "Sending request to http://localhost:3000/cloudinary/webhooks ..."
echo ""

# curl breakdown:
#   -X POST                     → HTTP method (POST, GET, PUT, DELETE, etc.)
#   -H "Header: value"          → Add a header (we need 3: content-type + cloudinary's signature headers)
#   -d "$PAYLOAD"               → The request body (the JSON data)
#   -w "\nHTTP Status: %{http_code}\n"  → Print the status code after the response
#   -s                          → Silent mode (no progress bar)

curl -X POST http://localhost:3000/cloudinary/webhooks \
  -H "Content-Type: application/json" \
  -H "X-Cld-Signature: $SIGNATURE" \
  -H "X-Cld-Timestamp: $TIMESTAMP" \
  -d "$PAYLOAD" \
  -w "\nHTTP Status: %{http_code}\n" \
  -s

echo ""
echo "=== Done ==="
echo ""
echo "Check your Rails logs for:"
echo "  - 'Cloudinary webhook received: upload'"
echo "  - 'Gallery cache invalidated via Cloudinary webhook'"
