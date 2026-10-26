#!/bin/sh
# Live Robinhood Chain launch numbers over the last 24 hours, no key needed.
curl -s https://trnch.fun/api/bot/v1/stats
echo
# The same through MCP (JSON-RPC over HTTP).
curl -s https://trnch.fun/api/mcp \
  -H 'content-type: application/json' \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"trnch_stats","arguments":{}}}'
echo
